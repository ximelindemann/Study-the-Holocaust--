import Foundation

class LegislationViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredLegislation: [Legislation] = []
    @Published var startYear = 1933
    @Published var endYear = 1945

    private var allLegislation: [Legislation] = []
    private let minYear = 1933
    private let maxYear = 1945

    init(legislation: [Legislation] = []) {
        self.allLegislation = legislation
        self.filteredLegislation = legislation
    }

    func updateLegislation(_ legislation: [Legislation]) {
        self.allLegislation = legislation
        filterLegislation()
    }

    func filterLegislation() {
        var results = allLegislation

        results = SearchService.filterLegislationByYear(from: startYear, to: endYear, in: results)

        if !searchText.isEmpty {
            results = SearchService.search(query: searchText, in: results)
        }

        self.filteredLegislation = results.sorted { $0.year < $1.year }
    }

    func getMinYear() -> Int { minYear }
    func getMaxYear() -> Int { maxYear }
}
