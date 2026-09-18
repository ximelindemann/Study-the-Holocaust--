import Foundation

class BookmarksViewModel: ObservableObject {
    @Published var bookmarkedPerpetrators: [Perpetrator] = []
    @Published var bookmarkedLegislation: [Legislation] = []

    private let dataManager = DataManager.shared
    private var allPerpetrators: [Perpetrator] = []
    private var allLegislation: [Legislation] = []

    init() {
        updateBookmarkedItems()
    }

    func updateData(perpetrators: [Perpetrator], legislation: [Legislation]) {
        self.allPerpetrators = perpetrators
        self.allLegislation = legislation
        updateBookmarkedItems()
    }

    func updateBookmarkedItems() {
        bookmarkedPerpetrators = allPerpetrators.filter { perpetrator in
            dataManager.isBookmarked(itemId: perpetrator.id, itemType: "perpetrator")
        }

        bookmarkedLegislation = allLegislation.filter { legislation in
            dataManager.isBookmarked(itemId: legislation.id, itemType: "legislation")
        }
    }

    func toggleBookmark(perpetrator: Perpetrator) {
        dataManager.toggleBookmark(itemId: perpetrator.id, itemType: "perpetrator")
        updateBookmarkedItems()
    }

    func toggleBookmark(legislation: Legislation) {
        dataManager.toggleBookmark(itemId: legislation.id, itemType: "legislation")
        updateBookmarkedItems()
    }
}
