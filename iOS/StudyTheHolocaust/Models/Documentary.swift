import Foundation

struct Documentary: Codable, Identifiable {
    let id: String
    let title: String
    let type: DocumentaryType
    let duration: Int? // minutes
    let releaseYear: Int
    let director: String?
    let description: String
    let educationalValue: String
    let language: String
    let availability: String
    let sources: [String]

    enum DocumentaryType: String, Codable, CaseIterable {
        case documentary = "Documental"
        case film = "Película"
        case series = "Serie"
        case interview = "Entrevista"

        var icon: String {
            switch self {
            case .documentary: return "film.fill"
            case .film: return "movieclapper.fill"
            case .series: return "tv.fill"
            case .interview: return "person.wave.2"
            }
        }
    }
}
