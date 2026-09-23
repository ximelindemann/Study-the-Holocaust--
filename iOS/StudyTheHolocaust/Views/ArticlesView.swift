import SwiftUI

struct ArticlesView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var articles: [Article] = []
    @State private var selectedCategory: String? = nil
    @State private var searchText: String = ""

    private var filteredArticles: [Article] {
        articles.filter { article in
            let matchesCategory = selectedCategory == nil || article.category == selectedCategory
            let matchesSearch = searchText.isEmpty ||
                article.title.localizedCaseInsensitiveContains(searchText) ||
                article.summary.localizedCaseInsensitiveContains(searchText)
            return matchesCategory && matchesSearch
        }
    }

    private var categories: [String] {
        Array(Set(articles.map { $0.category })).sorted()
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText)
                    .padding()

                // Category filter
                if !categories.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            if selectedCategory != nil {
                                Button(action: { selectedCategory = nil }) {
                                    Text("Todos")
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(6)
                                }
                            }

                            ForEach(categories, id: \.self) { category in
                                Button(action: { selectedCategory = category }) {
                                    Text(category)
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedCategory == category ? .white : .primary)
                                        .cornerRadius(6)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                }

                // Articles list
                if filteredArticles.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "doc.text")
                            .font(.system(size: 32))
                            .foregroundColor(.secondary)
                        Text("No hay artículos disponibles")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List(filteredArticles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleRowView(article: article)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Artículos")
            .onAppear {
                loadArticles()
            }
        }
    }

    private func loadArticles() {
        if let data = try? Data(contentsOf: Bundle.main.url(forResource: "data", withExtension: "json")!),
           let decoded = try? JSONDecoder().decode([String: [Article]].self, from: data),
           let articlesData = decoded["articles"] {
            articles = articlesData
        }
    }
}

struct ArticleRowView: View {
    let article: Article
    @EnvironmentObject var dataManager: DataManager
    @State private var isBookmarked = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Category badge
            Text(article.category)
                .font(.caption.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.7))
                .cornerRadius(4)

            // Title
            Text(article.title)
                .font(.headline)
                .lineLimit(2)

            // Summary
            Text(article.summary)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)

            // Footer with date and bookmark
            HStack {
                if let date = article.date {
                    Text(formatDate(date))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button(action: toggleBookmark) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .onAppear {
            isBookmarked = dataManager.isBookmarked(itemId: article.id, itemType: "article")
        }
    }

    private func toggleBookmark() {
        dataManager.toggleBookmark(itemId: article.id, itemType: "article")
        isBookmarked.toggle()
    }

    private func formatDate(_ dateString: String) -> String {
        let components = dateString.split(separator: "-")
        if components.count == 3 {
            let months = ["01": "Enero", "02": "Febrero", "03": "Marzo", "04": "Abril",
                         "05": "Mayo", "06": "Junio", "07": "Julio", "08": "Agosto",
                         "09": "Septiembre", "10": "Octubre", "11": "Noviembre", "12": "Diciembre"]
            if let month = months[String(components[1])] {
                return "\(month) \(components[2]), \(components[0])"
            }
        }
        return dateString
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Buscar artículos", text: $text)
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

#Preview {
    ArticlesView()
        .environmentObject(DataManager.shared)
}
