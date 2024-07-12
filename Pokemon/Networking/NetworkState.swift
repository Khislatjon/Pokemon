//
//  NetworkState.swift
//  Pokemon
//
//  Created by Khislatjon Valijonov on 12/07/24.
//

import Foundation

enum NetworkState: Equatable {
    case isLoading
    case idle
    case loaded
    case error(description: String)
}
