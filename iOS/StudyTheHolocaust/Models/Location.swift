import Foundation
import CoreLocation

struct HistoricalLocation: Identifiable, Codable {
    let id: String
    let name: String
    let type: LocationType
    let latitude: Double
    let longitude: Double
    let country: String
    let establishedYear: Int?
    let liberatedYear: Int?
    let description: String
    let casualties: Int?
    let operators: [String]
    let currentStatus: String
    let historicalSignificance: String
    let imageURL: String?
    let sources: [String]

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    enum LocationType: String, Codable, CaseIterable {
        case concentrationCamp = "Campo de Concentración"
        case exterminationCamp = "Campo de Exterminio"
        case ghetto = "Gueto"
        case einsatzgruppenArea = "Área de Einsatzgruppen"
        case memorial = "Memorial"
        case museum = "Museo"
        case resistanceLocation = "Ubicación de Resistencia"
        case rescueLocation = "Ubicación de Rescate"

        var color: String {
            switch self {
            case .concentrationCamp: return "FF6B6B"
            case .exterminationCamp: return "CC0000"
            case .ghetto: return "FFA500"
            case .einsatzgruppenArea: return "8B0000"
            case .memorial: return "4169E1"
            case .museum: return "6495ED"
            case .resistanceLocation: return "32CD32"
            case .rescueLocation: return "FFD700"
            }
        }

        var icon: String {
            switch self {
            case .concentrationCamp: return "building.2"
            case .exterminationCamp: return "xmark.circle"
            case .ghetto: return "house"
            case .einsatzgruppenArea: return "map"
            case .memorial: return "square.and.pencil"
            case .museum: return "books"
            case .resistanceLocation: return "fist.closed"
            case .rescueLocation: return "heart"
            }
        }
    }
}

struct LocationsResponse: Codable {
    let locations: [HistoricalLocation]
}
