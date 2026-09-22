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
                text: "¿Quién fue el fundador e ideólogo del Partido Nazi (NSDAP)?",
                options: ["Hermann Göring", "Adolf Hitler", "Joseph Goebbels", "Rudolf Hess"],
                correctAnswerIndex: 1,
                explanation: "Adolf Hitler fundó el NSDAP y desarrolló su ideología nacionalsocialista.",
                difficulty: .beginner
            ),
            Question(
                id: "q2",
                text: "¿Cuál era el rol principal de Heinrich Himmler en el régimen nazi?",
                options: ["Comandante de la Luftwaffe", "Organizador del Holocausto y jefe de la SS", "Ministro de Economía", "Jefe del Ejército"],
                correctAnswerIndex: 1,
                explanation: "Himmler fue Reichsführer de la SS y principal organizador de la Solución Final.",
                difficulty: .beginner
            ),
            Question(
                id: "q3",
                text: "¿Cuáles eran las tres esferas de poder principales que controlaban el régimen nazi?",
                options: [
                    "Ejército, Policía y Propaganda",
                    "Partido Nazi, SS y Gestapo",
                    "Hitler, Goebbels y Himmler",
                    "Reichstag, Bundestag y Senado"
                ],
                correctAnswerIndex: 1,
                explanation: "El poder se distribuyó entre el Partido Nazi (control político), la SS (militarizado) y la Gestapo (represión).",
                difficulty: .beginner
            ),
            Question(
                id: "q4",
                text: "¿Quién fue Ernest Röhm y por qué fue significativo?",
                options: [
                    "General del ejército que derrotó a Hitler",
                    "Jefe de las SA eliminado en la Noche de los Cuchillos Largos",
                    "Diplomático que traicionó a Alemania",
                    "Comandante de la resistencia alemana"
                ],
                correctAnswerIndex: 1,
                explanation: "Röhm fue líder de las SA (paramilitares) y fue asesinado en 1934 para consolidar el poder de Hitler.",
                difficulty: .beginner
            ),
            Question(
                id: "q5",
                text: "¿Cuál fue el apodo de la operación en la que Hitler ordenó asesinar a líderes políticos y adversarios en 1934?",
                options: ["Operación Valkiria", "Noche de los Cuchillos Largos", "Kristallnacht", "Operación Barbarroja"],
                correctAnswerIndex: 1,
                explanation: "La Noche de los Cuchillos Largos (30 de junio-2 de julio de 1934) fue una purga interna que consolidó el poder de Hitler.",
                difficulty: .beginner
            ),
            Question(
                id: "q6",
                text: "¿Qué documento firmó Hitler que violó directamente el Tratado de Versalles?",
                options: [
                    "El Tratado de Múnich",
                    "El Pacto de Anticomintén",
                    "El Acta Habilitante",
                    "El Pacto Nazi-Soviético"
                ],
                correctAnswerIndex: 0,
                explanation: "El Tratado de Múnich (1938) permitió a Hitler anexar territorios checoslovacos, violando Versalles.",
                difficulty: .beginner
            ),
            Question(
                id: "q7",
                text: "¿Quién negó públicamente la responsabilidad personal por el Holocausto en los Juicios de Núremberg?",
                options: ["Todos los acusados", "Solo Himmler", "Göring y Himmler", "Ninguno admitió responsabilidad completa"],
                correctAnswerIndex: 3,
                explanation: "Muchos nazis en Núremberg alegaron que solo 'seguían órdenes', negando responsabilidad personal.",
                difficulty: .beginner
            ),
            Question(
                id: "q8",
                text: "¿Cuál fue la estrategia de Hitler para expandir territorio alemán llamada 'Lebensraum'?",
                options: [
                    "Colonización pacífica",
                    "Espacio vital mediante conquista militar y dominación de pueblos 'inferiores'",
                    "Negociaciones diplomáticas",
                    "Migración voluntaria"
                ],
                correctAnswerIndex: 1,
                explanation: "Lebensraum ('espacio vital') justificaba la conquista y el genocidio como necesarios para la 'raza aria'.",
                difficulty: .beginner
            )
        ]
    }

    private func generateLegislationQuestions() -> [Question] {
        [
            Question(
                id: "lq1",
                text: "¿Qué diferencia hay entre el Decreto de Protección del Pueblo y el Estado (1933) y el Acta Habilitante?",
                options: [
                    "No hay diferencia, son el mismo documento",
                    "El Decreto suspendió derechos civiles; el Acta Habilitante permitió legislación dictatorial",
                    "El Acta Habilitante fue primero",
                    "Ambos se enfocaron en judíos específicamente"
                ],
                correctAnswerIndex: 1,
                explanation: "El Decreto suspendió libertades civiles tras el incendio del Reichstag; el Acta Habilitante (23 de marzo) permitió a Hitler legislar sin el Parlamento.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq2",
                text: "¿Cuál fue el impacto legal específico de las Leyes de Núremberg de 1935?",
                options: [
                    "Prohibieron el trabajo judío",
                    "Privaron de ciudadanía y prohibieron matrimonios mixtos",
                    "Ordenaron la deportación de judíos",
                    "Cerraron todas las sinagogas"
                ],
                correctAnswerIndex: 1,
                explanation: "Las Leyes establecieron dos disposiciones clave: pérdida de ciudadanía y prohibición de matrimonios entre judíos y arios.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq3",
                text: "¿Qué fueron las Leyes de Núremberg de 1935 conocidas como?",
                options: [
                    "Leyes de Protección de la Raza",
                    "Ley de Ciudadanía del Reich y Ley de Protección de la Sangre Alemana",
                    "Ley de Purificación Racial",
                    "Leyes de Segregación"
                ],
                correctAnswerIndex: 1,
                explanation: "Las dos leyes fueron la 'Ley de Ciudadanía del Reich' y la 'Ley para la Protección de la Sangre Alemana y el Honor Alemán'.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq4",
                text: "¿Qué fue la Kristallnacht y quién la orquestó?",
                options: [
                    "Una revuelta judía de 1938",
                    "Un pogrom coordinado por el régimen después del asesinato de Ernst vom Rath en 1938",
                    "Una ley antisemita de 1936",
                    "Un atentado contra la Gestapo"
                ],
                correctAnswerIndex: 1,
                explanation: "El 9-10 de noviembre de 1938, tras el asesinato del diplomático alemán vom Rath por Herschel Grynszpan, se orquestó un pogrom masivo.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq5",
                text: "¿Cuáles fueron las consecuencias inmediatas de la Kristallnacht para los judíos alemanes?",
                options: [
                    "Ninguna, fue un evento aislado",
                    "Encarcelamiento masivo, multas forzadas y exclusión aún mayor de la vida económica",
                    "Deportación inmediata a Polonia",
                    "Permiso para emigrar libremente"
                ],
                correctAnswerIndex: 1,
                explanation: "Tras Kristallnacht, 30,000 judíos fueron arrestados, se les impusieron multas de 1,000 millones de reichsmarks, y se intensificó su exclusión económica.",
                difficulty: .intermediate
            ),
            Question(
                id: "lq6",
                text: "¿Qué fue decidido en la Conferencia de Wannsee del 20 de enero de 1941?",
                options: [
                    "La invasión de la Unión Soviética",
                    "La coordinación de la Solución Final: exterminio sistemático de judíos europeos",
                    "La creación del Tercer Reich",
                    "La alianza con Italia y Japón"
                ],
                correctAnswerIndex: 1,
                explanation: "En Wannsee, altos oficiales nazis coordinaron el plan para asesinar a todos los judíos bajo control nazi mediante campos de exterminio.",
                difficulty: .intermediate
            )
        ]
    }

    private func generateCampsQuestions() -> [Question] {
        [
            Question(
                id: "cq1",
                text: "¿Cuál fue la estrategia de Auschwitz que la diferenció de otros campos de exterminio?",
                options: [
                    "Era solo un campo de concentración",
                    "Combinaba exterminio masivo con trabajo forzado antes de matar",
                    "No tenía capacidad de exterminio",
                    "Solo mataba mediante hambre"
                ],
                correctAnswerIndex: 1,
                explanation: "Auschwitz fue único: funcionaba como campo de concentración Y de exterminio, haciendo trabajar a prisioneros hasta matarlos.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq2",
                text: "¿Cuál era el propósito principal de Treblinka comparado con Auschwitz?",
                options: [
                    "Era un campo de trabajo",
                    "Exterminio masivo inmediato sin trabajo forzado",
                    "Refugio para prisioneros",
                    "Centro de investigación médica"
                ],
                correctAnswerIndex: 1,
                explanation: "Treblinka estaba diseñado exclusivamente para exterminio: los trenes llegaban, mataban en las cámaras de gas y enterraban los cuerpos.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq3",
                text: "¿Qué fue el 'Plan Madagascar' del régimen nazi?",
                options: [
                    "Un campo ubicado en Madagascar",
                    "Un plan fallido de deportar a todos los judíos europeos a Madagascar",
                    "Una estrategia militar",
                    "Un tratado comercial"
                ],
                correctAnswerIndex: 1,
                explanation: "Antes de la Solución Final, Hitler consideró deportar a millones de judíos a Madagascar, pero fue reemplazado por exterminio.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq4",
                text: "¿Cuál fue el sistema utilizado para matar en los principales campos de exterminio?",
                options: [
                    "Disparo masivo",
                    "Hambre únicamente",
                    "Cámaras de gas con monóxido de carbono o Zyklon B",
                    "Envenenamiento del agua"
                ],
                correctAnswerIndex: 2,
                explanation: "Las cámaras de gas fueron el método principal: usaban gas de combustión o insecticida Zyklon B para matar a cientos simultáneamente.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq5",
                text: "¿Cuál fue el rol de los 'Sonderkommandos' en Auschwitz?",
                options: [
                    "Guardias de seguridad",
                    "Prisioneros forzados a remover cuerpos de las cámaras de gas y quemar los restos",
                    "Médicos del campo",
                    "Oficiales administrativos"
                ],
                correctAnswerIndex: 1,
                explanation: "Los Sonderkommandos eran prisioneros que, bajo amenaza de muerte, removían cuerpos y operaban los hornos crematorios.",
                difficulty: .intermediate
            ),
            Question(
                id: "cq6",
                text: "¿Qué fue la 'selección en la rampa' en Auschwitz?",
                options: [
                    "Proceso de asignación de trabajo",
                    "Proceso médico de control de salud",
                    "Decisión de vida o muerte: trabajar o ir directamente a las cámaras de gas",
                    "Asignación de barracones"
                ],
                correctAnswerIndex: 2,
                explanation: "En la rampa de llegada, médicos nazis como Mengele decidían en segundos quién trabajaría y quién sería asesinado inmediatamente.",
                difficulty: .intermediate
            )
        ]
    }

    private func generateTimelineQuestions() -> [Question] {
        [
            Question(
                id: "tq1",
                text: "¿Cuál fue el evento detonante que Hitler usó para justificar la invasión de Polonia el 1 de septiembre de 1939?",
                options: [
                    "Un ataque fronterizo polaco",
                    "El incidente de Gleiwitz (simulado): falso ataque alemán culpando a Polonia",
                    "Una protesta judía",
                    "Un acuerdo comercial roto"
                ],
                correctAnswerIndex: 1,
                explanation: "Los nazis organizaron un falso 'ataque polaco' en la emisora de Gleiwitz para justificar la invasión.",
                difficulty: .beginner
            ),
            Question(
                id: "tq2",
                text: "¿Cuál fue el significado del Pacto Nazi-Soviético de agosto de 1939?",
                options: [
                    "Una alianza permanente",
                    "Acuerdo de no agresión pero secretamente dividía Polonia y otros territorios entre ambas potencias",
                    "Una promesa de paz mutua",
                    "Un tratado comercial"
                ],
                correctAnswerIndex: 1,
                explanation: "El Molotov-Ribbentrop incluía protocolos secretos que dividían Europa del Este entre Alemania y la URSS.",
                difficulty: .beginner
            ),
            Question(
                id: "tq3",
                text: "¿Qué fue la Operación Barbarroja?",
                options: [
                    "La invasión de Francia",
                    "La invasión sorpresiva de la Unión Soviética el 22 de junio de 1941, quebrando el Pacto Nazi-Soviético",
                    "El desembarco de Normandía",
                    "La invasión de Austria"
                ],
                correctAnswerIndex: 1,
                explanation: "Barbarroja fue el ataque de Hitler a la URSS en 1941, abriendo el frente oriental y cambiando la guerra.",
                difficulty: .beginner
            ),
            Question(
                id: "tq4",
                text: "¿Qué caracterizó el patrón de persecución antes del Gueto de Varsovia (1940)?",
                options: [
                    "Deportación inmediata a campos de exterminio",
                    "Leyes discriminatorias, segregación gradual y confiscación de propiedad",
                    "Ejecuciones masivas de inmediato",
                    "Permiso para emigrar libremente"
                ],
                correctAnswerIndex: 1,
                explanation: "La persecución fue gradual: Leyes de Núremberg (1935), Kristallnacht (1938), luego segregación en guetos (1940-1941).",
                difficulty: .beginner
            ),
            Question(
                id: "tq5",
                text: "¿Por qué fue significativo el Levantamiento del Gueto de Varsovia (abril-mayo de 1943)?",
                options: [
                    "Fue el único levantamiento durante el Holocausto",
                    "Fue el primer levantamiento urbano organizado contra los nazis, demostrando resistencia judía",
                    "Logró liberar a todos los prisioneros",
                    "Marcó el fin de la guerra"
                ],
                correctAnswerIndex: 1,
                explanation: "Aunque fue brutalmente sofocado, fue uno de los pocos levantamientos urbanos contra la ocupación nazi.",
                difficulty: .beginner
            ),
            Question(
                id: "tq6",
                text: "¿En qué orden ocurrieron estos eventos? 1) Wannsee 2) Kristallnacht 3) Operación Barbarroja",
                options: [
                    "1, 2, 3",
                    "2, 1, 3",
                    "3, 2, 1",
                    "2, 3, 1"
                ],
                correctAnswerIndex: 1,
                explanation: "Kristallnacht (nov 1938), Wannsee (ene 1941), Barbarroja (jun 1941)—mostrando la escalada hacia exterminio.",
                difficulty: .beginner
            ),
            Question(
                id: "tq7",
                text: "¿Cuánto tiempo después de la liberación de Auschwitz comenzaron formalmente los Juicios de Núremberg?",
                options: [
                    "Inmediatamente (semanas)",
                    "Aproximadamente 10 meses (enero-noviembre de 1945)",
                    "Años después",
                    "Nunca se juzgó a nadie"
                ],
                correctAnswerIndex: 1,
                explanation: "Auschwitz fue liberado el 27 enero 1945; Núremberg comenzó el 20 noviembre 1945, permitiendo investigación pero no venganza inmediata.",
                difficulty: .beginner
            )
        ]
    }

    private func generateGeneralQuestions() -> [Question] {
        [
            Question(
                id: "gq1",
                text: "¿Cuáles fueron los tres pilares ideológicos del nazismo?",
                options: [
                    "Socialismo, democracia, pacifismo",
                    "Fascismo, racismo antisemita y 'Lebensraum' (espacio vital)",
                    "Comunismo, nacionalismo y igualdad",
                    "Monarquía, catolicismo y tradición"
                ],
                correctAnswerIndex: 1,
                explanation: "El nazismo se basaba en fascismo autorititario, racismo biológico, y conquista territorial justificada como espacio necesario.",
                difficulty: .advanced
            ),
            Question(
                id: "gq2",
                text: "¿Cuál fue la categorización racial nazi de los pueblos europeos?",
                options: [
                    "Todos eran iguales",
                    "Arios superiores, razas inferiores eslavas/judías, con gitanos en el fondo",
                    "Basada en religión, no raza",
                    "Solo basada en nacionalidad"
                ],
                correctAnswerIndex: 1,
                explanation: "Los nazis crearon una jerarquía racial donde los 'arios' germánicos eran superiores y otros pueblos eran 'inferiores' o destinados a esclavitud.",
                difficulty: .advanced
            ),
            Question(
                id: "gq3",
                text: "¿Qué fue el programa de eutanasia nazi T-4?",
                options: [
                    "Un programa de salud pública",
                    "Asesinato sistemático de personas con discapacidades mentales y físicas consideradas 'vidas indignas de vivir'",
                    "Un programa de educación",
                    "Una iniciativa de bienestar social"
                ],
                correctAnswerIndex: 1,
                explanation: "El Programa T-4 asesinó a aproximadamente 250,000 personas discapacitadas, siendo un precursor de los métodos utilizados en el Holocausto.",
                difficulty: .advanced
            ),
            Question(
                id: "gq4",
                text: "¿Cuál fue el rol de la propaganda en el Holocausto?",
                options: [
                    "No jugó un rol importante",
                    "Deshumanizó a las víctimas, normalizó la violencia y movilizó apoyo popular para las políticas nazis",
                    "Solo fue propaganda de guerra",
                    "Fue accidental"
                ],
                correctAnswerIndex: 1,
                explanation: "Goebbels y su ministerio satanizaron constantemente a judíos y otros grupos, preparando a la población para aceptar o ignorar su persecución.",
                difficulty: .advanced
            ),
            Question(
                id: "gq5",
                text: "¿Qué fue la 'Resistencia Blanca Rosa' (Weiße Rose) en Alemania?",
                options: [
                    "Un movimiento nazi",
                    "Grupo de resistencia no violenta de estudiantes alemanes contra el régimen nazi",
                    "Una organización de espías aliados",
                    "Un partido político legal"
                ],
                correctAnswerIndex: 1,
                explanation: "La Rosa Blanca fue un grupo de estudiantes universitarios que distribuyó panfletos contra Hitler; sus líderes fueron ejecutados en 1943.",
                difficulty: .advanced
            ),
            Question(
                id: "gq6",
                text: "¿Cuál fue el alcance geográfico del Holocausto?",
                options: [
                    "Solo Alemania",
                    "Alemania y Polonia",
                    "Toda Europa conquistada: desde Francia hasta la Unión Soviética",
                    "Solo Europa del Este"
                ],
                correctAnswerIndex: 2,
                explanation: "El Holocausto abarcó toda Europa bajo control nazi: Francia, Países Bajos, Bélgica, Polonia, Unión Soviética ocupada, Grecia, Yugoslavia, Hungría, etc.",
                difficulty: .advanced
            ),
            Question(
                id: "gq7",
                text: "¿Cómo escaparon algunos judíos del Holocausto?",
                options: [
                    "Ninguno escapó",
                    "Por suerte solamente",
                    "Por ayuda de no-judíos, documentos falsos, ocultándose, o países que se negaron a deportarlos como Dinamarca",
                    "No hay registros de escapadas"
                ],
                correctAnswerIndex: 2,
                explanation: "Algunos judíos escaparon gracias a rescatistas no-judíos (Justos entre las Naciones), documentos falsificados, y algunos gobiernos que resistieron presión nazi.",
                difficulty: .advanced
            ),
            Question(
                id: "gq8",
                text: "¿Cuál fue el legado legal del Holocausto después de la guerra?",
                options: [
                    "Ninguno, fue olvidado rápidamente",
                    "Solo procedimientos penales sin cambios legales",
                    "Creación de leyes internacionales de derechos humanos y la Convención sobre el Genocidio",
                    "Las cosas continuaron como antes"
                ],
                correctAnswerIndex: 2,
                explanation: "El Holocausto llevó a la Declaración Universal de Derechos Humanos (1948) y la Convención sobre el Genocidio, definiendo crímenes de guerra internacionalmente.",
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
