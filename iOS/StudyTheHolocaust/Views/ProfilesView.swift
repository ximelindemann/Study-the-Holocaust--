import SwiftUI

struct ProfilesView: View {
    @State private var profiles: [Profile] = []
    @State private var selectedType: String? = nil
    @State private var searchText: String = ""

    private var filteredProfiles: [Profile] {
        profiles.filter { profile in
            let matchesType = selectedType == nil || profile.profileType.rawValue == selectedType
            let matchesSearch = searchText.isEmpty ||
                profile.name.localizedCaseInsensitiveContains(searchText)
            return matchesType && matchesSearch
        }
    }

    private var types: [String] {
        let allTypes = Profile.ProfileType.allCases.map { $0.rawValue }
        return allTypes.filter { type in
            profiles.contains { $0.profileType.rawValue == type }
        }.sorted()
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

                // Profiles list
                if filteredProfiles.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.secondary)
                        Text("No hay perfiles disponibles")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List(filteredProfiles) { profile in
                        NavigationLink(destination: ProfileDetailView(profile: profile)) {
                            ProfileRowView(profile: profile)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Perfiles")
            .onAppear {
                loadProfiles()
            }
        }
    }

    private func loadProfiles() {
        if let data = try? Data(contentsOf: Bundle.main.url(forResource: "data", withExtension: "json")!),
           let decoded = try? JSONDecoder().decode([String: [Profile]].self, from: data),
           let profilesData = decoded["profiles"] {
            profiles = profilesData
        }
    }
}

struct ProfileRowView: View {
    let profile: Profile

    var profileColor: Color {
        Color(hex: profile.profileType.color)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Type badge
            HStack(spacing: 4) {
                Image(systemName: profile.profileType.icon)
                Text(profile.profileType.rawValue)
            }
            .font(.caption.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(profileColor)
            .cornerRadius(4)

            // Name
            Text(profile.name)
                .font(.headline)

            // Dates
            VStack(alignment: .leading, spacing: 2) {
                if let birthDate = profile.birthDate {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.caption)
                        Text("Nace: \(birthDate)")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                }

                if let deathDate = profile.deathDate {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.caption)
                        Text("Muere: \(deathDate)")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                }
            }

            // Birthplace
            if let birthPlace = profile.birthPlace {
                HStack(spacing: 4) {
                    Image(systemName: "mappin")
                        .font(.caption)
                    Text(birthPlace)
                        .font(.caption)
                }
                .foregroundColor(.secondary)
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
    ProfilesView()
}
