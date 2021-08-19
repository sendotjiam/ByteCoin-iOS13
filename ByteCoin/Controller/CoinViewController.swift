//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {
    
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyCoinResult: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self;
        currencyPicker.delegate = self;
        currencyPicker.dataSource = self;
    }
}

// MARK: - COIN
extension CoinViewController : CoinManagerDelegate {
    func didUpdateCoinPrice(_ coinManager : CoinManager, coin : CoinModel) {
        DispatchQueue.main.async {
            self.currencyCoinResult.text = coin.lastPriceString;
            self.currencyLabel.text = coin.selectedCurrency;
        }
    }
    
    func didFailWithError(_ error : Error) {
        print(error);
    }
}

// MARK: - PICKER
extension CoinViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row];
        coinManager.getCoinPrice(for: selectedCurrency);
    }
}
