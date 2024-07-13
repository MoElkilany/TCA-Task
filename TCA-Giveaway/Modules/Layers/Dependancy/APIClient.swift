//
//  APIClient.swift
//  TCA-Givawayes
//
//  Created by Elkilany on 12/07/2024.
//

import Combine
import Foundation
import ComposableArchitecture


struct APIClient {
    let baseURL = Constants.baseURL.rawValue + Constants.giveaways.rawValue
    
    func fetchGiveawaysByPlatform(platform: String? = nil) async throws -> [Giveaway] {
        var urlComponents = URLComponents(string: baseURL)!
        if let platform = platform {
            urlComponents.queryItems = [URLQueryItem(name: Constants.platform.rawValue, value: platform)]
        }
        let (data, _) = try await URLSession.shared.data(from: urlComponents.url!)
        return try JSONDecoder().decode([Giveaway].self, from: data)
    }
    
    func fetchGiveaways() async throws -> [Giveaway] {
        var urlComponents = URLComponents(string: baseURL)!
        let (data, _) = try await URLSession.shared.data(from: urlComponents.url!)
        return try JSONDecoder().decode([Giveaway].self, from: data)
    }
}


extension APIClient: DependencyKey {
    static var liveValue: APIClient = APIClient()
}

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

struct APIError: Error, Equatable {}
