import Foundation

struct Legislation: Identifiable, Codable {
    let id: String
    let title: String
    let date: String
    let year: Int
    let description: String
    let impact: String
    let type: String // "Discrimination", "Persecution", "Extermination"
    let sources: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, date, year, description, impact, type, sources
    }
}

struct LegislationResponse: Codable {
    let legislation: [Legislation]
}
