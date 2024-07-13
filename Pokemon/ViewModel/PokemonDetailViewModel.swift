//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 13/07/24.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    let detail: PokemonDetail
    
    var imageUrl: String {
        detail.sprites.other.home.frontDefault
    }
    
    var typeString: String {
        detail.types
            .map(\.type)
            .map(\.name)
            .map({$0.capitalized})
            .joined(separator: ", ")
    }
    
    var abilityString: String {
        detail.abilities
            .map(\.ability)
            .map(\.name)
            .map({$0.capitalized})
            .joined(separator: ", ")
    }
    
    var statsString: String {
        detail.stats
            .map(\.stat)
            .map(\.name)
            .map({$0.capitalized})
            .joined(separator: ", ")
    }
    
    init(detail: PokemonDetail) {
        self.detail = detail
    }
}
