//
//  FavoritesManager.swift
//  Givawayes
//
//  Created by Elkilany on 13/07/2024.
//

import Foundation
import ComposableArchitecture

class FavoritesManager {
    
    // MARK: - The class uses the Singleton pattern to ensure there's only one instance of FavoritesManager throughout the application
    static let shared = FavoritesManager()
   
 
     func getFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: Constants.favoriteKey.rawValue) as? [Int] ?? []
    }
    
    func saveFavorite(id: Int) {
        var favorites = getFavorites()
        if !favorites.contains(id) {
            favorites.append(id)
        }
        UserDefaults.standard.set(favorites, forKey: Constants.favoriteKey.rawValue)
    }
    
    func removeFavorite(id: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
        }
        UserDefaults.standard.set(favorites, forKey: Constants.favoriteKey.rawValue)
    }
    
    
    func isFavorite(id: Int) -> Bool {
        return getFavorites().contains(id)
    }
}



extension FavoritesManager: DependencyKey {
    static var liveValue: FavoritesManager = FavoritesManager()
}

extension DependencyValues {
    var favoritesManager: FavoritesManager {
        get { self[FavoritesManager.self] }
        set { self[FavoritesManager.self] = newValue }
    }
}
