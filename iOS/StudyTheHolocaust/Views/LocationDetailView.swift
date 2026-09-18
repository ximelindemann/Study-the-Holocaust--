import SwiftUI
import MapKit

struct LocationDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    let location: HistoricalLocation

    @State private var isBookmarked = false
    @State private var region: MKCoordinateRegion

    init(location: HistoricalLocation) {
        self.location = location
        _region = State(initialValue: MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        ))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Mini map
                Map(position: .constant(.region(region)))
                    .frame(height: 200)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )

                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(location.name)
                        .font(.title2.bold())

                    HStack(spacing: 12) {
                        Image(systemName: location.type.icon)
                            .foregroundColor(Color(hex: location.type.color))
                        Text(location.type.rawValue)
                            .font(.subheadline)
                            .foregroundColor(Color(hex: location.type.color))
                    }

                    Label(location.country, systemImage: "globe")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Key facts
                VStack(spacing: 12) {
                    if let established = location.establishedYear {
                        FactRow(label: "Establecido", value: "\(established)")
                    }
                    if let liberated = location.liberatedYear {
                        FactRow(label: "Liberado", value: "\(liberated)")
                    }
                    if let casualties = location.casualties {
                        FactRow(
                            label: "Víctimas documentadas",
                            value: String(format: "%,d", casualties)
                        )
                    }
                    FactRow(label: "Estado actual", value: location.currentStatus)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Description
                VStack(alignment: .leading, spacing: 12) {
                    Text("Descripción")
                        .font(.headline)
                    Text(location.description)
                        .font(.body)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Historical Significance
                VStack(alignment: .leading, spacing: 12) {
                    Text("Significancia Histórica")
                        .font(.headline)
                    Text(location.historicalSignificance)
                        .font(.body)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Operators
                if !location.operators.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Mando")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(location.operators, id: \.self) { op in
                                Label(op, systemImage: "person.fill")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                // Sources
                if !location.sources.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Fuentes")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(location.sources, id: \.self) { source in
                                Label(source, systemImage: "doc.text.fill")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
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
        .navigationTitle(location.name)
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
            isBookmarked = dataManager.isBookmarked(itemId: location.id, itemType: "location")
        }
    }

    private func toggleBookmark() {
        dataManager.toggleBookmark(itemId: location.id, itemType: "location")
        isBookmarked.toggle()
    }
}

struct FactRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline.weight(.semibold))
        }
    }
}

#Preview {
    NavigationStack {
        LocationDetailView(
            location: HistoricalLocation(
                id: "auschwitz",
                name: "Auschwitz-Birkenau",
                type: .exterminationCamp,
                latitude: 50.0305,
                longitude: 19.1736,
                country: "Polonia",
                establishedYear: 1940,
                liberatedYear: 1945,
                description: "El mayor campo de exterminio nazi.",
                casualties: 1100000,
                operators: ["Comandante: Rudolf Höss"],
                currentStatus: "Sitio Patrimonio de la UNESCO",
                historicalSignificance: "Símbolo del Holocausto",
                imageURL: nil,
                sources: ["Archivos de Auschwitz"]
            )
        )
        .environmentObject(DataManager.shared)
    }
}
