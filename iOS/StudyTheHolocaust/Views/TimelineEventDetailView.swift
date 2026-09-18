import SwiftUI

struct TimelineEventDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    let event: TimelineEvent

    @State private var isBookmarked = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: event.category.icon)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color(hex: event.category.color))
                            .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.category.rawValue)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(event.date)
                                .font(.subheadline.weight(.semibold))
                        }

                        Spacer()
                    }

                    Text(event.title)
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Description
                VStack(alignment: .leading, spacing: 12) {
                    Text("Descripción")
                        .font(.headline)
                    Text(event.description)
                        .font(.body)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Significance
                VStack(alignment: .leading, spacing: 12) {
                    Text("Significancia Histórica")
                        .font(.headline)
                    Text(event.significance)
                        .font(.body)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Consequences
                VStack(alignment: .leading, spacing: 12) {
                    Text("Consecuencias")
                        .font(.headline)
                    Text(event.consequences)
                        .font(.body)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Related Locations
                if !event.relatedLocations.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ubicaciones Relacionadas")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(event.relatedLocations, id: \.self) { location in
                                Label(location, systemImage: "location.fill")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                // Related Perpetrators
                if !event.relatedPerpetrators.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Perpetradores Involucrados")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(event.relatedPerpetrators, id: \.self) { perp in
                                Label(perp, systemImage: "person.fill")
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
                if !event.sources.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Fuentes")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(event.sources, id: \.self) { source in
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
        .navigationTitle(event.title)
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
            isBookmarked = dataManager.isBookmarked(itemId: event.id, itemType: "timeline_event")
        }
    }

    private func toggleBookmark() {
        dataManager.toggleBookmark(itemId: event.id, itemType: "timeline_event")
        isBookmarked.toggle()
    }
}

#Preview {
    NavigationStack {
        TimelineEventDetailView(
            event: TimelineEvent(
                id: "test",
                title: "Test Event",
                date: "1 de enero de 1945",
                day: 1,
                month: 1,
                year: 1945,
                description: "Test description",
                category: .liberation,
                significance: "Test significance",
                consequences: "Test consequences",
                imageURL: nil,
                relatedLocations: ["auschwitz"],
                relatedPerpetrators: ["hitler"],
                sources: ["Test source"]
            )
        )
        .environmentObject(DataManager.shared)
    }
}
