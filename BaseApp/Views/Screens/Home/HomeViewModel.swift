import Foundation
import Combine

@MainActor // Este atributo asegura que todas las actualizaciones se hagan en el hilo principal
class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []  // Array de Post publicado
    @Published var error: FetchError?   // Error publicado
    @Published var isLoading = false    // Indicador de carga

    func fetchPosts() async {
        isLoading = true
        defer { isLoading = false }

        do {
            // Esperamos y asignamos los posts a la variable publicada
            self.posts = try await loadPosts()
            error = nil // Limpia cualquier error anterior
        } catch {
            // Manejo de error adecuado, asignamos el error
            self.error = error as? FetchError
        }
    }
}
