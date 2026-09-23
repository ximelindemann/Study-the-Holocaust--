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

            ArticlesView()
                .tabItem {
                    Label("Artículos", systemImage: "book.fill")
                }
                .tag(1)

            PerpetratorsListView()
                .tabItem {
                    Label("Perpetradores", systemImage: "person.fill")
                }
                .tag(2)

            LegislationView()
                .tabItem {
                    Label("Legislación", systemImage: "doc.text.fill")
                }
                .tag(3)

            MapView()
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                }
                .tag(4)

            TimelineView()
                .tabItem {
                    Label("Timeline", systemImage: "timeline.vertical")
                }
                .tag(5)

            QuizListView()
                .tabItem {
                    Label("Quiz", systemImage: "brain.head.profile")
                }
                .tag(6)

            StatisticsView()
                .tabItem {
                    Label("Estadísticas", systemImage: "chart.bar.fill")
                }
                .tag(7)

            BookmarksView()
                .tabItem {
                    Label("Marcadores", systemImage: "bookmark.fill")
                }
                .tag(8)

            SearchView()
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }
                .tag(9)
        }
        .environmentObject(dataManager)
        .environmentObject(quizViewModel)
    }
}

#Preview {
    ContentView()
}
