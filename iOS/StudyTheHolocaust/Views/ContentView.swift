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

            DocumentariesView()
                .tabItem {
                    Label("Documentales", systemImage: "film.fill")
                }
                .tag(2)

            PerpetratorsListView()
                .tabItem {
                    Label("Perpetradores", systemImage: "person.fill")
                }
                .tag(3)

            LegislationView()
                .tabItem {
                    Label("Legislación", systemImage: "doc.text.fill")
                }
                .tag(4)

            MapView()
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                }
                .tag(5)

            TimelineView()
                .tabItem {
                    Label("Timeline", systemImage: "timeline.vertical")
                }
                .tag(6)

            QuizListView()
                .tabItem {
                    Label("Quiz", systemImage: "brain.head.profile")
                }
                .tag(7)

            StatisticsView()
                .tabItem {
                    Label("Estadísticas", systemImage: "chart.bar.fill")
                }
                .tag(8)

            BookmarksView()
                .tabItem {
                    Label("Marcadores", systemImage: "bookmark.fill")
                }
                .tag(9)

            SearchView()
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }
                .tag(10)
        }
        .environmentObject(dataManager)
        .environmentObject(quizViewModel)
    }
}

#Preview {
    ContentView()
}
