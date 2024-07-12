//
//  PokemonList.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import Foundation

struct PokemonList: Decodable {
    var results: [Pokemon]
    var next: String?
    
    init(results: [Pokemon] = [], nextUrl: String? = nil) {
        self.results = results
        self.next = nextUrl
    }
}

struct Pokemon: Decodable, Identifiable, Hashable {
    let id = UUID().uuidString
    let name: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
