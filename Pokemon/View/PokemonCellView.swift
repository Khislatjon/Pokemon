//
//  PokemonCellView.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import SwiftUI
import Kingfisher

struct PokemonCellView: View {
    @ObservedObject var viewModel: PokemonListViewModel
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            KFImage(URL(string: viewModel.pokemonDetails[pokemon.url]?.sprites.frontDefault ?? ""))
                .placeholder({
                    ProgressView()
                })
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Text(pokemon.name.capitalized).font(.headline)
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("\(pokemon.name). Image of \(pokemon.name).")
        .accessibilityHint("Double tap to open Pokemon stats.")
    }
}
