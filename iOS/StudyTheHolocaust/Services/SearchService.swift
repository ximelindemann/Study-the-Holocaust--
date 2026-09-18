import Foundation

class SearchService {
    static func search(query: String, in perpetrators: [Perpetrator]) -> [Perpetrator] {
        guard !query.isEmpty else { return perpetrators }
        let lowercaseQuery = query.lowercased()

        return perpetrators.filter { perpetrator in
            perpetrator.name.lowercased().contains(lowercaseQuery) ||
            perpetrator.role.lowercased().contains(lowercaseQuery) ||
            perpetrator.organization.lowercased().contains(lowercaseQuery) ||
            perpetrator.biography.lowercased().contains(lowercaseQuery)
        }
    }

    static func search(query: String, in legislation: [Legislation]) -> [Legislation] {
        guard !query.isEmpty else { return legislation }
        let lowercaseQuery = query.lowercased()

        return legislation.filter { law in
            law.title.lowercased().contains(lowercaseQuery) ||
            law.description.lowercased().contains(lowercaseQuery) ||
            law.type.lowercased().contains(lowercaseQuery)
        }
    }

    static func filterLegislationByYear(from startYear: Int, to endYear: Int, in legislation: [Legislation]) -> [Legislation] {
        legislation.filter { $0.year >= startYear && $0.year <= endYear }
    }

    static func filterPerpetratorsBy(organization: String, in perpetrators: [Perpetrator]) -> [Perpetrator] {
        perpetrators.filter { $0.organization.lowercased() == organization.lowercased() }
    }
}
