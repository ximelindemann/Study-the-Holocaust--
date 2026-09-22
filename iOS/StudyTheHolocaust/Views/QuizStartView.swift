import SwiftUI

struct QuizStartView: View {
    let quiz: Quiz
    @EnvironmentObject var viewModel: QuizViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        HStack(spacing: 16) {
                            Image(systemName: quiz.category.icon)
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color(hex: quiz.category.color))
                                .cornerRadius(12)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(quiz.title)
                                    .font(.title2.weight(.bold))
                                Text(quiz.category.rawValue)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: 16) {
                            Label("Descripción", systemImage: "info.circle")
                                .font(.subheadline.weight(.semibold))

                            Text(quiz.description)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .lineSpacing(4)
                        }

                        Divider()

                        VStack(spacing: 16) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Dificultad")
                                        .font(.subheadline.weight(.semibold))
                                    Text(quiz.difficulty.rawValue)
                                        .font(.body)
                                        .foregroundColor(.blue)
                                }
                                Spacer()
                                Image(systemName: difficultyIcon(quiz.difficulty))
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Preguntas")
                                        .font(.subheadline.weight(.semibold))
                                    Text("\(quiz.questions.count) preguntas")
                                        .font(.body)
                                        .foregroundColor(.blue)
                                }
                                Spacer()
                                Image(systemName: "list.bullet")
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Para Aprobar")
                                        .font(.subheadline.weight(.semibold))
                                    Text("\(quiz.passingScore)% de aciertos")
                                        .font(.body)
                                        .foregroundColor(.blue)
                                }
                                Spacer()
                                Image(systemName: "checkmark.circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                }

                Spacer()

                VStack(spacing: 12) {
                    NavigationLink(destination: QuestionView(quiz: quiz)) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Comenzar Quiz")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .onAppear {
                        viewModel.startQuiz(quiz)
                    }

                    Button(action: { dismiss() }) {
                        Text("Cancelar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Detalles del Quiz")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemBackground))
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

#Preview {
    NavigationStack {
        QuizStartView(
            quiz: Quiz(
                id: "preview",
                title: "Test Quiz",
                description: "A test quiz for preview",
                category: .perpetrators,
                difficulty: .beginner,
                questions: [],
                passingScore: 70
            )
        )
        .environmentObject(DataManager.shared)
        .environmentObject(QuizViewModel())
    }
}
