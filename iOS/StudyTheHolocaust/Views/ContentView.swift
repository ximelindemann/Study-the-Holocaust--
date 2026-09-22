import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = DataManager.shared
    @StateObject private var quizViewModel = QuizViewModel()
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

            QuizListView()
                .tabItem {
                    Label("Quiz", systemImage: "brain.head.profile")
                }
                .tag(5)

            BookmarksView()
                .tabItem {
                    Label("Marcadores", systemImage: "bookmark.fill")
                }
                .tag(6)

            SearchView()
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }
                .tag(7)
        }
        .environmentObject(dataManager)
        .environmentObject(quizViewModel)
    }
}

#Preview {
    ContentView()
}
