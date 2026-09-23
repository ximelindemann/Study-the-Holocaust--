import SwiftUI

struct ArticleDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    let article: Article

    @State private var isBookmarked = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Hero image
                if let imageURL = article.imageURL {
                    RemoteImage(urlString: imageURL, height: 250)
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .frame(height: 250)
                        .overlay(
                            Image(systemName: "doc.text.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.secondary)
                        )
                }

                VStack(alignment: .leading, spacing: 12) {
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
                        .font(.title2.bold())

                    // Meta information
                    VStack(alignment: .leading, spacing: 6) {
                        if let author = article.author {
                            HStack {
                                Image(systemName: "person.fill")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(author)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }

                        if let date = article.date {
                            HStack {
                                Image(systemName: "calendar")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(formatDate(date))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Content
                VStack(alignment: .leading, spacing: 12) {
                    Text("Contenido")
                        .font(.headline)

                    Text(article.content)
                        .font(.body)
                        .lineSpacing(1.5)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Related topics
                if !article.relatedTopics.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Temas Relacionados")
                            .font(.headline)

                        FlowLayout(spacing: 8) {
                            ForEach(article.relatedTopics, id: \.self) { topic in
                                Text(topic)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.2))
                                    .foregroundColor(.blue)
                                    .cornerRadius(6)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                // Sources
                if !article.sources.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Fuentes")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(article.sources, id: \.self) { source in
                                HStack(alignment: .top) {
                                    Image(systemName: "doc.text.fill")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .padding(.top, 2)

                                    Text(source)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(nil)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Artículo")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: toggleBookmark) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.blue)
                }
            }
        }
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

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.replacingUnspecifiedDimensions().width
        var height: CGFloat = 0
        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if rowWidth + size.width > maxWidth {
                height += rowHeight + spacing
                rowWidth = 0
                rowHeight = 0
            }
            rowWidth += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }

        height += rowHeight
        return CGSize(width: maxWidth, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX {
                y += rowHeight + spacing
                x = bounds.minX
                rowHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

#Preview {
    NavigationStack {
        ArticleDetailView(article: Article(
            id: "test",
            title: "Test Article",
            category: "Test",
            date: "2024-01-01",
            author: "Test Author",
            content: "This is a test article content.",
            summary: "Test summary",
            imageURL: nil,
            sources: ["Source 1", "Source 2"],
            relatedTopics: ["Topic 1", "Topic 2"]
        ))
        .environmentObject(DataManager.shared)
    }
}
