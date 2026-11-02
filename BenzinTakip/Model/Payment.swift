//
//  Payment.swift
//  Yakıt Sayacı
//
//  Created by CAN AKGUN on 22.06.2026
//

import Foundation
import StoreKit


class StoreObserver: NSObject, SKPaymentTransactionObserver {
    
    override init() {
        super.init()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("Purchasing")
            // Do not block the UI. Allow the user to continue using the app.
            case .deferred:
                print("Deferred")
            // The purchase was successful.
            case .purchased:
                yaz(1, forKey: "IAP")
                
                paraAlındı = true
                print("Purchased")
                postN("ParaAlındı")
            // The transaction failed.
            case .failed:
                print("Faied")
                postN("ParaAlındı")
            // There're restored products.
            case .restored:
                yaz(1, forKey: "IAP")
                paraAlındı = true
                print("Restored")
                postN("ParaAlındı")
            default:
                print("Default")
                postN("ParaAlındı")
                }
            }
    }
    
}
extension SKProductsRequestDelegate {
    
    func IAPSor() {
        
        print("Para alındı \(paraAlındı)")
        guard !paraAlındı else {return}
        
        if SKPaymentQueue.canMakePayments() {
            
            var productId = "YakitReklamlariKaldir"
            var isim = ""
            
            
            
            
            
            let productIdentifiers: Set = [productId]
               
               // Initialize the product request with the above identifiers.
            let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
            productRequest.delegate = self
               
               // Send the request to the App Store.
            productRequest.start()
        }
        
    }
}

var paraAlındı = false
let iapObserver = StoreObserver()
