import Foundation

struct TimelineEvent: Identifiable, Codable {
    let id: String
    let title: String
    let date: String
    let day: Int
    let month: Int
    let year: Int
    let description: String
    let category: EventCategory
    let significance: String
    let consequences: String
    let imageURL: String?
    let relatedLocations: [String]
    let relatedPerpetrators: [String]
    let sources: [String]

    enum EventCategory: String, Codable, CaseIterable {
        case legislation = "Legislación"
        case violence = "Violencia de masas"
        case military = "Militar"
        case resistance = "Resistencia"
        case liberation = "Liberación"
        case trial = "Juicios"
        case memorial = "Memoria"

        var color: String {
            switch self {
            case .legislation: return "FF8C00"
            case .violence: return "DC143C"
            case .military: return "4169E1"
            case .resistance: return "32CD32"
            case .liberation: return "FFD700"
            case .trial: return "9370DB"
            case .memorial: return "20B2AA"
            }
        }

        var icon: String {
            switch self {
            case .legislation: return "doc.text"
            case .violence: return "exclamationmark.triangle"
            case .military: return "airplane"
            case .resistance: return "fist.closed"
            case .liberation: return "flag"
            case .trial: return "gavel"
            case .memorial: return "square.and.pencil"
            }
        }
    }
}

struct TimelineEventsResponse: Codable {
    let events: [TimelineEvent]
}
