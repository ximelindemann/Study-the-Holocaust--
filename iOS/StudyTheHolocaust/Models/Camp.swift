import Foundation

struct Camp: Codable, Identifiable {
    let id: String
    let name: String
    let type: CampType
    let territory: String
    let location: String
    let established: String
    let liberated: String?
    let totalDeaths: Int?
    let estimatedCasualties: String
    let operators: [String]
    let description: String
    let historicalSignificance: String
    let sources: [String]

    enum CampType: String, Codable, CaseIterable {
        case concentration = "Campo de Concentración"
        case extermination = "Campo de Exterminio"
        case forced_labor = "Campo de Trabajo Forzado"
        case transit = "Campo de Tránsito"

        var icon: String {
            switch self {
            case .concentration: return "building.2.fill"
            case .extermination: return "exclamationmark.triangle.fill"
            case .forced_labor: return "hammer.fill"
            case .transit: return "tram.fill"
            }
        }

        var color: String {
            switch self {
            case .concentration: return "FF9500"
            case .extermination: return "FF3B30"
            case .forced_labor: return "FFA500"
            case .transit: return "FFCC00"
            }
        }
    }
}
