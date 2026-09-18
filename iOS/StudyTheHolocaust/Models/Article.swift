import Foundation

struct Article: Identifiable, Codable {
    let id: String
    let title: String
    let category: String
    let date: String
    let author: String?
    let content: String
    let summary: String
    let imageURL: String?
    let sources: [String]
    let relatedTopics: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, category, date, author, content, summary, imageURL, sources, relatedTopics
    }
}

struct Bookmark: Identifiable, Codable {
    let id: String
    let itemId: String
    let itemType: String // "perpetrator", "legislation", "article"
    let timestamp: Date
}
