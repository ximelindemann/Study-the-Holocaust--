import SwiftUI

struct PerpetratorsDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    let perpetrator: Perpetrator

    @State private var isBookmarked = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(perpetrator.name)
                        .font(.title.bold())
                    Text(perpetrator.role)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))

                // Basic Info
                VStack(spacing: 12) {
                    InfoRow(label: "Nacimiento", value: perpetrator.birthDate)
                    if let deathDate = perpetrator.deathDate {
                        InfoRow(label: "Muerte", value: deathDate)
                    }
                    InfoRow(label: "Lugar de nacimiento", value: perpetrator.birthPlace)
                    InfoRow(label: "Organización", value: perpetrator.organization)
                }
                .padding()

                Divider()

                // Biography
                VStack(alignment: .leading, spacing: 12) {
                    Text("Biografía")
                        .font(.headline)
                    Text(perpetrator.biography)
                        .font(.body)
                        .lineLimit(nil)
                }
                .padding()

                Divider()

                // Charges
                if !perpetrator.charges.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Cargos")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(perpetrator.charges, id: \.self) { charge in
                                Label(charge, systemImage: "exclamationmark.circle.fill")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding()

                    Divider()
                }

                // Fate
                VStack(alignment: .leading, spacing: 12) {
                    Text("Destino")
                        .font(.headline)
                    Text(perpetrator.fate)
                        .font(.body)
                }
                .padding()

                Divider()

                // Sources
                if !perpetrator.sources.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Fuentes")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(perpetrator.sources, id: \.self) { source in
                                Label(source, systemImage: "doc.text.fill")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                }

                Spacer()
            }
        }
        .navigationTitle(perpetrator.name)
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
            isBookmarked = dataManager.isBookmarked(itemId: perpetrator.id, itemType: "perpetrator")
        }
    }

    private func toggleBookmark() {
        dataManager.toggleBookmark(itemId: perpetrator.id, itemType: "perpetrator")
        isBookmarked.toggle()
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    NavigationStack {
        PerpetratorsDetailView(
            perpetrator: Perpetrator(
                id: "test",
                name: "Test Perpetrator",
                birthDate: "1900",
                deathDate: "1950",
                birthPlace: "Somewhere",
                role: "Role",
                organization: "Org",
                biography: "Bio",
                imageURL: nil,
                charges: ["Charge1", "Charge2"],
                fate: "Fate",
                sources: ["Source1"]
            )
        )
        .environmentObject(DataManager.shared)
    }
}
