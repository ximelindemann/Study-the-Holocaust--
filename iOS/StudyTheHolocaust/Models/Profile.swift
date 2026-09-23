import Foundation

struct Profile: Codable, Identifiable {
    let id: String
    let name: String
    let profileType: ProfileType
    let birthDate: String?
    let deathDate: String?
    let birthPlace: String?
    let biography: String
    let significance: String
    let imageURL: String?
    let sources: [String]

    enum ProfileType: String, Codable, CaseIterable {
        case survivor = "Sobreviviente"
        case rescuer = "Rescatador"
        case perpetrator = "Perpetrador"
        case leader = "Líder"

        var icon: String {
            switch self {
            case .survivor: return "person.badge.clock"
            case .rescuer: return "heart.fill"
            case .perpetrator: return "exclamationmark.triangle.fill"
            case .leader: return "person.fill"
            }
        }

        var color: String {
            switch self {
            case .survivor: return "FF9500"
            case .rescuer: return "34C759"
            case .perpetrator: return "FF3B30"
            case .leader: return "5856D6"
            }
        }
    }
}
