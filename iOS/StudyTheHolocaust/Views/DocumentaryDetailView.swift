import SwiftUI

struct DocumentaryDetailView: View {
    let documentary: Documentary

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Poster area
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .frame(height: 200)
                        .overlay(
                            VStack(spacing: 8) {
                                Image(systemName: documentary.type.icon)
                                    .font(.system(size: 40))
                                    .foregroundColor(.secondary)
                                Text(documentary.type.rawValue)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        )

                    VStack(alignment: .leading, spacing: 12) {
                        Text(documentary.title)
                            .font(.title2.bold())

                        if let director = documentary.director {
                            HStack {
                                Text("Director")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(director)
                                    .font(.caption.bold())
                            }
                        }

                        HStack(spacing: 16) {
                            if let duration = documentary.duration {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Duración")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(duration) minutos")
                                        .font(.caption.bold())
                                }
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Año")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(documentary.releaseYear)")
                                    .font(.caption.bold())
                            }

                            Spacer()
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

                    Text(documentary.description)
                        .font(.body)
                        .lineSpacing(1.5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Educational value
                VStack(alignment: .leading, spacing: 12) {
                    Text("Valor Educativo")
                        .font(.headline)

                    Text(documentary.educationalValue)
                        .font(.body)
                        .lineSpacing(1.5)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Technical details
                VStack(alignment: .leading, spacing: 12) {
                    Text("Información Técnica")
                        .font(.headline)

                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Idioma")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(documentary.language)
                                .font(.caption.bold())
                        }
                        Spacer()
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Disponibilidad")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(documentary.availability)
                            .font(.caption.bold())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Sources
                if !documentary.sources.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Fuentes")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(documentary.sources, id: \.self) { source in
                                HStack(alignment: .top) {
                                    Image(systemName: "film.fill")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .padding(.top, 2)

                                    Text(source)
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

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Documental")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DocumentaryDetailView(documentary: Documentary(
            id: "test",
            title: "Test Documentary",
            type: .documentary,
            duration: 90,
            releaseYear: 2024,
            director: "Test Director",
            description: "A test documentary about the Holocaust",
            educationalValue: "High educational value",
            language: "Spanish",
            availability: "Streaming",
            sources: ["Source 1"]
        ))
    }
}
