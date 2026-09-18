import Foundation

struct Perpetrator: Identifiable, Codable {
    let id: String
    let name: String
    let birthDate: String
    let deathDate: String?
    let birthPlace: String
    let role: String
    let organization: String
    let biography: String
    let imageURL: String?
    let charges: [String]
    let fate: String
    let sources: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, birthDate, deathDate, birthPlace, role, organization, biography, imageURL, charges, fate, sources
    }
}

struct PerpetratorsResponse: Codable {
    let perpetrators: [Perpetrator]
}
