//
//  PokemonNetworkService.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import Foundation

class PokemonNetworkService {
    static let shared = PokemonNetworkService()
    let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func getRequest(_ urlString: String?) -> URLRequest? {
        let urlString = urlString ?? baseUrl
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
}
