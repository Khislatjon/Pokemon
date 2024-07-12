//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemonDetail: PokemonDetail?
    
    var body: some View {
        Text(pokemonDetail?.sprites.frontDefault ?? "Null")
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemonDetail: nil)
    }
}
