import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = DataManager.shared
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }
                .tag(0)

            PerpetratorsListView()
                .tabItem {
                    Label("Perpetradores", systemImage: "person.fill")
                }
                .tag(1)

            LegislationView()
                .tabItem {
                    Label("Legislación", systemImage: "doc.text.fill")
                }
                .tag(2)

            MapView()
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                }
                .tag(3)

            TimelineView()
                .tabItem {
                    Label("Timeline", systemImage: "timeline.vertical")
                }
                .tag(4)

            BookmarksView()
                .tabItem {
                    Label("Marcadores", systemImage: "bookmark.fill")
                }
                .tag(5)

            SearchView()
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }
                .tag(6)
        }
        .environmentObject(dataManager)
    }
}

#Preview {
    ContentView()
}
