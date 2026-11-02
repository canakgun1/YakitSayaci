//
//  AppDelegate.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 19.06.2023.
//

import UIKit
import GoogleMobileAds
import StoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window?.backgroundColor = .white
        
        if UserDefaults.standard.value(forKey: "TIP") == nil {
            TIP = 0
        } else {
            TIP = Int("\(UserDefaults.standard.value(forKey: "TIP")!)") ?? 0
        }
        
        if let başlangıç = UserDefaults.standard.value(forKey: "Başlangıç") as? Date {
            
        } else {
            UserDefaults.standard.set(Date(), forKey: "Başlangıç")
        }
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        if #available(iOS 13.0, *) {
            application.statusBarStyle = .lightContent
           
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.1450980392, blue: 0.2, alpha: 1)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.8901960784, green: 0.1450980392, blue: 0.2, alpha: 1)
            UINavigationBar.appearance().isTranslucent = false
        }
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "f83f9180af89fc823964031d0bdae724" ]
        
        SKPaymentQueue.default().add(iapObserver)
        if al(forKey: "IAP") == 1 {
            paraAlındı = true
        }
        
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        SKPaymentQueue.default().remove(iapObserver)
    }

 
}

var TIP = 0 {
    didSet {
        if TIP == 1 {
            UNIT = "L".loc()
        } else if TIP == 2 {
            UNIT = "kWs".loc()
        }
    }
}
var UNIT = ""
