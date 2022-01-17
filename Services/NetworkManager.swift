//
//  NetworkManager.swift
//  Just2Drink
//
//  Created by Alexander Kovzhut on 09.01.2022.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a"
    
    func fetchData(with complition: @escaping (CocktailDB) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let cocktailList = try JSONDecoder().decode(CocktailDB.self, from: data)
                DispatchQueue.main.async {
                    complition(cocktailList)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchDrink(completion: @escaping(Drink) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "no descripption")
                return
            }
            
            do {
                let drink = try JSONDecoder().decode(Drink.self, from: data)
                DispatchQueue.main.async {
                    completion(drink)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
