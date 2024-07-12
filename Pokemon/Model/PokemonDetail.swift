//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import Foundation

struct PokemonDetail: Decodable {
    let sprites: PokemonSprite
}

struct PokemonSprite: Decodable {
    let frontDefault: String
}
