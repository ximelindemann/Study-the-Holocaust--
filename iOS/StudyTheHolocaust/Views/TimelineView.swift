import SwiftUI

struct TimelineView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject private var viewModel = TimelineViewModel()
    @State private var showFilters = false
    @State private var showLegend = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Year slider
                VStack(spacing: 12) {
                    HStack {
                        Text("Período")
                            .font(.headline)
                        Spacer()
                        Text("\(viewModel.getMinYear()) - \(viewModel.selectedYear)")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }

                    Slider(
                        value: Binding(
                            get: { Double(viewModel.selectedYear) },
                            set: { viewModel.selectedYear = Int($0) }
                        ),
                        in: Double(viewModel.getMinYear())...Double(viewModel.getMaxYear()),
                        step: 1
                    )
                    .onChange(of: viewModel.selectedYear) { _ in
                        viewModel.filterEvents()
                    }
                }
                .padding()
                .background(Color(.systemGray6))

                HStack(spacing: 12) {
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }

                    Button(action: { showLegend.toggle() }) {
                        Image(systemName: "list.bullet")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }

                    Button(action: viewModel.clearFilters) {
                        Image(systemName: "xmark.circle")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                .padding()

                // Timeline
                ScrollView {
                    if viewModel.filteredEvents.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                            Text("Sin eventos")
                                .font(.headline)
                            Text("No hay eventos para este período")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding()
                    } else {
                        TimelineContent(viewModel: viewModel)
                            .padding()
                    }
                }

                // Filters sheet
                if showFilters {
                    VStack {
                        Spacer()
                        TimelineFilterPanel(viewModel: viewModel)
                            .transition(.move(edge: .bottom))
                    }
                }

                // Legend
                if showLegend {
                    VStack {
                        TimelineLegend(viewModel: viewModel)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
            .navigationTitle("Timeline")
            .onAppear {
                loadSampleEvents()
            }
        }
    }

    private func loadSampleEvents() {
        let sampleEvents = [
            TimelineEvent(
                id: "1933_enabling_act",
                title: "Acta Habilitante",
                date: "23 de marzo de 1933",
                day: 23,
                month: 3,
                year: 1933,
                description: "El Reichstag aprueba el Acta Habilitante, otorgando poderes dictatoriales a Hitler.",
                category: .legislation,
                significance: "Transformación de gobierno democrático a totalitario",
                consequences: "Eliminación de separación de poderes",
                imageURL: nil,
                relatedLocations: [],
                relatedPerpetrators: ["hitler", "goebbels"],
                sources: ["Archivos del Reichstag"]
            ),
            TimelineEvent(
                id: "1935_nuremberg_laws",
                title: "Leyes de Núremberg",
                date: "15 de septiembre de 1935",
                day: 15,
                month: 9,
                year: 1935,
                description: "Se promulgan las Leyes de Núremberg, privando a los judíos de ciudadanía.",
                category: .legislation,
                significance: "Base legal para persecución sistemática",
                consequences: "Estatus legal de segunda clase para judíos",
                imageURL: nil,
                relatedLocations: [],
                relatedPerpetrators: ["hitler"],
                sources: ["Gaceta oficial del Reich"]
            ),
            TimelineEvent(
                id: "1938_kristallnacht",
                title: "Kristallnacht",
                date: "9-10 de noviembre de 1938",
                day: 9,
                month: 11,
                year: 1938,
                description: "Pogrom violento coordinado contra judíos y sus propiedades en toda Alemania.",
                category: .violence,
                significance: "Transición de persecución legal a violencia física",
                consequences: "Encarcelamiento de 30,000 judíos",
                imageURL: nil,
                relatedLocations: [],
                relatedPerpetrators: ["goebbels", "heydrich"],
                sources: ["Reportes de prensa", "Testimonios"]
            ),
            TimelineEvent(
                id: "1939_invasion_poland",
                title: "Invasión de Polonia",
                date: "1 de septiembre de 1939",
                day: 1,
                month: 9,
                year: 1939,
                description: "Alemania invade Polonia, iniciando la Segunda Guerra Mundial.",
                category: .military,
                significance: "Inicio de la Segunda Guerra Mundial",
                consequences: "Ocupación de territorios judíos europeos",
                imageURL: nil,
                relatedLocations: ["warsaw_ghetto"],
                relatedPerpetrators: ["hitler"],
                sources: ["Registros militares"]
            ),
            TimelineEvent(
                id: "1941_wannsee",
                title: "Conferencia de Wannsee",
                date: "20 de enero de 1941",
                day: 20,
                month: 1,
                year: 1941,
                description: "Altos oficiales nazis planifican la 'Solución Final'.",
                category: .violence,
                significance: "Decisión de genocidio sistemático",
                consequences: "Implementación de campos de exterminio",
                imageURL: nil,
                relatedLocations: ["auschwitz", "treblinka"],
                relatedPerpetrators: ["himmler", "heydrich"],
                sources: ["Protocolo de Wannsee"]
            ),
            TimelineEvent(
                id: "1942_treblinka",
                title: "Operación de Treblinka",
                date: "23 de julio de 1942",
                day: 23,
                month: 7,
                year: 1942,
                description: "Comienza el transporte masivo desde el Gueto de Varsovia a Treblinka.",
                category: .violence,
                significance: "Inicio de exterminio masivo en Treblinka",
                consequences: "300,000 judíos de Varsovia asesinados",
                imageURL: nil,
                relatedLocations: ["warsaw_ghetto", "treblinka"],
                relatedPerpetrators: ["stangl"],
                sources: ["Testimonios de Jankiel Wiernik"]
            ),
            TimelineEvent(
                id: "1943_warsaw_uprising",
                title: "Levantamiento del Gueto de Varsovia",
                date: "19 de abril - 16 de mayo de 1943",
                day: 19,
                month: 4,
                year: 1943,
                description: "Resistencia judía organizada contra la evacuación del gueto.",
                category: .resistance,
                significance: "Primer levantamiento urbano contra nazis",
                consequences: "13,000 judíos asesinados, gueto destruido",
                imageURL: nil,
                relatedLocations: ["warsaw_ghetto"],
                relatedPerpetrators: [],
                sources: ["Testimonios de sobrevivientes", "Diarios del gueto"]
            ),
            TimelineEvent(
                id: "1944_d_day",
                title: "Desembarco de Normandía",
                date: "6 de junio de 1944",
                day: 6,
                month: 6,
                year: 1944,
                description: "Operación Overlord: invasión aliada de Francia",
                category: .military,
                significance: "Inicio de liberación de Europa Occidental",
                consequences: "Inicio del fin del Tercer Reich",
                imageURL: nil,
                relatedLocations: [],
                relatedPerpetrators: [],
                sources: ["Registros militares aliados"]
            ),
            TimelineEvent(
                id: "1945_liberation_auschwitz",
                title: "Liberación de Auschwitz",
                date: "27 de enero de 1945",
                day: 27,
                month: 1,
                year: 1945,
                description: "Tropas soviéticas liberan Auschwitz",
                category: .liberation,
                significance: "Descubrimiento del alcance del Holocausto",
                consequences: "Revelación de la verdad sobre el genocidio",
                imageURL: nil,
                relatedLocations: ["auschwitz"],
                relatedPerpetrators: ["hoss"],
                sources: ["Testimonios de Primo Levi"]
            ),
            TimelineEvent(
                id: "1945_liberation_germany",
                title: "Liberación de Alemania",
                date: "8 de mayo de 1945",
                day: 8,
                month: 5,
                year: 1945,
                description: "Rendición incondicional de Alemania",
                category: .military,
                significance: "Fin de la Segunda Guerra Mundial en Europa",
                consequences: "Fin del Tercer Reich",
                imageURL: nil,
                relatedLocations: [],
                relatedPerpetrators: ["hitler"],
                sources: ["Documentos militares"]
            ),
            TimelineEvent(
                id: "1945_nuremberg_trials",
                title: "Juicios de Núremberg",
                date: "20 de noviembre de 1945 - 1 de octubre de 1946",
                day: 20,
                month: 11,
                year: 1945,
                description: "Juicio de los principales criminales de guerra nazis",
                category: .trial,
                significance: "Primer tribunal internacional de crímenes de guerra",
                consequences: "Establecimiento de precedente legal internacional",
                imageURL: nil,
                relatedLocations: [],
                relatedPerpetrators: ["hitler", "himmler", "goebbels"],
                sources: ["Actas de Núremberg"]
            )
        ]
        viewModel.updateEvents(sampleEvents)
    }
}

struct TimelineContent: View {
    @ObservedObject var viewModel: TimelineViewModel

    var body: some View {
        VStack(spacing: 24) {
            ForEach(Array(viewModel.getEventsByYear().sorted { $0.key < $1.key }), id: \.key) { year, events in
                VStack(alignment: .leading, spacing: 16) {
                    // Year marker
                    Text("\(year)")
                        .font(.title2.bold())
                        .foregroundColor(.blue)
                        .padding(.bottom, 8)

                    // Events for year
                    VStack(spacing: 12) {
                        ForEach(events) { event in
                            TimelineEventCard(event: event, viewModel: viewModel)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
        }
    }
}

struct TimelineEventCard: View {
    @EnvironmentObject var dataManager: DataManager
    let event: TimelineEvent
    @ObservedObject var viewModel: TimelineViewModel

    @State private var isBookmarked = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: event.category.icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(Color(hex: event.category.color))
                    .cornerRadius(6)

                VStack(alignment: .leading, spacing: 2) {
                    Text(event.title)
                        .font(.subheadline.weight(.semibold))
                    Text(event.date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button(action: toggleBookmark) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }

            Text(event.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)

            NavigationLink(destination: TimelineEventDetailView(event: event)) {
                HStack {
                    Text("Ver detalles")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.blue)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .onAppear {
            isBookmarked = dataManager.isBookmarked(itemId: event.id, itemType: "timeline_event")
        }
    }

    private func toggleBookmark() {
        dataManager.toggleBookmark(itemId: event.id, itemType: "timeline_event")
        isBookmarked.toggle()
    }
}

struct TimelineFilterPanel: View {
    @ObservedObject var viewModel: TimelineViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Filtrar por categoría")
                .font(.headline)

            VStack(spacing: 8) {
                ForEach(TimelineEvent.EventCategory.allCases, id: \.self) { category in
                    Toggle(isOn: Binding(
                        get: { viewModel.selectedCategories.contains(category) },
                        set: { _ in viewModel.toggleCategory(category) }
                    )) {
                        HStack(spacing: 8) {
                            Image(systemName: category.icon)
                                .foregroundColor(Color(hex: category.color))
                            Text(category.rawValue)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding()
    }
}

struct TimelineLegend: View {
    @ObservedObject var viewModel: TimelineViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Categorías")
                .font(.headline)

            VStack(alignment: .leading, spacing: 10) {
                ForEach(TimelineEvent.EventCategory.allCases, id: \.self) { category in
                    HStack(spacing: 12) {
                        Image(systemName: category.icon)
                            .font(.body)
                            .foregroundColor(Color(hex: category.color))
                            .frame(width: 24)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(category.rawValue)
                                .font(.subheadline.weight(.medium))
                            Text("\(viewModel.getEventsCount(for: category))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding()
    }
}

#Preview {
    NavigationStack {
        TimelineView()
            .environmentObject(DataManager.shared)
    }
}
