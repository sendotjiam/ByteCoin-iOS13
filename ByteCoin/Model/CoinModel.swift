//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Sendo Tjiam on 19/08/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let lastPrice : Double;
    let selectedCurrency : String;
    let coinType : String;
    
    var lastPriceString : String {
        return String(format: "%.2f", lastPrice);
    }
}
