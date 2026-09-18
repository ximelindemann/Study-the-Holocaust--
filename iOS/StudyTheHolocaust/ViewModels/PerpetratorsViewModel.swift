import Foundation

class PerpetratorsViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredPerpetrators: [Perpetrator] = []
    @Published var selectedOrganization: String?

    private var allPerpetrators: [Perpetrator] = []

    init(perpetrators: [Perpetrator] = []) {
        self.allPerpetrators = perpetrators
        self.filteredPerpetrators = perpetrators
    }

    func updatePerpetrators(_ perpetrators: [Perpetrator]) {
        self.allPerpetrators = perpetrators
        filterPerpetrators()
    }

    func filterPerpetrators() {
        var results = allPerpetrators

        if !searchText.isEmpty {
            results = SearchService.search(query: searchText, in: results)
        }

        if let organization = selectedOrganization, !organization.isEmpty {
            results = SearchService.filterPerpetratorsBy(organization: organization, in: results)
        }

        self.filteredPerpetrators = results
    }

    func getUniqueOrganizations() -> [String] {
        Array(Set(allPerpetrators.map { $0.organization })).sorted()
    }
}
