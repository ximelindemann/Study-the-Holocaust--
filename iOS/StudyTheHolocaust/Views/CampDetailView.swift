import SwiftUI

struct CampDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    let camp: Camp

    @State private var isBookmarked = false

    var campColor: Color {
        Color(hex: camp.type.color)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Camp header
                VStack(spacing: 16) {
                    // Icon
                    ZStack {
                        Circle()
                            .fill(campColor.opacity(0.2))
                            .frame(width: 120, height: 120)

                        Image(systemName: camp.type.icon)
                            .font(.system(size: 50))
                            .foregroundColor(campColor)
                    }

                    VStack(alignment: .center, spacing: 12) {
                        Text(camp.name)
                            .font(.title2.bold())

                        // Type badge
                        HStack(spacing: 4) {
                            Image(systemName: camp.type.icon)
                            Text(camp.type.rawValue)
                        }
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(campColor)
                        .cornerRadius(6)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Location and dates
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ubicación")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            Text("Territorio:")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .frame(width: 80, alignment: .leading)
                            Text(camp.territory)
                                .font(.caption.bold())
                        }

                        HStack(alignment: .top) {
                            Text("Ubicación:")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .frame(width: 80, alignment: .leading)
                            Text(camp.location)
                                .font(.caption.bold())
                        }

                        HStack(alignment: .top) {
                            Text("Establecido:")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .frame(width: 80, alignment: .leading)
                            Text(camp.established)
                                .font(.caption.bold())
                        }

                        if let liberated = camp.liberated {
                            HStack(alignment: .top) {
                                Text("Liberado:")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .frame(width: 80, alignment: .leading)
                                Text(liberated)
                                    .font(.caption.bold())
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Casualties
                VStack(alignment: .leading, spacing: 12) {
                    Text("Víctimas")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            Image(systemName: "exclamationmark.circle")
                                .font(.caption)
                                .foregroundColor(.red)
                                .frame(width: 30)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Estimado")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(camp.estimatedCasualties)
                                    .font(.caption.bold())
                            }
                        }

                        if let deaths = camp.totalDeaths {
                            HStack(alignment: .top) {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .frame(width: 30)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Registro documentado")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(deaths)")
                                        .font(.caption.bold())
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Description
                VStack(alignment: .leading, spacing: 12) {
                    Text("Descripción")
                        .font(.headline)

                    Text(camp.description)
                        .font(.body)
                        .lineSpacing(1.5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Historical Significance
                VStack(alignment: .leading, spacing: 12) {
                    Text("Significancia Histórica")
                        .font(.headline)

                    Text(camp.historicalSignificance)
                        .font(.body)
                        .lineSpacing(1.5)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Operators
                if !camp.operators.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Operadores")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(camp.operators, id: \.self) { operator_ in
                                HStack(alignment: .top) {
                                    Image(systemName: "person.fill")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .padding(.top, 2)

                                    Text(operator_)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                // Sources
                if !camp.sources.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Fuentes")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(camp.sources, id: \.self) { source in
                                HStack(alignment: .top) {
                                    Image(systemName: "doc.text.fill")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .padding(.top, 2)

                                    Text(source)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(nil)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Campo")
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
            isBookmarked = dataManager.isBookmarked(itemId: camp.id, itemType: "camp")
        }
    }

    private func toggleBookmark() {
        dataManager.toggleBookmark(itemId: camp.id, itemType: "camp")
        isBookmarked.toggle()
    }
}

#Preview {
    NavigationStack {
        CampDetailView(camp: Camp(
            id: "test",
            name: "Test Camp",
            type: .concentration,
            territory: "Test Territory",
            location: "Test Location",
            established: "1940",
            liberated: "1945",
            totalDeaths: 50000,
            estimatedCasualties: "Approximately 50,000",
            operators: ["Test Operator"],
            description: "Test description",
            historicalSignificance: "Test significance",
            sources: ["Source 1"]
        ))
        .environmentObject(DataManager.shared)
    }
}
