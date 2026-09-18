import Foundation

class DataManager: ObservableObject {
    static let shared = DataManager()

    @Published var perpetrators: [Perpetrator] = []
    @Published var legislation: [Legislation] = []
    @Published var articles: [Article] = []
    @Published var locations: [HistoricalLocation] = []
    @Published var bookmarks: [Bookmark] = []
    @Published var isLoading = false
    @Published var error: String?

    private let bookmarksKey = "bookmarks"

    init() {
        loadBookmarks()
        loadData()
    }

    func loadData() {
        isLoading = true

        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()

                if let perpetratorsData = try? decoder.decode(PerpetratorsResponse.self, from: data) {
                    self.perpetrators = perpetratorsData.perpetrators
                }
                if let legislationData = try? decoder.decode(LegislationResponse.self, from: data) {
                    self.legislation = legislationData.legislation
                }

                isLoading = false
                error = nil
            } catch {
                self.error = "Failed to load data: \(error.localizedDescription)"
                isLoading = false
            }
        } else {
            // Fallback: usar datos de ejemplo
            loadSampleData()
            isLoading = false
        }
    }

    private func loadSampleData() {
        perpetrators = [
            Perpetrator(
                id: "hitler",
                name: "Adolf Hitler",
                birthDate: "20 de abril de 1889",
                deathDate: "30 de abril de 1945",
                birthPlace: "Linz, Austria",
                role: "Führer, Canciller del Reich",
                organization: "NSDAP",
                biography: "Adolf Hitler fue el dictador de la Alemania nazi. Responsable de la iniciación del Holocausto y la Segunda Guerra Mundial.",
                imageURL: nil,
                charges: ["Crímenes de lesa humanidad", "Genocidio", "Crímenes de guerra"],
                fate: "Suicidio en Berlín",
                sources: ["Documentos históricos", "Testimonios de Núremberg"]
            )
        ]
    }

    func toggleBookmark(itemId: String, itemType: String) {
        if let index = bookmarks.firstIndex(where: { $0.itemId == itemId && $0.itemType == itemType }) {
            bookmarks.remove(at: index)
        } else {
            let bookmark = Bookmark(
                id: UUID().uuidString,
                itemId: itemId,
                itemType: itemType,
                timestamp: Date()
            )
            bookmarks.append(bookmark)
        }
        saveBookmarks()
    }

    func isBookmarked(itemId: String, itemType: String) -> Bool {
        bookmarks.contains { $0.itemId == itemId && $0.itemType == itemType }
    }

    private func saveBookmarks() {
        if let encoded = try? JSONEncoder().encode(bookmarks) {
            UserDefaults.standard.set(encoded, forKey: bookmarksKey)
        }
    }

    private func loadBookmarks() {
        if let data = UserDefaults.standard.data(forKey: bookmarksKey),
           let decoded = try? JSONDecoder().decode([Bookmark].self, from: data) {
            self.bookmarks = decoded
        }
    }
}
