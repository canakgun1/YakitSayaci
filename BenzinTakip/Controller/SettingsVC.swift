//
//  SettingsVC.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 22.06.2026.
//

import UIKit
import StoreKit

class SettingsVC: UIViewController {

    @IBOutlet weak var geriYükleButton: UIButton!
    @IBOutlet weak var kaldırButton: UIButton!
    
    var anaVC: AnaEkranVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if paraAlındı {
            kaldırButton.isHidden = true
        }
    }
    
    @IBAction func geriYükleBasıldı(_ sender: UIButton) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    @IBAction func reklamKaldırBasıldı(_ sender: UIButton) {
        anaVC?.IAPSor()
    }
  

}
