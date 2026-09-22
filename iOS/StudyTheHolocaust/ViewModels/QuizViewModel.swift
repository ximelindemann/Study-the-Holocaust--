import Foundation

class QuizViewModel: ObservableObject {
    @Published var quizzes: [Quiz] = []
    @Published var currentQuiz: Quiz?
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswers: [Int] = []
    @Published var quizResults: [QuizResult] = []
    @Published var showResults = false
    @Published var selectedCategory: Quiz.QuizCategory?
    @Published var selectedDifficulty: Quiz.DifficultyLevel?

    private let resultsKey = "quiz_results"

    init() {
        loadResults()
    }

    func updateQuizzes(_ quizzes: [Quiz]) {
        self.quizzes = quizzes
    }

    func startQuiz(_ quiz: Quiz) {
        self.currentQuiz = quiz
        self.currentQuestionIndex = 0
        self.selectedAnswers = Array(repeating: -1, count: quiz.questions.count)
        self.showResults = false
    }

    func selectAnswer(_ optionIndex: Int) {
        guard currentQuestionIndex < selectedAnswers.count else { return }
        selectedAnswers[currentQuestionIndex] = optionIndex
    }

    func nextQuestion() {
        guard let quiz = currentQuiz else { return }
        if currentQuestionIndex < quiz.questions.count - 1 {
            currentQuestionIndex += 1
        }
    }

    func previousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }

    func finishQuiz() {
        guard let quiz = currentQuiz else { return }

        let correctCount = selectedAnswers.enumerated().reduce(0) { count, pair in
            let (index, selectedIndex) = pair
            if selectedIndex >= 0 && selectedIndex == quiz.questions[index].correctAnswerIndex {
                return count + 1
            }
            return count
        }

        let result = QuizResult(
            id: UUID().uuidString,
            quizId: quiz.id,
            quizTitle: quiz.title,
            score: (correctCount * 100) / quiz.questions.count,
            totalQuestions: quiz.questions.count,
            correctAnswers: correctCount,
            timestamp: Date(),
            difficulty: quiz.difficulty
        )

        quizResults.append(result)
        saveResults()
        showResults = true
    }

    func getFilteredQuizzes() -> [Quiz] {
        var filtered = quizzes

        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }

        if let difficulty = selectedDifficulty {
            filtered = filtered.filter { $0.difficulty == difficulty }
        }

        return filtered
    }

    func getCurrentQuestion() -> Question? {
        guard let quiz = currentQuiz,
              currentQuestionIndex < quiz.questions.count else {
            return nil
        }
        return quiz.questions[currentQuestionIndex]
    }

    func getProgress() -> Double {
        guard let quiz = currentQuiz else { return 0 }
        return Double(currentQuestionIndex + 1) / Double(quiz.questions.count)
    }

    func getCorrectCount() -> Int {
        let correctCount = selectedAnswers.enumerated().reduce(0) { count, pair in
            let (index, selectedIndex) = pair
            guard let quiz = currentQuiz,
                  index < quiz.questions.count,
                  selectedIndex >= 0 else { return count }

            if selectedIndex == quiz.questions[index].correctAnswerIndex {
                return count + 1
            }
            return count
        }
        return correctCount
    }

    func resetQuiz() {
        currentQuiz = nil
        currentQuestionIndex = 0
        selectedAnswers = []
        showResults = false
    }

    func getAverageScore() -> Int {
        guard !quizResults.isEmpty else { return 0 }
        return quizResults.map { $0.score }.reduce(0, +) / quizResults.count
    }

    func getTotalQuizzesTaken() -> Int {
        quizResults.count
    }

    private func saveResults() {
        if let encoded = try? JSONEncoder().encode(quizResults) {
            UserDefaults.standard.set(encoded, forKey: resultsKey)
        }
    }

    private func loadResults() {
        if let data = UserDefaults.standard.data(forKey: resultsKey),
           let decoded = try? JSONDecoder().decode([QuizResult].self, from: data) {
            self.quizResults = decoded
        }
    }
}
