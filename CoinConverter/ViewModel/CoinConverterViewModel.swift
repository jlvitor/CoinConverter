//
//  CoinConverterViewModel.swift
//  CoinConverter
//
//  Created by Jean Lucas Vitor on 21/09/22.
//

import Foundation

class CoinConverterViewModel {
    
    //MARK: - Public properties
    var coinHistory: Coin?
    
    //MARK: - Private properties
    private let service: Service = .init()
    private var exchangeUserDefault: ExchangeUserDefault = .init()
    
    //MARK: - Getters
    var getNumberOfRows: Int {
        getHistoryExchange().count
    }
    
    var getNumberOfSections: Int {
        1
    }
    
    //MARK: - Public methods
    func getCoins(with params: String, completion: @escaping (ExchangeCoins?, String?) -> Void) {
        service.getCoins(with: params) { data, error in
            if let coins = data {
                completion(coins, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func calculateCoins(valueInfo: String?, valueCoin: String?) -> NSNumber {
        guard let value = valueInfo,
              let coin = valueCoin,
              let valueFloat = Float(value),
              let coinFloat = Float(coin) else { return 0 }

        let calc: Float = coinFloat * valueFloat
        
        return NSNumber(value: calc)
    }
    
    func getCoinList() -> [String] {
        return EnumCoins.allCases.map {$0.rawValue}
    }
    
    func saveHistoryExchange(coin: Coin, completion: @escaping (String) -> Void) {
        var coinList: [Coin] = getHistoryExchange()
        
        if coinList.count > 0 {
            let auxList = coinList.filter {$0.code == coin.code && $0.codein == coin.codein}
            if auxList.count > 0 {
                completion("Você já salvou um histórico para esta pesquisa")
            } else {
                coinList.append(coin)
                exchangeUserDefault.save(coinList: coinList)
                completion("Histórico salvo com sucesso")
            }
        } else {
            coinList.append(coin)
            exchangeUserDefault.save(coinList: coinList)
            completion("Histórico salvo com sucesso")
        }
    }
    
    func getHistoryExchange() -> [Coin] {
        return exchangeUserDefault.getCoinList()
    }
}
