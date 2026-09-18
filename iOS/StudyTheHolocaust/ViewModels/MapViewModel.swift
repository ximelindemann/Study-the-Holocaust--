import Foundation
import MapKit

class MapViewModel: NSObject, ObservableObject {
    @Published var locations: [HistoricalLocation] = []
    @Published var filteredLocations: [HistoricalLocation] = []
    @Published var selectedLocation: HistoricalLocation?
    @Published var selectedFilters: Set<HistoricalLocation.LocationType> = []
    @Published var searchText = ""
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: 10.0), // Centro de Europa
        span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15)
    )

    func updateLocations(_ locations: [HistoricalLocation]) {
        self.locations = locations
        filterLocations()
    }

    func filterLocations() {
        var results = locations

        // Filtrar por tipo
        if !selectedFilters.isEmpty {
            results = results.filter { selectedFilters.contains($0.type) }
        }

        // Filtrar por búsqueda
        if !searchText.isEmpty {
            let query = searchText.lowercased()
            results = results.filter { location in
                location.name.lowercased().contains(query) ||
                location.country.lowercased().contains(query) ||
                location.description.lowercased().contains(query)
            }
        }

        self.filteredLocations = results
    }

    func toggleFilter(_ type: HistoricalLocation.LocationType) {
        if selectedFilters.contains(type) {
            selectedFilters.remove(type)
        } else {
            selectedFilters.insert(type)
        }
        filterLocations()
    }

    func clearFilters() {
        selectedFilters.removeAll()
        filterLocations()
    }

    func selectLocation(_ location: HistoricalLocation) {
        self.selectedLocation = location
        withAnimation {
            mapRegion = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            )
        }
    }

    func getLocationsByType(_ type: HistoricalLocation.LocationType) -> [HistoricalLocation] {
        locations.filter { $0.type == type }
    }

    func getTotalCasualties() -> Int {
        locations.compactMap { $0.casualties }.reduce(0, +)
    }

    func getLocationsCount(for type: HistoricalLocation.LocationType) -> Int {
        locations.filter { $0.type == type }.count
    }
}
