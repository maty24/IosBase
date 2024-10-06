//
//  HomeScreen.swift
//  BaseApp
//
//  Created by Matias Godoy on 06-10-24.
//

import SwiftUI


struct PostsView: View {
    @StateObject private var viewModel = PostsViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    // Muestra un indicador de carga mientras se obtienen los datos
                    ProgressView("Cargando Posts...")
                } else if let error = viewModel.error {
                    // Muestra el mensaje de error si algo falla
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                } else {
                    // Muestra la lista de posts una vez que los datos han sido cargados
                    List(viewModel.posts) { post in
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.body)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .onAppear {
                // Cargar los posts cuando la vista aparece
                Task {
                    await viewModel.fetchPosts()
                }
            }
        }
    }
}
