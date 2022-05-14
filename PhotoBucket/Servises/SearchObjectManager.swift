//
//  SearchObjectManager.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 14.05.2022.
//

import Foundation

class SearchObjectManager {
    static let shared = SearchObjectManager()
    private init() {}
    
    private let token = "bpH1swrQ1vFDTkzwyCoMc5F2DCof1g-WWCJg_3svu0c"
    private let secretToken = "leIHrRpfYzzXr2VdClppuqkxwBaR4lwI_5RKWKivU48"
    
    func fetch(text: String, completion: @escaping(Result<[ResultObject], NetworkError>) -> Void ) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?&query=\(text)") else {
            completion(.failure(.invalidURL))
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
