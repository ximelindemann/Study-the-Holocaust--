import Foundation

struct Quiz: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let category: QuizCategory
    let difficulty: DifficultyLevel
    let questions: [Question]
    let passingScore: Int

    enum QuizCategory: String, Codable, CaseIterable {
        case perpetrators = "Perpetradores"
        case legislation = "Legislación"
        case camps = "Campos"
        case timeline = "Timeline"
        case general = "General"

        var icon: String {
            switch self {
            case .perpetrators: return "person.fill"
            case .legislation: return "doc.text"
            case .camps: return "building.2"
            case .timeline: return "calendar"
            case .general: return "book"
            }
        }

        var color: String {
            switch self {
            case .perpetrators: return "FF6B6B"
            case .legislation: return "FFA500"
            case .camps: return "DC143C"
            case .timeline: return "4169E1"
            case .general: return "9370DB"
            }
        }
    }

    enum DifficultyLevel: String, Codable, CaseIterable {
        case beginner = "Básico"
        case intermediate = "Intermedio"
        case advanced = "Avanzado"

        var value: Int {
            switch self {
            case .beginner: return 1
            case .intermediate: return 2
            case .advanced: return 3
            }
        }
    }
}

struct Question: Identifiable, Codable {
    let id: String
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String
    let difficulty: Quiz.DifficultyLevel

    func isCorrect(selectedIndex: Int) -> Bool {
        selectedIndex == correctAnswerIndex
    }
}

struct QuizzesResponse: Codable {
    let quizzes: [Quiz]
}

struct QuizResult: Identifiable, Codable {
    let id: String
    let quizId: String
    let quizTitle: String
    let score: Int
    let totalQuestions: Int
    let correctAnswers: Int
    let timestamp: Date
    let difficulty: Quiz.DifficultyLevel

    var percentage: Int {
        (correctAnswers * 100) / totalQuestions
    }

    var passed: Bool {
        percentage >= 70
    }
}
