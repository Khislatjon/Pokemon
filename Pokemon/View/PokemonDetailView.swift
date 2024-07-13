//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: viewModel.imageUrl))
                .placeholder({
                    ProgressView()
                })
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.size.width)
                .background(Color.green)
            
            VStack(alignment: .leading) {
                Text("**Height:** \(viewModel.detail.height)")
                Text("**Weight:** \(viewModel.detail.weight)")
                Text("**Types:** \(viewModel.typeString)")
                Text("**Abilities:** \(viewModel.abilityString)")
                Text("**Stats:** \(viewModel.statsString)")
            }.padding()
        }.background(Color.white).cornerRadius(16).padding().shadow(radius: 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle(viewModel.detail.name.capitalized)
    }
}
