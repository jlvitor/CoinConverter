//
//  Service.swift
//  CoinConverter
//
//  Created by Jean Lucas Vitor on 21/09/22.
//

import Foundation

class Service {
    let baseUrl: String = "https://economia.awesomeapi.com.br"
    
    func getCoins(with pathParam: String, completion: @escaping (ExchangeCoins?, String?) -> Void) {
        let api: String = "\(baseUrl)/json/last/\(pathParam)"
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let apiResponse = try? JSONDecoder().decode(ExchangeCoins.self, from: data) {
                    completion(apiResponse, nil)
                } else if let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    completion(nil, error.message)
                } else {
                    completion(nil, "Erro ao fazer o parse")
                }
            } else if let error = error {
                print(error.localizedDescription)
                completion(nil, nil)
            }
        }.resume()
    }
}
