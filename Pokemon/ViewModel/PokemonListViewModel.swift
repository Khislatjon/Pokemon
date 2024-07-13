//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import Foundation
import Combine

class PokemonListViewModel: ObservableObject {
    private let service = PokemonNetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var pokemonList = PokemonList()
    @Published var state: NetworkState = .loaded
    @Published var pokemonDetails: [String: PokemonDetail] = [:]
    
    
    /// Sends a request using Combine to fetch a list of Pokemons.
    /// Once data is received, maps urls and calls 'fetchPokemonDetails' function.
    func getPokemonList() {
        guard self.state != .idle, let request = service.getRequest(pokemonList.next) else { return }
        self.state = .isLoading
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      200...299 ~= response.statusCode  else {
                          throw URLError(.badServerResponse)
                      }
                return data
            }
            .decode(type: PokemonList.self, decoder: service.jsonDecoder)
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Finished loading")
                case let .failure(error):
                    print("Error", error.localizedDescription)
                    self.state = .error(description: error.localizedDescription)
                }
            } receiveValue: { [weak self] pokemonsReceived in
                guard let self = self else { return }
                self.pokemonList.results += pokemonsReceived.results
                self.pokemonList.next = pokemonsReceived.next
                self.state = pokemonsReceived.results.isEmpty ? .idle : .loaded
                
                Task {
                    let details = try await self.fetchPokemonDetails(urls: pokemonsReceived.results.map(\.url))
                    await MainActor.run {
                        self.pokemonDetails = self.pokemonDetails.merging(details) { cur, _ in cur }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    /// Fetches Pokemon details using Task group and async/await.
    /// - Parameter urls: list of urls to request.
    /// - Returns: A dictionary, where each key is a unique url called and value is a corresponding PokemonDetail model.
    private func fetchPokemonDetails(urls: [String]) async throws -> [String: PokemonDetail] {
        var result: [String: PokemonDetail] = [:]
        try await withThrowingTaskGroup(of: [String: PokemonDetail].self) { group in
            for url in urls {
                group.addTask {
                    guard let request = self.service.getRequest(url) else { throw URLError(.badURL) }
                    let (data, _) = try await URLSession.shared.data(for: request)
                    return [url: try self.service.jsonDecoder.decode(PokemonDetail.self, from: data)]
                }
            }
            for try await d in group {
                result.merge(d) { cur, _ in cur }
            }
        }
        return result
    }
}
