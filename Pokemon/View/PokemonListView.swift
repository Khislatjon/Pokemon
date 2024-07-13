//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { pokemon in
                    NavigationLink(value: pokemon) {
                        PokemonCellView(viewModel: viewModel, pokemon: pokemon)
                    }
                    
                    if pokemon == viewModel.pokemonList.results.last, searchText.isEmpty {
                        lastRowView.onAppear {
                            viewModel.getPokemonList()
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Pokemons")
            .task {
                viewModel.getPokemonList()
            }
            .navigationTitle("Pokemons")
            .navigationDestination(for: Pokemon.self) { pokemon in
                if let detail = viewModel.pokemonDetails[pokemon.url] {
                    PokemonDetailView(viewModel: PokemonDetailViewModel(detail: detail))
                }
            }
        }
    }
    
    private var searchResults: [Pokemon] {
        guard !searchText.isEmpty else { return viewModel.pokemonList.results }
        return viewModel.pokemonList.results.filter { $0.name.hasPrefix(searchText.lowercased()) }
    }
    
    private var lastRowView: some View {
        ZStack(alignment: .center) {
            switch viewModel.state {
            case .isLoading:
                ProgressView().frame(maxWidth: .infinity)
            case .idle, .loaded:
                EmptyView()
            case let .error(description):
                Text(description).foregroundColor(.red)
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
