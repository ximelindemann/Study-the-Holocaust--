import SwiftUI

struct BookmarksView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject private var viewModel = BookmarksViewModel()
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Tipo", selection: $selectedTab) {
                    Text("Perpetradores").tag(0)
                    Text("Legislación").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()

                if selectedTab == 0 {
                    if viewModel.bookmarkedPerpetrators.isEmpty {
                        emptyState()
                    } else {
                        List {
                            ForEach(viewModel.bookmarkedPerpetrators) { perpetrator in
                                NavigationLink(destination: PerpetratorsDetailView(perpetrator: perpetrator)) {
                                    PerpetratorsRowView(perpetrator: perpetrator)
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                } else {
                    if viewModel.bookmarkedLegislation.isEmpty {
                        emptyState()
                    } else {
                        List {
                            ForEach(viewModel.bookmarkedLegislation) { legislation in
                                NavigationLink(destination: LegislationDetailView(legislation: legislation)) {
                                    LegislationRowView(legislation: legislation)
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .navigationTitle("Marcadores")
            .onAppear {
                viewModel.updateData(
                    perpetrators: dataManager.perpetrators,
                    legislation: dataManager.legislation
                )
            }
            .onChange(of: dataManager.perpetrators) { newValue in
                viewModel.updateData(
                    perpetrators: newValue,
                    legislation: dataManager.legislation
                )
            }
        }
    }

    private func emptyState() -> some View {
        VStack(spacing: 12) {
            Image(systemName: "bookmark.slash.fill")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            Text("Sin marcadores")
                .font(.headline)
            Text("Guarda tus elementos favoritos aquí")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    NavigationStack {
        BookmarksView()
            .environmentObject(DataManager.shared)
    }
}
