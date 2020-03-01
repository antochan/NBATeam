//
//  webService.swift
//  NBATeams
//
//  Created by Antonio Chan on 2020/2/29.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

class WebService {
    
    static let shared = WebService()
    
    enum APPError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }
    
    enum Result<T> {
        case success(T)
        case failure(APPError)
    }
    
    func fetchData<T: Decodable>(urlString: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { (data, response, err) in
            guard err == nil else {
                completion(Result.failure(.networkError(err!)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(.dataNotFound))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(objectType, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                completion(Result.failure(.jsonParsingError(error as! DecodingError)))
            }
        }
        task.resume()
    }
}
