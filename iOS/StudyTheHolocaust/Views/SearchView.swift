import SwiftUI

struct SearchView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var searchText = ""

    var filteredPerpetrators: [Perpetrator] {
        guard !searchText.isEmpty else { return [] }
        return SearchService.search(query: searchText, in: dataManager.perpetrators)
    }

    var filteredLegislation: [Legislation] {
        guard !searchText.isEmpty else { return [] }
        return SearchService.search(query: searchText, in: dataManager.legislation)
    }

    var hasResults: Bool {
        !filteredPerpetrators.isEmpty || !filteredLegislation.isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText)
                    .padding()

                if searchText.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("Buscar")
                            .font(.headline)
                        Text("Escribe para buscar perpetradores, leyes y más")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                } else if !hasResults {
                    VStack(spacing: 12) {
                        Image(systemName: "magnifyingglass.circle")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("Sin resultados")
                            .font(.headline)
                        Text("No se encontró '\(searchText)'")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            // Perpetrators
                            if !filteredPerpetrators.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Perpetradores (\(filteredPerpetrators.count))")
                                        .font(.headline)

                                    VStack(spacing: 8) {
                                        ForEach(filteredPerpetrators.prefix(5)) { perpetrator in
                                            NavigationLink(destination: PerpetratorsDetailView(perpetrator: perpetrator)) {
                                                SearchResultRow(
                                                    title: perpetrator.name,
                                                    subtitle: perpetrator.role,
                                                    icon: "person.fill"
                                                )
                                            }
                                        }
                                    }

                                    if filteredPerpetrators.count > 5 {
                                        Text("Ver todos (\(filteredPerpetrators.count))")
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }

                            // Legislation
                            if !filteredLegislation.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Legislación (\(filteredLegislation.count))")
                                        .font(.headline)

                                    VStack(spacing: 8) {
                                        ForEach(filteredLegislation.prefix(5)) { legislation in
                                            NavigationLink(destination: LegislationDetailView(legislation: legislation)) {
                                                SearchResultRow(
                                                    title: legislation.title,
                                                    subtitle: "\(legislation.year) • \(legislation.type)",
                                                    icon: "doc.text.fill"
                                                )
                                            }
                                        }
                                    }

                                    if filteredLegislation.count > 5 {
                                        Text("Ver todos (\(filteredLegislation.count))")
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Buscar")
        }
    }
}

struct SearchResultRow: View {
    let title: String
    let subtitle: String
    let icon: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
            .environmentObject(DataManager.shared)
    }
}
