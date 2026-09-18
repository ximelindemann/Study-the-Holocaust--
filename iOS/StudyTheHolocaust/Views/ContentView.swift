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

            BookmarksView()
                .tabItem {
                    Label("Marcadores", systemImage: "bookmark.fill")
                }
                .tag(3)

            SearchView()
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }
                .tag(4)
        }
        .environmentObject(dataManager)
    }
}

#Preview {
    ContentView()
}
