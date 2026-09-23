import SwiftUI

struct CampsView: View {
    @State private var camps: [Camp] = []
    @State private var selectedType: String? = nil
    @State private var selectedTerritory: String? = nil
    @State private var searchText: String = ""

    private var filteredCamps: [Camp] {
        camps.filter { camp in
            let matchesType = selectedType == nil || camp.type.rawValue == selectedType
            let matchesTerritory = selectedTerritory == nil || camp.territory == selectedTerritory
            let matchesSearch = searchText.isEmpty ||
                camp.name.localizedCaseInsensitiveContains(searchText) ||
                camp.location.localizedCaseInsensitiveContains(searchText)
            return matchesType && matchesTerritory && matchesSearch
        }
    }

    private var types: [String] {
        let allTypes = Camp.CampType.allCases.map { $0.rawValue }
        return allTypes.filter { type in
            camps.contains { $0.type.rawValue == type }
        }.sorted()
    }

    private var territories: [String] {
        Array(Set(camps.map { $0.territory })).sorted()
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

                // Territory filter
                if !territories.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            if selectedTerritory != nil {
                                Button(action: { selectedTerritory = nil }) {
                                    Text("Todos")
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(6)
                                }
                            }

                            ForEach(territories, id: \.self) { territory in
                                Button(action: { selectedTerritory = territory }) {
                                    Text(territory)
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(selectedTerritory == territory ? Color.green : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedTerritory == territory ? .white : .primary)
                                        .cornerRadius(6)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                }

                // Camps list
                if filteredCamps.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "building.2.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.secondary)
                        Text("No hay campos disponibles")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List(filteredCamps) { camp in
                        NavigationLink(destination: CampDetailView(camp: camp)) {
                            CampRowView(camp: camp)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Campos")
            .onAppear {
                loadCamps()
            }
        }
    }

    private func loadCamps() {
        if let data = try? Data(contentsOf: Bundle.main.url(forResource: "data", withExtension: "json")!),
           let decoded = try? JSONDecoder().decode([String: [Camp]].self, from: data),
           let campsData = decoded["camps"] {
            camps = campsData.sorted { $0.name < $1.name }
        }
    }
}

struct CampRowView: View {
    let camp: Camp

    var campColor: Color {
        Color(hex: camp.type.color)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Type badge
            HStack(spacing: 4) {
                Image(systemName: camp.type.icon)
                Text(camp.type.rawValue)
            }
            .font(.caption.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(campColor)
            .cornerRadius(4)

            // Name
            Text(camp.name)
                .font(.headline)

            // Location info
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Image(systemName: "mappin")
                        .font(.caption)
                    Text(camp.territory)
                        .font(.caption)
                }
                .foregroundColor(.secondary)

                HStack(spacing: 4) {
                    Image(systemName: "location")
                        .font(.caption)
                    Text(camp.location)
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }

            // Dates
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .font(.caption)
                    Text("Establecido: \(camp.established)")
                        .font(.caption)
                }
                .foregroundColor(.secondary)

                if let liberated = camp.liberated {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.caption)
                        Text("Liberado: \(liberated)")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                }
            }

            // Casualties
            if let deaths = camp.totalDeaths {
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.circle")
                        .font(.caption)
                        .foregroundColor(.red)
                    Text("\(deaths) vidas perdidas")
                        .font(.caption.bold())
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    CampsView()
}
