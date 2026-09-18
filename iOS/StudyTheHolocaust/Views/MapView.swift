import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject private var viewModel = MapViewModel()
    @State private var showFilters = false
    @State private var showLegend = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Map
                Map(position: .constant(.region(viewModel.mapRegion))) {
                    ForEach(viewModel.filteredLocations) { location in
                        Annotation("", coordinate: location.coordinate) {
                            LocationMapPin(location: location)
                                .onTapGesture {
                                    viewModel.selectLocation(location)
                                }
                        }
                    }
                }
                .mapStyle(.standard)
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header with controls
                    HStack(spacing: 12) {
                        Button(action: { showFilters.toggle() }) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 44, height: 44)
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 2)
                        }

                        Button(action: { showLegend.toggle() }) {
                            Image(systemName: "list.bullet")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 44, height: 44)
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 2)
                        }

                        Spacer()
                    }
                    .padding()

                    Spacer()

                    // Selected location info
                    if let selected = viewModel.selectedLocation {
                        LocationDetailCard(location: selected)
                            .transition(.move(edge: .bottom))
                    }
                }

                // Filters sheet
                if showFilters {
                    VStack {
                        Spacer()
                        FilterPanel(viewModel: viewModel)
                            .transition(.move(edge: .bottom))
                    }
                }

                // Legend
                if showLegend {
                    VStack {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Leyenda")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            ForEach(HistoricalLocation.LocationType.allCases, id: \.self) { type in
                                HStack(spacing: 12) {
                                    Image(systemName: type.icon)
                                        .font(.body)
                                        .foregroundColor(Color(hex: type.color))
                                        .frame(width: 24)

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(type.rawValue)
                                            .font(.subheadline.weight(.medium))
                                        Text("\(viewModel.getLocationsCount(for: type))")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }

                                    Spacer()
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding()

                        Spacer()
                    }
                }
            }
            .navigationTitle("Mapa Histórico")
            .onAppear {
                loadSampleLocations()
            }
        }
    }

    private func loadSampleLocations() {
        let sampleLocations = [
            HistoricalLocation(
                id: "auschwitz",
                name: "Auschwitz-Birkenau",
                type: .exterminationCamp,
                latitude: 50.0305,
                longitude: 19.1736,
                country: "Polonia",
                establishedYear: 1940,
                liberatedYear: 1945,
                description: "El mayor campo de exterminio nazi. Más de 1.1 millones de personas fueron asesinadas aquí, principalmente judíos.",
                casualties: 1100000,
                operators: ["Comandante: Rudolf Höss"],
                currentStatus: "Sitio Patrimonio de la UNESCO",
                historicalSignificance: "Símbolo del Holocausto",
                imageURL: nil,
                sources: ["Archivos de Auschwitz", "Testimonios de sobrevivientes"]
            ),
            HistoricalLocation(
                id: "treblinka",
                name: "Treblinka",
                type: .exterminationCamp,
                latitude: 52.6197,
                longitude: 22.0217,
                country: "Polonia",
                establishedYear: 1942,
                liberatedYear: 1943,
                description: "Campo de exterminio dedicado exclusivamente al asesinato. Aproximadamente 870,000 personas fueron asesinadas aquí.",
                casualties: 870000,
                operators: ["Comandante: Franz Stangl"],
                currentStatus: "Memorial",
                historicalSignificance: "Centro de la Solución Final",
                imageURL: nil,
                sources: ["Testimonios de Jankiel Wiernik", "Registros de la SS"]
            ),
            HistoricalLocation(
                id: "warsaw_ghetto",
                name: "Gueto de Varsovia",
                type: .ghetto,
                latitude: 52.2496,
                longitude: 21.0087,
                country: "Polonia",
                establishedYear: 1940,
                liberatedYear: 1945,
                description: "El gueto más grande de Europa. Confinaba a más de 400,000 judíos en un área de apenas 1.3 millas cuadradas.",
                casualties: 300000,
                operators: ["Gobernador: Hans Frank"],
                currentStatus: "Monumento",
                historicalSignificance: "Sitio del Levantamiento del Gueto (1943)",
                imageURL: nil,
                sources: ["Diarios del Gueto de Varsovia", "Testimonios de Jan Karski"]
            ),
            HistoricalLocation(
                id: "dachau",
                name: "Dachau",
                type: .concentrationCamp,
                latitude: 48.2699,
                longitude: 11.4958,
                country: "Alemania",
                establishedYear: 1933,
                liberatedYear: 1945,
                description: "Primer campo de concentración permanente. Sirvió como modelo para otros campos.",
                casualties: 32000,
                operators: ["Comandante: Theodor Eicke"],
                currentStatus: "Museo Memorial",
                historicalSignificance: "Prototipo del sistema de campos nazis",
                imageURL: nil,
                sources: ["Archivos de Dachau", "Testimonios de sobrevivientes"]
            ),
            HistoricalLocation(
                id: "berlin_memorial",
                name: "Memorial del Holocausto de Berlín",
                type: .memorial,
                latitude: 52.5139,
                longitude: 13.3915,
                country: "Alemania",
                establishedYear: 2005,
                liberatedYear: nil,
                description: "Memorial dedicado a los judíos asesinados de Europa. Consiste en 2,711 losas de concreto.",
                casualties: nil,
                operators: ["Arquitecto: Peter Eisenman"],
                currentStatus: "Sitio Patrimonio de la UNESCO",
                historicalSignificance: "Recordatorio permanente del Holocausto",
                imageURL: nil,
                sources: ["Fundación de la Memoria del Holocausto"]
            )
        ]
        viewModel.updateLocations(sampleLocations)
    }
}

struct LocationMapPin: View {
    let location: HistoricalLocation

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: location.type.icon)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(Color(hex: location.type.color))
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )

            Triangle()
                .fill(Color(hex: location.type.color))
                .frame(width: 12, height: 8)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

struct LocationDetailCard: View {
    @EnvironmentObject var dataManager: DataManager
    let location: HistoricalLocation

    @State private var isBookmarked = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(location.name)
                        .font(.headline)
                    HStack(spacing: 8) {
                        Label(location.country, systemImage: "location.fill")
                            .font(.caption)
                        Label(location.type.rawValue, systemImage: location.type.icon)
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                }

                Spacer()

                Button(action: toggleBookmark) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.blue)
                }
            }

            Text(location.description)
                .font(.subheadline)
                .lineLimit(3)

            HStack(spacing: 16) {
                if let casualties = location.casualties {
                    StatPill(label: "Víctimas", value: String(format: "%,d", casualties))
                }
                if let year = location.establishedYear {
                    StatPill(label: "Establecido", value: "\(year)")
                }
            }
            .font(.caption)

            HStack {
                Text("Ver detalles")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.blue)
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding()
        .onAppear {
            isBookmarked = dataManager.isBookmarked(itemId: location.id, itemType: "location")
        }
    }

    private func toggleBookmark() {
        dataManager.toggleBookmark(itemId: location.id, itemType: "location")
        isBookmarked.toggle()
    }
}

struct StatPill: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 2) {
            Text(label)
                .foregroundColor(.secondary)
            Text(value)
                .font(.caption.weight(.semibold))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(Color(.systemGray6))
        .cornerRadius(6)
    }
}

struct FilterPanel: View {
    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Filtros")
                    .font(.headline)
                Spacer()
                Button("Limpiar") {
                    viewModel.clearFilters()
                }
                .font(.caption)
                .foregroundColor(.blue)
            }

            VStack(spacing: 8) {
                ForEach(HistoricalLocation.LocationType.allCases, id: \.self) { type in
                    Toggle(isOn: Binding(
                        get: { viewModel.selectedFilters.contains(type) },
                        set: { _ in viewModel.toggleFilter(type) }
                    )) {
                        HStack(spacing: 8) {
                            Image(systemName: type.icon)
                                .foregroundColor(Color(hex: type.color))
                            Text(type.rawValue)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let rgb = Int(hex, radix: 16) ?? 0

        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0
        )
    }
}

#Preview {
    NavigationStack {
        MapView()
            .environmentObject(DataManager.shared)
    }
}
