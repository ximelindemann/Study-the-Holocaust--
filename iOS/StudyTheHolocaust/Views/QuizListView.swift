import SwiftUI

struct QuizListView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject private var viewModel = QuizViewModel()
    @State private var showFilters = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Stats Bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        StatCard(
                            label: "Quizzes",
                            value: String(viewModel.getTotalQuizzesTaken()),
                            icon: "checkmark.circle"
                        )
                        StatCard(
                            label: "Promedio",
                            value: "\(viewModel.getAverageScore())%",
                            icon: "star"
                        )
                        StatCard(
                            label: "Total",
                            value: String(viewModel.quizzes.count),
                            icon: "book"
                        )
                    }
                    .padding()
                }
                .background(Color(.systemGray6))

                // Filters
                HStack(spacing: 12) {
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }

                    if viewModel.selectedCategory != nil || viewModel.selectedDifficulty != nil {
                        Button(action: {
                            viewModel.selectedCategory = nil
                            viewModel.selectedDifficulty = nil
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()

                // Quiz List
                if viewModel.getFilteredQuizzes().isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("Sin quizzes")
                            .font(.headline)
                        Text("No hay quizzes disponibles")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                } else {
                    List {
                        ForEach(viewModel.getFilteredQuizzes()) { quiz in
                            NavigationLink(destination: QuizStartView(quiz: quiz)) {
                                QuizCard(quiz: quiz)
                            }
                        }
                    }
                    .listStyle(.plain)
                }

                // Filter Panel
                if showFilters {
                    VStack(spacing: 0) {
                        Divider()
                        FilterPanelQuiz(viewModel: viewModel)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
            .navigationTitle("Quiz")
            .onAppear {
                loadSampleQuizzes()
            }
        }
    }

    private func loadSampleQuizzes() {
        let sampleQuizzes = [
            Quiz(
                id: "quiz_1",
                title: "Perpetradores Nazis Básico",
                description: "Aprende sobre los líderes del Tercer Reich",
                category: .perpetrators,
                difficulty: .beginner,
                questions: generateBeginnerPerpetratorsQuestions(),
                passingScore: 70
            ),
            Quiz(
                id: "quiz_2",
                title: "Legislación Nazi",
                description: "Comprende las leyes persecutorias",
                category: .legislation,
                difficulty: .intermediate,
                questions: generateLegislationQuestions(),
                passingScore: 70
            ),
            Quiz(
                id: "quiz_3",
                title: "Campos de Concentración",
                description: "Conoce los campos principales",
                category: .camps,
                difficulty: .intermediate,
                questions: generateCampsQuestions(),
                passingScore: 70
            ),
            Quiz(
                id: "quiz_4",
                title: "Timeline Holocausto",
                description: "Ordena eventos históricos",
                category: .timeline,
                difficulty: .beginner,
                questions: generateTimelineQuestions(),
                passingScore: 70
            ),
            Quiz(
                id: "quiz_5",
                title: "Datos Generales IIGM",
                description: "Prueba tu conocimiento general",
                category: .general,
                difficulty: .advanced,
                questions: generateGeneralQuestions(),
                passingScore: 70
            )
        ]
        viewModel.updateQuizzes(sampleQuizzes)
    }

    private func generateBeginnerPerpetratorsQuestions() -> [Question] {
        [
            Question(
                id: "q1",
                text: "¿Cuál era el cargo de Adolf Hitler?",
                options: ["Presidente", "Canciller", "General", "Senador"],
                correctAnswerIndex: 1,
                explanation: "Adolf Hitler fue Canciller del Reich desde 1933 hasta su muerte en 1945.",
                difficulty: .beginner
            ),
            Question(
                id: "q2",
                text: "¿Quién fue el jefe de la SS?",
                options: ["Goebbels", "Himmler", "Göring", "Heydrich"],
                correctAnswerIndex: 1,
                explanation: "Heinrich Himmler fue el Reichsführer de la SS, el brazo paramilitar del Tercer Reich.",
                difficulty: .beginner
            ),
            Question(
                id: "q3",
                text: "¿Cuál era la responsabilidad de Goebbels?",
                options: ["Ejército", "Policía", "Propaganda", "Finanzas"],
                correctAnswerIndex: 2,
                explanation: "Joseph Goebbels fue Ministro de Propaganda e Ilustración Popular.",
                difficulty: .beginner
            ),
            Question(
                id: "q4",
                text: "¿En qué país nació Adolf Hitler?",
                options: ["Alemania", "Austria", "Hungría", "Polonia"],
                correctAnswerIndex: 1,
                explanation: "Hitler nació en Linz, Austria en 1889, antes de que Austria fuera anexada a Alemania.",
                difficulty: .beginner
            ),
            Question(
                id: "q5",
                text: "¿Quién fue Hermann Göring?",
                options: ["Comandante de la Luftwaffe", "Jefe de la Gestapo", "Viceführer", "Jefe del Ejército"],
                correctAnswerIndex: 0,
                explanation: "Hermann Göring fue el comandante de la Luftwaffe, la fuerza aérea nazi.",
                difficulty: .beginner
            ),
            Question(
                id: "q6",
                text: "¿Cuándo fue nombrado Hitler Canciller de Alemania?",
                options: ["1930", "1931", "1933", "1935"],
                correctAnswerIndex: 2,
                explanation: "Hitler fue nombrado Canciller de Alemania el 30 de enero de 1933.",
                difficulty: .beginner
            ),
            Question(
                id: "q7",
                text: "¿Cuál fue el destino de Adolf Hitler al final de la guerra?",
                options: ["Capturado por aliados", "Ejecutado públicamente", "Suicidio en el búnker", "Escapó a Argentina"],
                correctAnswerIndex: 2,
                explanation: "Hitler se suicidó en su búnker de Berlín el 30 de abril de 1945.",
                difficulty: .beginner
            ),
            Question(
                id: "q8",
                text: "¿Quién fue Rudolf Hess?",
                options: ["Ministro del Interior", "Viceführer del NSDAP", "Jefe de la Propaganda", "Comandante militar"],
                correctAnswerIndex: 1,
                explanation: "Rudolf Hess fue el Viceführer del NSDAP y cercano colaborador de Hitler.",
                difficulty: .beginner
            )
        ]
    }

    private func generateLegislationQuestions() -> [Question] {
        [
            Question(
                id: "lq1",
                text: "¿En qué año se promulgaron las Leyes de Núremberg?",
                options: ["1933", "1935", "1937", "1939"],
                correctAnswerIndex: 1,
                explanation: "Las Leyes de Núremberg se promulgaron el 15 de septiembre de 1935.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq2",
                text: "¿Qué hizo el Acta Habilitante de 1933?",
                options: [
                    "Prohibió los partidos políticos",
                    "Otorgó poderes dictatoriales a Hitler",
                    "Creó la Gestapo",
                    "Declaró la guerra"
                ],
                correctAnswerIndex: 1,
                explanation: "El Acta Habilitante transformó el gobierno democrático en una dictadura total.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq3",
                text: "¿Qué establecieron principalmente las Leyes de Núremberg?",
                options: [
                    "La creación de campos de concentración",
                    "La privación de ciudadanía a los judíos",
                    "La invasión de Polonia",
                    "La destrucción de sinagogas"
                ],
                correctAnswerIndex: 1,
                explanation: "Las Leyes de Núremberg privaron a los judíos de su ciudadanía alemana y prohibieron matrimonios mixtos.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq4",
                text: "¿Qué fue la Kristallnacht?",
                options: [
                    "Una ley sobre matrimonios",
                    "Un pogrom violento contra judíos en 1938",
                    "Una conferencia política",
                    "Una campaña de propaganda"
                ],
                correctAnswerIndex: 1,
                explanation: "La Kristallnacht fue la Noche de los Cristales Rotos, un pogrom coordinado el 9-10 de noviembre de 1938.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq5",
                text: "¿En qué año tuvo lugar la Conferencia de Wannsee?",
                options: ["1939", "1940", "1941", "1942"],
                correctAnswerIndex: 2,
                explanation: "La Conferencia de Wannsee fue el 20 de enero de 1941, donde se planeó la Solución Final.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq6",
                text: "¿Cuál era el propósito de la Conferencia de Wannsee?",
                options: [
                    "Negociar con las potencias aliadas",
                    "Planear la Solución Final",
                    "Organizar la invasión de Rusia",
                    "Crear nuevos campos de concentración"
                ],
                correctAnswerIndex: 1,
                explanation: "La Conferencia de Wannsee fue donde se coordinó el plan para el exterminio sistemático de los judíos europeos.",
                difficulty: .intermediate
            )
        ]
    }

    private func generateCampsQuestions() -> [Question] {
        [
            Question(
                id: "cq1",
                text: "¿Cuál fue el campo de exterminio más grande?",
                options: ["Treblinka", "Auschwitz", "Sobibor", "Belzec"],
                correctAnswerIndex: 1,
                explanation: "Auschwitz-Birkenau fue el más grande, con aproximadamente 1.1 millones de víctimas.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq2",
                text: "¿En qué país estaba ubicado Auschwitz?",
                options: ["Alemania", "Polonia", "Checoslovaquia", "Hungría"],
                correctAnswerIndex: 1,
                explanation: "Auschwitz-Birkenau estaba ubicado en Polonia, cerca de la ciudad de Oświęcim.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq3",
                text: "¿En qué año fue liberado Auschwitz?",
                options: ["1943", "1944", "1945", "1946"],
                correctAnswerIndex: 2,
                explanation: "Auschwitz fue liberado por tropas soviéticas el 27 de enero de 1945.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq4",
                text: "¿Cuántas víctimas aproximadamente murieron en Treblinka?",
                options: ["300,000", "600,000", "870,000", "1,100,000"],
                correctAnswerIndex: 2,
                explanation: "Aproximadamente 870,000 personas fueron asesinadas en Treblinka.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq5",
                text: "¿Cuál fue el primer campo de concentración permanente nazi?",
                options: ["Auschwitz", "Dachau", "Treblinka", "Sobibor"],
                correctAnswerIndex: 1,
                explanation: "Dachau fue el primer campo de concentración permanente, establecido en 1933.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq6",
                text: "¿Qué diferencia principal había entre campos de concentración y campos de exterminio?",
                options: [
                    "Los campos de exterminio eran más pequeños",
                    "Los campos de exterminio estaban diseñados específicamente para matar",
                    "Los campos de concentración tenían más guardias",
                    "No había diferencia real"
                ],
                correctAnswerIndex: 1,
                explanation: "Los campos de exterminio como Auschwitz-Birkenau y Treblinka estaban específicamente diseñados y equipados para el asesinato masivo sistemático.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq7",
                text: "¿Quién fue el comandante de Auschwitz?",
                options: ["Franz Stangl", "Rudolf Höss", "Theodor Eicke", "Oswald Pohl"],
                correctAnswerIndex: 1,
                explanation: "Rudolf Höss fue el comandante de Auschwitz durante la mayor parte de su operación.",
                difficulty: .intermediate
            )
        ]
    }

    private func generateTimelineQuestions() -> [Question] {
        [
            Question(
                id: "tq1",
                text: "¿Cuándo comenzó la Segunda Guerra Mundial?",
                options: ["1937", "1938", "1939", "1940"],
                correctAnswerIndex: 2,
                explanation: "La Segunda Guerra Mundial comenzó el 1 de septiembre de 1939 con la invasión de Polonia.",
                difficulty: .beginner
            ),
            Question(
                id: "tq2",
                text: "¿Cuándo finalizó la Segunda Guerra Mundial en Europa?",
                options: ["7 de mayo de 1945", "8 de mayo de 1945", "2 de septiembre de 1945", "14 de agosto de 1945"],
                correctAnswerIndex: 1,
                explanation: "La Segunda Guerra Mundial en Europa finalizó el 8 de mayo de 1945 con la rendición incondicional de Alemania.",
                difficulty: .beginner
            ),
            Question(
                id: "tq3",
                text: "¿Cuándo tuvo lugar el Desembarco de Normandía?",
                options: ["6 de junio de 1944", "6 de junio de 1943", "17 de julio de 1944", "15 de agosto de 1944"],
                correctAnswerIndex: 0,
                explanation: "El Desembarco de Normandía tuvo lugar el 6 de junio de 1944, marcando el inicio de la liberación de Europa occidental.",
                difficulty: .beginner
            ),
            Question(
                id: "tq4",
                text: "¿Cuándo fue establecido el Gueto de Varsovia?",
                options: ["1938", "1939", "1940", "1941"],
                correctAnswerIndex: 2,
                explanation: "El Gueto de Varsovia fue establecido en 1940 y fue el más grande de Europa.",
                difficulty: .beginner
            ),
            Question(
                id: "tq5",
                text: "¿Cuándo tuvo lugar el Levantamiento del Gueto de Varsovia?",
                options: ["Abril de 1942", "Abril de 1943", "Agosto de 1943", "Octubre de 1943"],
                correctAnswerIndex: 1,
                explanation: "El Levantamiento del Gueto de Varsovia ocurrió del 19 de abril al 16 de mayo de 1943.",
                difficulty: .beginner
            ),
            Question(
                id: "tq6",
                text: "¿Cuándo fueron liberados los primeros campos de concentración?",
                options: ["Enero de 1945", "Octubre de 1944", "Marzo de 1945", "Mayo de 1945"],
                correctAnswerIndex: 0,
                explanation: "Auschwitz fue liberado el 27 de enero de 1945 por tropas soviéticas, siendo el primero de los campos principales.",
                difficulty: .beginner
            ),
            Question(
                id: "tq7",
                text: "¿Cuándo comenzaron los Juicios de Núremberg?",
                options: ["Octubre de 1945", "Noviembre de 1945", "Enero de 1946", "Marzo de 1946"],
                correctAnswerIndex: 1,
                explanation: "Los Juicios de Núremberg comenzaron el 20 de noviembre de 1945.",
                difficulty: .beginner
            )
        ]
    }

    private func generateGeneralQuestions() -> [Question] {
        [
            Question(
                id: "gq1",
                text: "¿Aproximadamente cuántos judíos fueron asesinados en el Holocausto?",
                options: ["3 millones", "6 millones", "9 millones", "12 millones"],
                correctAnswerIndex: 1,
                explanation: "Aproximadamente 6 millones de judíos europeos fueron asesinados.",
                difficulty: .advanced
            ),
            Question(
                id: "gq2",
                text: "¿Cuántos años duró la Segunda Guerra Mundial?",
                options: ["5 años", "6 años", "7 años", "8 años"],
                correctAnswerIndex: 1,
                explanation: "La Segunda Guerra Mundial duró aproximadamente 6 años, de 1939 a 1945.",
                difficulty: .advanced
            ),
            Question(
                id: "gq3",
                text: "¿Cuántas víctimas totales causó la Segunda Guerra Mundial?",
                options: ["30 millones", "50 millones", "70 millones", "100 millones"],
                correctAnswerIndex: 2,
                explanation: "Aproximadamente 70-85 millones de personas murieron durante la Segunda Guerra Mundial.",
                difficulty: .advanced
            ),
            Question(
                id: "gq4",
                text: "¿Cuál fue la ideología política del partido nazi?",
                options: [
                    "Comunismo",
                    "Fascismo y racismo",
                    "Socialismo democrático",
                    "Liberalismo"
                ],
                correctAnswerIndex: 1,
                explanation: "El nacionalsocialismo (nazismo) fue una ideología fascista basada en el racismo y el autoritarismo extremo.",
                difficulty: .advanced
            ),
            Question(
                id: "gq5",
                text: "¿Quién fue la mujer más importante en el régimen nazi además de Hitler?",
                options: [
                    "Eva Braun",
                    "Magda Goebbels",
                    "No hubo una mujer clave importante",
                    "Unity Mitford"
                ],
                correctAnswerIndex: 2,
                explanation: "No hubo una mujer que jugara un papel político significativo en el régimen nazi. Las mujeres nazis estaban relegadas al hogar.",
                difficulty: .advanced
            ),
            Question(
                id: "gq6",
                text: "¿Cuál fue el objetivo final del plan llamado 'Solución Final'?",
                options: [
                    "Deportar a todos los judíos a Madagascar",
                    "Crear un gueto mundial judío",
                    "El exterminio total de los judíos europeos",
                    "Convertir a los judíos al cristianismo"
                ],
                correctAnswerIndex: 2,
                explanation: "La Solución Final fue el plan para el exterminio sistemático y total de todos los judíos bajo control nazi.",
                difficulty: .advanced
            ),
            Question(
                id: "gq7",
                text: "¿Qué grupos fueron perseguidos además de los judíos durante el Holocausto?",
                options: [
                    "Solo judíos",
                    "Judíos y gitanos",
                    "Judíos, gitanos, homosexuales, discapacitados, prisioneros políticos y otros",
                    "Judíos y comunistas"
                ],
                correctAnswerIndex: 2,
                explanation: "El régimen nazi persiguió y asesinó a judíos, gitanos, homosexuales, personas con discapacidades, prisioneros políticos, Testigos de Jehová y otros grupos considerados 'indeseables'.",
                difficulty: .advanced
            ),
            Question(
                id: "gq8",
                text: "¿Cuántas potencias Aliadas principales participaron en la Segunda Guerra Mundial?",
                options: ["Dos", "Tres", "Cuatro", "Cinco"],
                correctAnswerIndex: 1,
                explanation: "Las tres potencias Aliadas principales fueron: Unión Soviética, Reino Unido y Estados Unidos.",
                difficulty: .advanced
            )
        ]
    }
}

struct QuizCard: View {
    let quiz: Quiz

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: quiz.category.icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color(hex: quiz.category.color))
                    .cornerRadius(8)

                VStack(alignment: .leading, spacing: 4) {
                    Text(quiz.title)
                        .font(.subheadline.weight(.semibold))
                    Text(quiz.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(quiz.difficulty.rawValue)
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.blue)
                    Text("\(quiz.questions.count) Q")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            HStack(spacing: 8) {
                Label("\(quiz.passingScore)% para aprobar", systemImage: "checkmark.circle")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct StatCard: View {
    let label: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(.blue)
            Text(value)
                .font(.headline)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct FilterPanelQuiz: View {
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Filtros")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                Text("Categoría")
                    .font(.subheadline.weight(.semibold))

                VStack(spacing: 8) {
                    ForEach(Quiz.QuizCategory.allCases, id: \.self) { category in
                        Toggle(isOn: Binding(
                            get: { viewModel.selectedCategory == category },
                            set: { isOn in
                                viewModel.selectedCategory = isOn ? category : nil
                            }
                        )) {
                            Label(category.rawValue, systemImage: category.icon)
                        }
                    }
                }
            }

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("Dificultad")
                    .font(.subheadline.weight(.semibold))

                VStack(spacing: 8) {
                    ForEach(Quiz.DifficultyLevel.allCases, id: \.self) { level in
                        Toggle(isOn: Binding(
                            get: { viewModel.selectedDifficulty == level },
                            set: { isOn in
                                viewModel.selectedDifficulty = isOn ? level : nil
                            }
                        )) {
                            Text(level.rawValue)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

#Preview {
    NavigationStack {
        QuizListView()
            .environmentObject(DataManager.shared)
    }
}
