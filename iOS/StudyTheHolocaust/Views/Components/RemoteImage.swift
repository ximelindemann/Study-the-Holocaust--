import SwiftUI

struct RemoteImage: View {
    let urlString: String?
    let contentMode: ContentMode = .fill
    let height: CGFloat = 300

    var body: some View {
        if let urlString = urlString, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: height)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                        .frame(height: height)
                        .frame(maxWidth: .infinity)
                        .clipped()
                case .failure:
                    VStack(spacing: 8) {
                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        Text("No se pudo cargar la imagen")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(height: height)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                @unknown default:
                    Color(.systemGray6)
                        .frame(height: height)
                }
            }
        } else {
            VStack(spacing: 8) {
                Image(systemName: "photo")
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
                Text("Sin imagen disponible")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    RemoteImage(urlString: "https://via.placeholder.com/400x300")
}
