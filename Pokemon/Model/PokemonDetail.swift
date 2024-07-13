//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import Foundation

struct PokemonDetail: Decodable {
    let sprites: Sprite
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let abilities: [Ability]
    let stats: [Stats]
}

struct Sprite: Decodable {
    let frontDefault: String
    let other: HomeSprite
}

struct HomeSprite: Decodable {
    let home: FrontSprite
}

struct FrontSprite: Decodable {
    let frontDefault: String
}

struct PokemonType: Decodable {
    let type: Name
}

struct Ability: Decodable {
    let ability: Name
}

struct Stats: Decodable {
    let stat: Name
}

struct Name: Decodable {
    let name: String
}
