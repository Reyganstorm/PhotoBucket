//
//  NetworkManager.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import Foundation

enum Links: String {
    case start = "https://api.unsplash.com/photos/?client_id=bpH1swrQ1vFDTkzwyCoMc5F2DCof1g-WWCJg_3svu0c"
    case random = "https://api.unsplash.com/photos/random/?client_id=bpH1swrQ1vFDTkzwyCoMc5F2DCof1g-WWCJg_3svu0c"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch(from url: String, with completion: @escaping(Result<[GetingResult], NetworkError>) -> Void ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            print(1)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "NO Error description")
                print(2)
                return
            }
            
            do {
                let type = try JSONDecoder().decode([GetingResult].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
                print(3)
            }

        }.resume()
    }
}

class SearchObjectManager {
    static let shared = SearchObjectManager()
    private init() {}
    
    private let token = "bpH1swrQ1vFDTkzwyCoMc5F2DCof1g-WWCJg_3svu0c"
    private let secretToken = "leIHrRpfYzzXr2VdClppuqkxwBaR4lwI_5RKWKivU48"
    
    func fetch(text: String, completion: @escaping(Result<[GetingResult], NetworkError>) -> Void ) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?&query=\(text)") else {
            completion(.failure(.invalidURL))
            print(1)
            return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "error")
                return
            }
            do {
                let res = try JSONDecoder().decode(Results.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(res.results))
                }
            } catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }.resume()
    }
}


class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetch(from url: URL, with completion: @escaping(Data, URLResponse) -> Void) {
        //guard let url = URL(string: url) else { return }
        
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


