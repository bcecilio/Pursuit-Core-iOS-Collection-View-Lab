//
//  CountryAPIClient.swift
//  CountryList-CollectionView
//
//  Created by Brendon Cecilio on 1/14/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation
import NetworkHelper

struct CountryAPIClient {
    static func getCountries(for searchQuery: String, completion: @escaping (Result<[Country], AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "ecuador"
        
        let endpointURL = "https://restcountries.eu/rest/v2/name/\(searchQuery.lowercased())"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let country = try JSONDecoder().decode([Country].self, from: data)
                    let countryData = country
                    completion(.success(countryData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
