import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    let profile: Profile

    @State private var isBookmarked = false

    var profileColor: Color {
        Color(hex: profile.profileType.color)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Profile header
                VStack(spacing: 16) {
                    // Avatar
                    ZStack {
                        Circle()
                            .fill(profileColor.opacity(0.2))
                            .frame(width: 120, height: 120)

                        Image(systemName: profile.profileType.icon)
                            .font(.system(size: 50))
                            .foregroundColor(profileColor)
                    }

                    VStack(alignment: .center, spacing: 12) {
                        Text(profile.name)
                            .font(.title2.bold())

                        // Type badge
                        HStack(spacing: 4) {
                            Image(systemName: profile.profileType.icon)
                            Text(profile.profileType.rawValue)
                        }
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(profileColor)
                        .cornerRadius(6)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Biographical information
                VStack(alignment: .leading, spacing: 12) {
                    Text("Información Personal")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        if let birthDate = profile.birthDate {
                            HStack(alignment: .top) {
                                Text("Nacimiento:")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .frame(width: 80, alignment: .leading)
                                Text(birthDate)
                                    .font(.caption.bold())
                            }
                        }

                        if let deathDate = profile.deathDate {
                            HStack(alignment: .top) {
                                Text("Fallecimiento:")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .frame(width: 80, alignment: .leading)
                                Text(deathDate)
                                    .font(.caption.bold())
                            }
                        }

                        if let birthPlace = profile.birthPlace {
                            HStack(alignment: .top) {
                                Text("Lugar:")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .frame(width: 80, alignment: .leading)
                                Text(birthPlace)
                                    .font(.caption.bold())
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Biography
                VStack(alignment: .leading, spacing: 12) {
                    Text("Biografía")
                        .font(.headline)

                    Text(profile.biography)
                        .font(.body)
                        .lineSpacing(1.5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Significance
                VStack(alignment: .leading, spacing: 12) {
                    Text("Significancia Histórica")
                        .font(.headline)

                    Text(profile.significance)
                        .font(.body)
                        .lineSpacing(1.5)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Sources
                if !profile.sources.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Fuentes")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(profile.sources, id: \.self) { source in
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
        .navigationTitle("Perfil")
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
            isBookmarked = dataManager.isBookmarked(itemId: profile.id, itemType: "profile")
        }
    }

    private func toggleBookmark() {
        dataManager.toggleBookmark(itemId: profile.id, itemType: "profile")
        isBookmarked.toggle()
    }
}

#Preview {
    NavigationStack {
        ProfileDetailView(profile: Profile(
            id: "test",
            name: "Test Person",
            profileType: .survivor,
            birthDate: "1920-01-01",
            deathDate: "1990-01-01",
            birthPlace: "Test Place",
            biography: "A test biography",
            significance: "Test significance",
            imageURL: nil,
            sources: ["Source 1"]
        ))
        .environmentObject(DataManager.shared)
    }
}
