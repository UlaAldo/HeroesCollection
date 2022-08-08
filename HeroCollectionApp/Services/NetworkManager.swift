//
//  NetworkManager.swift
//  DogsCollectionApp
//
//  Created by Юлия Алдохина on 29/07/22.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchHero(completion: @escaping([Hero]) -> Void) {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let hero = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    completion(hero)
                    print("YES")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
}
