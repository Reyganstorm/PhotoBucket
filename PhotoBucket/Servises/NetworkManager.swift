//
//  NetworkManager.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import Foundation

enum Links: String {
    case start = "https://api.unsplash.com/photos/?client_id=bpH1swrQ1vFDTkzwyCoMc5F2DCof1g-WWCJg_3svu0c"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch(from url: String, with completion: @escaping(Result<[ResultObject], NetworkError>) -> Void ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "NO Error description")
                return
            }
            do {
                let type = try JSONDecoder().decode([ResultObject].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}




class ImageManager {
    static let shared = ImageManager()
    private init() {}
    
    func fetch(from url: URL, with completion: @escaping(Data, URLResponse) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data, let responce = responce else {
                print(error?.localizedDescription ?? "NO ERROR descrioption")
                return
            }
            
            guard url == responce.url else {return}
            
            DispatchQueue.main.async {
                completion(data, responce)
            }
        }.resume()
    }
}


