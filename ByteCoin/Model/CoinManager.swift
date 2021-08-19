//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinPrice(_ coinManager : CoinManager, coin : CoinModel);
    func didFailWithError(_ error : Error);
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "SECRET-API-KEY"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate : CoinManagerDelegate?;
    
    func getCoinPrice(for currency : String) {
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)";
        performRequest(with: urlString);
    }
    
    func performRequest(with urlString : String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default);
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!);
                    self.delegate?.didFailWithError(error!);
                    return;
                }
                if let safeData = data {
                    if let coinData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoinPrice(self, coin: coinData);
                    }
                }
            }
            task.resume();
        }
    }
    
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder();
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data);
            return CoinModel(lastPrice: decodedData.rate, selectedCurrency: decodedData.asset_id_quote, coinType: decodedData.asset_id_base);
        } catch {
            print(error);
            self.delegate?.didFailWithError(error);
            return nil;
        }
    }
}
