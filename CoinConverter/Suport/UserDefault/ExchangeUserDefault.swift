//
//  ExchangeUserDefault.swift
//  CoinConverter
//
//  Created by Jean Lucas Vitor on 21/09/22.
//

import Foundation

class ExchangeUserDefault {
    
    let keyHistory: String = "keyHistory"
    
    func save(coinList: [Coin]) {
        do {
            let list = try JSONEncoder().encode(coinList)
            UserDefaults.standard.setValue(list, forKey: keyHistory)
        } catch {
            print(error)
        }
    }
    
    func getCoinList() -> [Coin] {
        do {
            guard let list = UserDefaults.standard.object(forKey: keyHistory) else { return [] }
            let auxList = try JSONDecoder().decode([Coin].self, from: list as! Data)
            return auxList
        } catch {
            print(error)
        }
        return []
    }
    
}
