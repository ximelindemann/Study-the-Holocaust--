import Foundation

struct HolocaustStatistics: Codable {
    let totalVictims: Int
    let jewishVictims: Int
    let otherVictims: [VictimGroup]
    let victimsByCountry: [CountryVictims]
    let victimsByCamp: [CampVictims]
    let victimsByYear: [YearVictims]
    let perpetratorsByRole: [RoleStatistics]
    let ghettos: GhettoStatistics
    let camps: CampStatistics
    let resistance: ResistanceStatistics
}

struct VictimGroup: Codable, Identifiable {
    let id = UUID()
    let group: String
    let count: Int
    let percentage: Double

    enum CodingKeys: String, CodingKey {
        case group, count, percentage
    }
}

struct CountryVictims: Codable, Identifiable {
    let id = UUID()
    let country: String
    let victims: Int
    let percentage: Double

    enum CodingKeys: String, CodingKey {
        case country, victims, percentage
    }
}

struct CampVictims: Codable, Identifiable {
    let id = UUID()
    let camp: String
    let victims: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case camp, victims, type
    }
}

struct YearVictims: Codable, Identifiable {
    let id = UUID()
    let year: Int
    let victims: Int

    enum CodingKeys: String, CodingKey {
        case year, victims
    }
}

struct RoleStatistics: Codable, Identifiable {
    let id = UUID()
    let role: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case role, count
    }
}

struct GhettoStatistics: Codable {
    let totalGhettos: Int
    let largestGhetto: String
    let largestGhettoPopulation: Int
    let totalGhettoVictims: Int
}

struct CampStatistics: Codable {
    let totalCamps: Int
    let concentrationCamps: Int
    let exterminationCamps: Int
    let totalCampVictims: Int
    let largestCamp: String
}

struct ResistanceStatistics: Codable {
    let uprisings: Int
    let escapes: Int
    let rescuedByNonJews: Int
    let countriesThatResisted: Int
}
