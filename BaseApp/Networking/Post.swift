import Foundation

// Define una estructura que coincida con la estructura del JSON
struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum FetchError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

// Renombramos esta función para evitar conflicto con la del ViewModel
func loadPosts() async throws -> [Post] {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        throw FetchError.invalidURL
    }

    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
 (200...299).contains(httpResponse.statusCode) else {
            throw FetchError.requestFailed
        }
        
        do {
            // Aquí se decodifica y se DEVUELVE el array de posts
            return try JSONDecoder().decode([Post].self, from: data)
        } catch {
            throw FetchError.decodingError
        }
    } catch {
        throw error
    }
}

