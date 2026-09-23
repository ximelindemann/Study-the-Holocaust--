import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var statistics: HolocaustStatistics?
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            if let stats = statistics {
                VStack(spacing: 0) {
                    Picker("Categoría", selection: $selectedTab) {
                        Text("General").tag(0)
                        Text("Por País").tag(1)
                        Text("Por Campo").tag(2)
                        Text("Por Año").tag(3)
                        Text("Resistencia").tag(4)
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    TabView(selection: $selectedTab) {
                        // General Stats
                        ScrollView {
                            VStack(spacing: 16) {
                                // Total Victims
                                StatCard(
                                    title: "Víctimas Totales del Holocausto",
                                    value: formatNumber(stats.totalVictims),
                                    icon: "person.fill",
                                    color: .red
                                )

                                StatCard(
                                    title: "Víctimas Judías",
                                    value: formatNumber(stats.jewishVictims),
                                    subtitle: "\(String(format: "%.1f", Double(stats.jewishVictims) / Double(stats.totalVictims) * 100))% del total",
                                    icon: "star.fill",
                                    color: .blue
                                )

                                Divider().padding()

                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Otras Víctimas")
                                        .font(.headline)
                                        .padding(.horizontal)

                                    ForEach(stats.otherVictims) { group in
                                        HStack {
                                            Text(group.group)
                                                .font(.subheadline)
                                            Spacer()
                                            VStack(alignment: .trailing, spacing: 2) {
                                                Text(formatNumber(group.count))
                                                    .font(.headline)
                                                Text("\(String(format: "%.1f", group.percentage))%")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal)

                                Divider().padding()

                                // Camps & Ghettos
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Campos y Guetos")
                                        .font(.headline)
                                        .padding(.horizontal)

                                    StatRow(label: "Total de Campos", value: "\(stats.camps.totalCamps)")
                                    StatRow(label: "Campos de Concentración", value: "\(stats.camps.concentrationCamps)")
                                    StatRow(label: "Campos de Exterminio", value: "\(stats.camps.exterminationCamps)")
                                    StatRow(label: "Total de Guetos", value: "\(stats.ghettos.totalGhettos)")
                                    StatRow(label: "Gueto más Grande", value: stats.ghettos.largestGhetto)
                                }
                                .padding(.horizontal)
                            }
                            .padding(.vertical)
                        }
                        .tag(0)

                        // By Country
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(stats.victimsByCountry.sorted { $0.victims > $1.victims }) { country in
                                    CountryBar(country: country, maxVictims: stats.victimsByCountry.map { $0.victims }.max() ?? 1)
                                }
                            }
                            .padding()
                        }
                        .tag(1)

                        // By Camp
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(stats.victimsByCamp.sorted { $0.victims > $1.victims }) { camp in
                                    CampBar(camp: camp, maxVictims: stats.victimsByCamp.map { $0.victims }.max() ?? 1)
                                }
                            }
                            .padding()
                        }
                        .tag(2)

                        // By Year
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(stats.victimsByYear.sorted { $0.year < $1.year }) { year in
                                    YearBar(year: year, maxVictims: stats.victimsByYear.map { $0.victims }.max() ?? 1)
                                }
                            }
                            .padding()
                        }
                        .tag(3)

                        // Resistance
                        ScrollView {
                            VStack(spacing: 16) {
                                StatCard(
                                    title: "Levantamientos",
                                    value: "\(stats.resistance.uprisings)",
                                    icon: "fist.closed",
                                    color: .green
                                )

                                StatCard(
                                    title: "Escapes Documentados",
                                    value: "\(stats.resistance.escapes)",
                                    icon: "arrow.escape",
                                    color: .orange
                                )

                                StatCard(
                                    title: "Rescatados por No-Judíos",
                                    value: formatNumber(stats.resistance.rescuedByNonJews),
                                    subtitle: "Justos entre las Naciones",
                                    icon: "heart.fill",
                                    color: .yellow
                                )

                                StatCard(
                                    title: "Países con Resistencia",
                                    value: "\(stats.resistance.countriesThatResisted)",
                                    icon: "flag.fill",
                                    color: .blue
                                )
                            }
                            .padding()
                        }
                        .tag(4)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .navigationTitle("Estadísticas")
                .onAppear {
                    loadStatistics()
                }
            } else {
                VStack {
                    ProgressView()
                    Text("Cargando estadísticas...")
                        .foregroundColor(.secondary)
                }
                .onAppear {
                    loadStatistics()
                }
            }
        }
    }

    private func loadStatistics() {
        statistics = HolocaustStatistics(
            totalVictims: 17000000,
            jewishVictims: 6000000,
            otherVictims: [
                VictimGroup(group: "Gitanos (Romaní)", count: 500000, percentage: 2.9),
                VictimGroup(group: "Prisioneros Soviéticos", count: 3300000, percentage: 19.4),
                VictimGroup(group: "Polacos Civiles", count: 1800000, percentage: 10.6),
                VictimGroup(group: "Personas con Discapacidades", count: 250000, percentage: 1.5),
                VictimGroup(group: "Homosexuales", count: 15000, percentage: 0.1),
                VictimGroup(group: "Testigos de Jehová", count: 2500, percentage: 0.01),
                VictimGroup(group: "Otros (enemigos políticos, etc)", count: 4635000, percentage: 27.3)
            ],
            victimsByCountry: [
                CountryVictims(country: "Polonia", victims: 3000000, percentage: 50),
                CountryVictims(country: "Unión Soviética", victims: 1400000, percentage: 23.3),
                CountryVictims(country: "Hungría", victims: 430000, percentage: 7.2),
                CountryVictims(country: "Rumania", victims: 280000, percentage: 4.7),
                CountryVictims(country: "Alemania", victims: 165000, percentage: 2.8),
                CountryVictims(country: "Francia", victims: 75000, percentage: 1.25),
                CountryVictims(country: "Austria", victims: 65000, percentage: 1.1),
                CountryVictims(country: "Grecia", victims: 60000, percentage: 1),
                CountryVictims(country: "Otros", victims: 485000, percentage: 8.1)
            ],
            victimsByCamp: [
                CampVictims(camp: "Auschwitz-Birkenau", victims: 1100000, type: "Exterminio"),
                CampVictims(camp: "Treblinka", victims: 870000, type: "Exterminio"),
                CampVictims(camp: "Sobibor", victims: 250000, type: "Exterminio"),
                CampVictims(camp: "Belzec", victims: 500000, type: "Exterminio"),
                CampVictims(camp: "Chelmno", victims: 320000, type: "Exterminio"),
                CampVictims(camp: "Majdanek", victims: 360000, type: "Exterminio"),
                CampVictims(camp: "Gueto de Varsovia", victims: 300000, type: "Gueto"),
                CampVictims(camp: "Dachau", victims: 32000, type: "Concentración")
            ],
            victimsByYear: [
                YearVictims(year: 1933, victims: 500),
                YearVictims(year: 1934, victims: 1000),
                YearVictims(year: 1935, victims: 2000),
                YearVictims(year: 1936, victims: 3000),
                YearVictims(year: 1937, victims: 5000),
                YearVictims(year: 1938, victims: 8000),
                YearVictims(year: 1939, victims: 150000),
                YearVictims(year: 1940, victims: 450000),
                YearVictims(year: 1941, victims: 1500000),
                YearVictims(year: 1942, victims: 3000000),
                YearVictims(year: 1943, victims: 2500000),
                YearVictims(year: 1944, victims: 2800000),
                YearVictims(year: 1945, victims: 2000000)
            ],
            perpetratorsByRole: [
                RoleStatistics(role: "Líderes Políticos", count: 12),
                RoleStatistics(role: "Militares", count: 45),
                RoleStatistics(role: "SS y Gestapo", count: 3000),
                RoleStatistics(role: "Guardias de Campos", count: 7000),
                RoleStatistics(role: "Funcionarios Burocráticos", count: 2000),
                RoleStatistics(role: "Colaboradores Locales", count: 10000)
            ],
            ghettos: GhettoStatistics(
                totalGhettos: 1144,
                largestGhetto: "Gueto de Varsovia",
                largestGhettoPopulation: 450000,
                totalGhettoVictims: 2000000
            ),
            camps: CampStatistics(
                totalCamps: 42000,
                concentrationCamps: 300,
                exterminationCamps: 6,
                totalCampVictims: 5700000,
                largestCamp: "Auschwitz-Birkenau"
            ),
            resistance: ResistanceStatistics(
                uprisings: 23,
                escapes: 7000,
                rescuedByNonJews: 100000,
                countriesThatResisted: 8
            )
        )
    }

    private func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

struct StatCard: View {
    let title: String
    let value: String
    var subtitle: String?
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(value)
                        .font(.title.bold())
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                Image(systemName: icon)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(color)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct StatRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
            Spacer()
            Text(value)
                .font(.subheadline.bold())
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct CountryBar: View {
    let country: CountryVictims
    let maxVictims: Int

    var barWidth: Double {
        Double(country.victims) / Double(maxVictims)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(country.country)
                    .font(.subheadline.bold())
                Spacer()
                Text("\(country.percentage, specifier: "%.1f")%")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemGray6))

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue.opacity(0.7))
                        .frame(width: geo.size.width * barWidth)
                }
            }
            .frame(height: 24)

            Text(String(format: "%,d víctimas", country.victims))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .border(Color(.systemGray5), width: 1)
    }
}

struct CampBar: View {
    let camp: CampVictims
    let maxVictims: Int

    var barWidth: Double {
        Double(camp.victims) / Double(maxVictims)
    }

    var color: Color {
        camp.type == "Exterminio" ? .red : camp.type == "Concentración" ? .orange : .yellow
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(camp.camp)
                        .font(.subheadline.bold())
                    Text(camp.type)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemGray6))

                    RoundedRectangle(cornerRadius: 4)
                        .fill(color.opacity(0.7))
                        .frame(width: geo.size.width * barWidth)
                }
            }
            .frame(height: 24)

            Text(String(format: "%,d víctimas", camp.victims))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .border(Color(.systemGray5), width: 1)
    }
}

struct YearBar: View {
    let year: YearVictims
    let maxVictims: Int

    var barWidth: Double {
        Double(year.victims) / Double(maxVictims)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(year.year)")
                    .font(.subheadline.bold())
                Spacer()
                Text(String(format: "%,d", year.victims))
                    .font(.headline)
                    .foregroundColor(.red)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemGray6))

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.red.opacity(0.6))
                        .frame(width: geo.size.width * barWidth)
                }
            }
            .frame(height: 20)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .border(Color(.systemGray5), width: 1)
    }
}

#Preview {
    StatisticsView()
        .environmentObject(DataManager.shared)
}
