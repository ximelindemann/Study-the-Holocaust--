import SwiftUI

struct DocumentariesView: View {
    @State private var documentaries: [Documentary] = []
    @State private var selectedType: String? = nil
    @State private var searchText: String = ""

    private var filteredDocumentaries: [Documentary] {
        documentaries.filter { documentary in
            let matchesType = selectedType == nil || documentary.type.rawValue == selectedType
            let matchesSearch = searchText.isEmpty ||
                documentary.title.localizedCaseInsensitiveContains(searchText) ||
                (documentary.director?.localizedCaseInsensitiveContains(searchText) ?? false)
            return matchesType && matchesSearch
        }
    }

    private var types: [String] {
        Array(Set(documentaries.map { $0.type.rawValue })).sorted()
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText)
                    .padding()

                // Type filter
                if !types.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            if selectedType != nil {
                                Button(action: { selectedType = nil }) {
                                    Text("Todos")
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(6)
                                }
                            }

                            ForEach(types, id: \.self) { type in
                                Button(action: { selectedType = type }) {
                                    Text(type)
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(selectedType == type ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedType == type ? .white : .primary)
                                        .cornerRadius(6)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                }

                // Documentaries list
                if filteredDocumentaries.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "film")
                            .font(.system(size: 32))
                            .foregroundColor(.secondary)
                        Text("No hay documentales disponibles")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List(filteredDocumentaries) { documentary in
                        NavigationLink(destination: DocumentaryDetailView(documentary: documentary)) {
                            DocumentaryRowView(documentary: documentary)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Documentales")
            .onAppear {
                loadDocumentaries()
            }
        }
    }

    private func loadDocumentaries() {
        if let data = try? Data(contentsOf: Bundle.main.url(forResource: "data", withExtension: "json")!),
           let decoded = try? JSONDecoder().decode([String: [Documentary]].self, from: data),
           let documentariesData = decoded["documentaries"] {
            documentaries = documentariesData
        }
    }
}

struct DocumentaryRowView: View {
    let documentary: Documentary

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                // Type badge
                HStack(spacing: 4) {
                    Image(systemName: documentary.type.icon)
                    Text(documentary.type.rawValue)
                }
                .font(.caption.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.7))
                .cornerRadius(4)

                // Year
                Text("\(documentary.releaseYear)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(4)

                Spacer()

                // Duration
                if let duration = documentary.duration {
                    HStack(spacing: 2) {
                        Image(systemName: "clock")
                        Text("\(duration) min")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            // Title
            Text(documentary.title)
                .font(.headline)
                .lineLimit(2)

            // Director
            if let director = documentary.director {
                Text("Dir. \(director)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // Description
            Text(documentary.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

#Preview {
    DocumentariesView()
}
