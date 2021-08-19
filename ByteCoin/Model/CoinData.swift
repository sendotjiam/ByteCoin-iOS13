//
//  CoinData.swift
//  ByteCoin
//
//  Created by Sendo Tjiam on 19/08/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData : Codable {
    let rate : Double;
    let asset_id_quote : String;
    let asset_id_base : String;
}
