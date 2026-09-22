import SwiftUI

struct QuestionView: View {
    let quiz: Quiz
    @EnvironmentObject var viewModel: QuizViewModel
    @State private var showExplanation = false
    @State private var selectedAnswerIndex: Int?

    var currentQuestion: Question? {
        viewModel.getCurrentQuestion()
    }

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                ProgressView(value: viewModel.getProgress())
                    .frame(height: 4)
                    .tint(.blue)

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        HStack {
                            Text("Pregunta \(viewModel.currentQuestionIndex + 1) de \(quiz.questions.count)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Spacer()

                            HStack(spacing: 4) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("\(viewModel.getCorrectCount())")
                                    .font(.subheadline.weight(.semibold))
                            }
                        }
                        .padding()

                        if let question = currentQuestion {
                            VStack(alignment: .leading, spacing: 20) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(question.text)
                                        .font(.headline)
                                        .lineSpacing(2)

                                    HStack(spacing: 8) {
                                        Text(question.difficulty.rawValue)
                                            .font(.caption.weight(.semibold))
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(difficultyColor(question.difficulty))
                                            .foregroundColor(.white)
                                            .cornerRadius(4)

                                        Spacer()
                                    }
                                }

                                Divider()

                                VStack(spacing: 12) {
                                    ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                                        OptionButton(
                                            option: option,
                                            isSelected: selectedAnswerIndex == index || viewModel.selectedAnswers[viewModel.currentQuestionIndex] == index,
                                            isCorrect: index == question.correctAnswerIndex && showExplanation,
                                            isIncorrect: selectedAnswerIndex == index && showExplanation && index != question.correctAnswerIndex
                                        ) {
                                            if !showExplanation {
                                                selectedAnswerIndex = index
                                                viewModel.selectAnswer(index)
                                            }
                                        }
                                    }
                                }

                                if showExplanation {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Image(systemName: "lightbulb.fill")
                                                .foregroundColor(.orange)
                                            Text("Explicación")
                                                .font(.subheadline.weight(.semibold))
                                        }

                                        Text(question.explanation)
                                            .font(.body)
                                            .lineSpacing(2)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                }
                            }
                            .padding()
                        }
                    }
                }

                VStack(spacing: 12) {
                    if !showExplanation && selectedAnswerIndex != nil {
                        Button(action: { showExplanation = true }) {
                            HStack {
                                Image(systemName: "checkmark")
                                Text("Verificar Respuesta")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }

                    HStack(spacing: 12) {
                        if viewModel.currentQuestionIndex > 0 {
                            Button(action: {
                                viewModel.previousQuestion()
                                showExplanation = false
                                selectedAnswerIndex = nil
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Anterior")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray6))
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                            }
                        }

                        if viewModel.currentQuestionIndex < quiz.questions.count - 1 {
                            Button(action: {
                                if showExplanation {
                                    viewModel.nextQuestion()
                                    showExplanation = false
                                    selectedAnswerIndex = nil
                                }
                            }) {
                                HStack {
                                    Text("Siguiente")
                                    Image(systemName: "chevron.right")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(showExplanation ? Color.blue : Color(.systemGray6))
                                .foregroundColor(showExplanation ? .white : .blue)
                                .cornerRadius(8)
                            }
                            .disabled(!showExplanation)
                        }

                        if viewModel.currentQuestionIndex == quiz.questions.count - 1 {
                            NavigationLink(destination: ResultsView(quiz: quiz)) {
                                HStack {
                                    Text("Finalizar")
                                    Image(systemName: "checkmark.circle.fill")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(showExplanation ? Color.green : Color(.systemGray6))
                                .foregroundColor(showExplanation ? .white : .blue)
                                .cornerRadius(8)
                            }
                            .disabled(!showExplanation)
                            .onAppear {
                                viewModel.finishQuiz()
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(false)
    }

    private func difficultyColor(_ difficulty: Quiz.DifficultyLevel) -> Color {
        switch difficulty {
        case .beginner: return .green
        case .intermediate: return .orange
        case .advanced: return .red
        }
    }
}

struct OptionButton: View {
    let option: String
    let isSelected: Bool
    let isCorrect: Bool
    let isIncorrect: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else if isIncorrect {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                } else {
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 20, height: 20)
                }

                Text(option)
                    .font(.body)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(backgroundColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: isSelected && !isCorrect && !isIncorrect ? 2 : 0)
            )
        }
        .disabled(isCorrect || isIncorrect)
    }

    var backgroundColor: Color {
        if isCorrect {
            return Color.green.opacity(0.1)
        } else if isIncorrect {
            return Color.red.opacity(0.1)
        } else if isSelected {
            return Color.blue.opacity(0.1)
        } else {
            return Color(.systemGray6)
        }
    }

    var borderColor: Color {
        isSelected ? .blue : .clear
    }
}

#Preview {
    NavigationStack {
        QuestionView(quiz: Quiz(
            id: "preview",
            title: "Test",
            description: "Test",
            category: .perpetrators,
            difficulty: .beginner,
            questions: [
                Question(
                    id: "q1",
                    text: "¿Cuál era el cargo de Adolf Hitler?",
                    options: ["Presidente", "Canciller", "General", "Senador"],
                    correctAnswerIndex: 1,
                    explanation: "Hitler fue Canciller del Reich.",
                    difficulty: .beginner
                )
            ],
            passingScore: 70
        ))
        .environmentObject(QuizViewModel())
    }
}
