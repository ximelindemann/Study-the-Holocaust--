import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Study the Holocaust")
                            .font(.title.bold())
                        Text("Educación rigurosa sobre la Shoah y la Alemania nazi")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    // Mission
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Nuestra Misión")
                            .font(.headline)
                        Text("La historia de la Shoah no se puede simplificar. Se enseña con rigor, con fuentes, con nombres.")
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text("Remember. Learn. Never Again.")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Statistics
                    VStack(spacing: 16) {
                        StatItem(
                            title: "Perpetradores",
                            count: dataManager.perpetrators.count,
                            icon: "person.fill"
                        )
                        StatItem(
                            title: "Leyes Nazi",
                            count: dataManager.legislation.count,
                            icon: "doc.text.fill"
                        )
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.vertical)
            }
            .navigationTitle("")
        }
    }
}

struct StatItem: View {
    let title: String
    let count: Int
    let icon: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(count)")
                    .font(.title2.bold())
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(DataManager.shared)
    }
}
