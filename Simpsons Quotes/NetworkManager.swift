//
//  NetworkManager.swift
//  SimpsonsQuotes
//
//  Created by Yaroslav on 11.10.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(urlString: String, complition: @escaping ([Quote]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error); return
            }
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                print(quotes)
                DispatchQueue.main.async {
                    complition(quotes)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
}

class ImageManager {
    
    static var shared = ImageManager()
    
    func fetchImage(url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
}
