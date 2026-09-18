import SwiftUI

struct LegislationView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject private var viewModel = LegislationViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                // Filters
                VStack(spacing: 12) {
                    SearchBar(text: $viewModel.searchText)
                        .onChange(of: viewModel.searchText) { _ in
                            viewModel.filterLegislation()
                        }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Período: \(viewModel.startYear) - \(viewModel.endYear)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        RangeSlider(
                            startValue: $viewModel.startYear,
                            endValue: $viewModel.endYear,
                            minValue: viewModel.getMinYear(),
                            maxValue: viewModel.getMaxYear()
                        )
                        .onChange(of: viewModel.startYear) { _ in
                            viewModel.filterLegislation()
                        }
                        .onChange(of: viewModel.endYear) { _ in
                            viewModel.filterLegislation()
                        }
                    }
                }
                .padding()

                if viewModel.filteredLegislation.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "doc.text.slash.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("No se encontraron leyes")
                            .font(.headline)
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                } else {
                    List {
                        ForEach(viewModel.filteredLegislation) { legislation in
                            NavigationLink(destination: LegislationDetailView(legislation: legislation)) {
                                LegislationRowView(legislation: legislation)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Legislación Nazi")
            .onAppear {
                viewModel.updateLegislation(dataManager.legislation)
            }
        }
    }
}

struct LegislationRowView: View {
    let legislation: Legislation

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(legislation.title)
                    .font(.headline)
                Spacer()
                Text("\(legislation.year)")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            Text(legislation.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 8)
    }
}

struct LegislationDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    let legislation: Legislation

    @State private var isBookmarked = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(legislation.title)
                        .font(.title.bold())
                    HStack {
                        Text("\(legislation.year)")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(legislation.type)
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue)
                            .cornerRadius(4)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))

                VStack(alignment: .leading, spacing: 12) {
                    Text("Descripción")
                        .font(.headline)
                    Text(legislation.description)
                        .font(.body)
                }
                .padding()

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Impacto")
                        .font(.headline)
                    Text(legislation.impact)
                        .font(.body)
                }
                .padding()

                Spacer()
            }
        }
        .navigationTitle(legislation.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: toggleBookmark) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.blue)
                }
            }
        }
        .onAppear {
            isBookmarked = dataManager.isBookmarked(itemId: legislation.id, itemType: "legislation")
        }
    }

    private func toggleBookmark() {
        dataManager.toggleBookmark(itemId: legislation.id, itemType: "legislation")
        isBookmarked.toggle()
    }
}

struct RangeSlider: View {
    @Binding var startValue: Int
    @Binding var endValue: Int
    let minValue: Int
    let maxValue: Int

    var body: some View {
        HStack(spacing: 12) {
            Slider(value: Binding(
                get: { Double(startValue) },
                set: { startValue = Int($0) }
            ), in: Double(minValue)...Double(endValue))

            Slider(value: Binding(
                get: { Double(endValue) },
                set: { endValue = Int($0) }
            ), in: Double(startValue)...Double(maxValue))
        }
    }
}

#Preview {
    NavigationStack {
        LegislationView()
            .environmentObject(DataManager.shared)
    }
}
