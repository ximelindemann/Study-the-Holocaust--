import Foundation

class TimelineViewModel: ObservableObject {
    @Published var events: [TimelineEvent] = []
    @Published var filteredEvents: [TimelineEvent] = []
    @Published var selectedYear = 1933
    @Published var selectedCategories: Set<TimelineEvent.EventCategory> = []
    @Published var searchText = ""
    @Published var selectedEvent: TimelineEvent?

    private let minYear = 1933
    private let maxYear = 1945

    func updateEvents(_ events: [TimelineEvent]) {
        self.events = events.sorted { $0.year < $1.year }
        filterEvents()
    }

    func filterEvents() {
        var results = events

        // Filtrar por año (mostrar desde 1933 hasta el año seleccionado)
        results = results.filter { $0.year <= selectedYear }

        // Filtrar por categoría
        if !selectedCategories.isEmpty {
            results = results.filter { selectedCategories.contains($0.category) }
        }

        // Filtrar por búsqueda
        if !searchText.isEmpty {
            let query = searchText.lowercased()
            results = results.filter { event in
                event.title.lowercased().contains(query) ||
                event.description.lowercased().contains(query) ||
                event.date.lowercased().contains(query)
            }
        }

        self.filteredEvents = results
    }

    func toggleCategory(_ category: TimelineEvent.EventCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
        filterEvents()
    }

    func clearFilters() {
        selectedCategories.removeAll()
        searchText = ""
        selectedYear = maxYear
        filterEvents()
    }

    func selectEvent(_ event: TimelineEvent) {
        self.selectedEvent = event
    }

    func getEventsCount(for category: TimelineEvent.EventCategory) -> Int {
        events.filter { $0.category == category }.count
    }

    func getYearRange() -> [Int] {
        Array(minYear...maxYear)
    }

    func getEventsByYear() -> [Int: [TimelineEvent]] {
        var grouped: [Int: [TimelineEvent]] = [:]
        for event in filteredEvents {
            if grouped[event.year] == nil {
                grouped[event.year] = []
            }
            grouped[event.year]?.append(event)
        }
        return grouped
    }

    func getMinYear() -> Int { minYear }
    func getMaxYear() -> Int { maxYear }
}
