//
//  NetworkingManager.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/08.
//

import UIKit

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func fetchTheme(completion: @escaping NetworkingCompletion) {
        print(#function)
        let urlString = ThemeAPI.requestURL
        preformRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    func preformRequest(with urlString: String ,completion: @escaping NetworkingCompletion) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("ERROR: error calling GET")
                return
            }
            
            guard let safeData = data else {
                print("ERROR: Did not receive safeData")
                return
            }
            
            if let themes = self.parseJSON(safeData) {
                completion(.success(themes))
            } else {
                print("ERROR: JSON Parsing Failed")
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    func parseJSON(_ themeData: Data) -> [Theme]? {
        do {
            let themes = try JSONDecoder().decode([Theme].self, from: themeData)
            return themes
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadImage(_ urlString: String, imageView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            guard urlString == url.absoluteString else {
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    
    
}
