import SwiftUI

struct PerpetratorsListView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject private var viewModel = PerpetratorsViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                // Search bar
                SearchBar(text: $viewModel.searchText)
                    .onChange(of: viewModel.searchText) { _ in
                        viewModel.filterPerpetrators()
                    }
                    .padding()

                if viewModel.filteredPerpetrators.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "person.slash.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("No se encontraron perpetradores")
                            .font(.headline)
                        Text("Intenta con otra búsqueda")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                } else {
                    List {
                        ForEach(viewModel.filteredPerpetrators) { perpetrator in
                            NavigationLink(destination: PerpetratorsDetailView(perpetrator: perpetrator)) {
                                PerpetratorsRowView(perpetrator: perpetrator)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Perpetradores")
            .onAppear {
                viewModel.updatePerpetrators(dataManager.perpetrators)
            }
            .onChange(of: dataManager.perpetrators) { newValue in
                viewModel.updatePerpetrators(newValue)
            }
        }
    }
}

struct PerpetratorsRowView: View {
    let perpetrator: Perpetrator

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(perpetrator.name)
                .font(.headline)
            Text(perpetrator.role)
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack(spacing: 8) {
                Label(perpetrator.organization, systemImage: "building.fill")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 8)
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Buscar perpetradores...", text: $text)
                .textFieldStyle(.roundedBorder)

            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PerpetratorsListView()
            .environmentObject(DataManager.shared)
    }
}
