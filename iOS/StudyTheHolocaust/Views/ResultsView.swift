import SwiftUI

struct ResultsView: View {
    let quiz: Quiz
    @EnvironmentObject var viewModel: QuizViewModel
    @Environment(\.dismiss) var dismiss

    var result: QuizResult? {
        viewModel.quizResults.last
    }

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            if let result = result, result.passed {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(.green)

                                Text("¡Felicidades!")
                                    .font(.title.weight(.bold))

                                Text("Has aprobado el quiz")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(.red)

                                Text("Quiz No Aprobado")
                                    .font(.title.weight(.bold))

                                Text("Intenta nuevamente para mejorar tu puntuación")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)

                        if let result = result {
                            VStack(spacing: 16) {
                                ScoreCard(
                                    label: "Puntuación Final",
                                    value: "\(result.score)%",
                                    icon: "percent"
                                )

                                HStack(spacing: 16) {
                                    ScoreCard(
                                        label: "Correctas",
                                        value: String(result.correctAnswers),
                                        icon: "checkmark.circle.fill",
                                        color: .green
                                    )

                                    ScoreCard(
                                        label: "Incorrectas",
                                        value: String(result.totalQuestions - result.correctAnswers),
                                        icon: "xmark.circle.fill",
                                        color: .red
                                    )
                                }

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Detalles del Quiz")
                                        .font(.headline)

                                    HStack {
                                        Label(result.quizTitle, systemImage: "book")
                                            .font(.subheadline)
                                        Spacer()
                                    }

                                    HStack {
                                        Label("Dificultad: \(result.difficulty.rawValue)", systemImage: difficultyIcon(result.difficulty))
                                            .font(.subheadline)
                                        Spacer()
                                    }

                                    HStack {
                                        Label("Para Aprobar: \(quiz.passingScore)%", systemImage: "checkmark.circle")
                                            .font(.subheadline)
                                        Spacer()
                                    }

                                    let formatter = DateFormatter()
                                    formatter.dateStyle = .medium
                                    formatter.timeStyle = .short

                                    HStack {
                                        Label(formatter.string(from: result.timestamp), systemImage: "clock")
                                            .font(.subheadline)
                                        Spacer()
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }

                            VStack(alignment: .leading, spacing: 12) {
                                Text("Pregunta por Pregunta")
                                    .font(.headline)

                                ForEach(Array(viewModel.selectedAnswers.enumerated()), id: \.offset) { index, selectedIndex in
                                    let question = quiz.questions[index]
                                    let isCorrect = selectedIndex == question.correctAnswerIndex

                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                                .foregroundColor(isCorrect ? .green : .red)

                                            Text("Pregunta \(index + 1)")
                                                .font(.subheadline.weight(.semibold))

                                            Spacer()
                                        }

                                        Text(question.text)
                                            .font(.subheadline)
                                            .lineLimit(2)

                                        if selectedIndex >= 0 && selectedIndex < question.options.count {
                                            HStack(spacing: 8) {
                                                Image(systemName: isCorrect ? "checkmark" : "xmark")
                                                    .font(.caption.weight(.semibold))
                                                    .foregroundColor(isCorrect ? .green : .red)

                                                Text("Tu respuesta: \(question.options[selectedIndex])")
                                                    .font(.caption)
                                                    .lineLimit(2)
                                            }

                                            if !isCorrect {
                                                HStack(spacing: 8) {
                                                    Image(systemName: "checkmark")
                                                        .font(.caption.weight(.semibold))
                                                        .foregroundColor(.green)

                                                    Text("Correcta: \(question.options[question.correctAnswerIndex])")
                                                        .font(.caption)
                                                        .lineLimit(2)
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                    .background(isCorrect ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding()
                }

                VStack(spacing: 12) {
                    NavigationLink(destination: QuizListView()) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Ver Todos los Quizzes")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }

                    Button(action: {
                        viewModel.resetQuiz()
                        dismiss()
                    }) {
                        Text("Volver al Inicio")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Resultados")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
    }

    private func difficultyIcon(_ difficulty: Quiz.DifficultyLevel) -> String {
        switch difficulty {
        case .beginner: return "1.circle"
        case .intermediate: return "2.circle"
        case .advanced: return "3.circle"
        }
    }
}

struct ScoreCard: View {
    let label: String
    let value: String
    let icon: String
    var color: Color = .blue

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(color)

            Text(value)
                .font(.title2.weight(.bold))

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

#Preview {
    NavigationStack {
        ResultsView(quiz: Quiz(
            id: "preview",
            title: "Test Quiz",
            description: "Test",
            category: .perpetrators,
            difficulty: .beginner,
            questions: [
                Question(
                    id: "q1",
                    text: "Question 1",
                    options: ["A", "B", "C", "D"],
                    correctAnswerIndex: 0,
                    explanation: "Explanation",
                    difficulty: .beginner
                )
            ],
            passingScore: 70
        ))
        .environmentObject(QuizViewModel())
    }
}
