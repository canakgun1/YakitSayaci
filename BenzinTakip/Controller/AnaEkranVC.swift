//
//  AnaEkranVC.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 11.07.2023.
//

import UIKit
import GoogleMobileAds
import StoreKit

class AnaEkranVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GADFullScreenContentDelegate, SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let product = response.products.first!
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    

    @IBOutlet weak var ayarlarButton: UIBarButtonItem!
    @IBOutlet weak var tlYazanLabel: UILabel!
    @IBOutlet weak var kmYazanLabel: UILabel!
    @IBOutlet weak var litreLabel: UILabel!
    @IBOutlet weak var yakıtlarTableView: UITableView!
    var bannerView: GADBannerView!
    var interstitial: GADInterstitialAd!
    var raporaGidilecek: Bool = false
    var ilkReklam = true
    
    func loadAd() {
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: ANA_ID, request: request, completionHandler: { [self] ad, error in
            
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
            postN("ReklamYüklendi")
        }
        )
        
    }
    func presentAd(rapor: Bool) {
        
        if interstitial != nil {
            raporaGidilecek = rapor
            interstitial?.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        
    }
    
    func raporGöster() {
        performSegue(withIdentifier: "raporSegue", sender: self)
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        
        if raporaGidilecek {
            raporGöster()
        }
        if !paraAlındı{
            loadAd()
        }
        
    }
    
    @objc func updateAlımlar() {
        yakıtlarTableView.reloadData()
    }
    
    @objc func reklamYüklendi() {
        if ilkReklam {
            if !paraAlındı {
                presentAd(rapor: false)
                ilkReklam = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kmYazanLabel.text = "km".loc()
        tlYazanLabel.text = "₺".loc()
        
        edgesForExtendedLayout = []

        yakıtlarTableView.dataSource = self
        yakıtlarTableView.delegate = self
        yakıtlarTableView.separatorColor = .white
        
        addN("GüncelAlımlarıGöster", to: self, action: #selector(updateAlımlar))
        addN("ReklamYüklendi", to: self, action: #selector(reklamYüklendi))
        
        _ = alımlarıAl()
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)

        addBannerViewToView(bannerView)
        
        if !paraAlındı {
            
            bannerView.adUnitID = ANA_BANNER
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            
            loadAd()
            
        }
        
        if TIP == 0 {
            alert(başlık: "Araç Tipi".loc(), mesaj: "Aracınız akaryakıtlı mı yoksa elektrikli mi?".loc(), actions: [
                UIAlertAction(title: "Akaryakıtlı".loc(), style: .default, handler: {_ in TIP = 1; UserDefaults.standard.setValue(TIP, forKey: "TIP");self.litreLabel.text = UNIT}),
                UIAlertAction(title: "Elektrikli".loc(), style: .default, handler: {_ in TIP = 2; UserDefaults.standard.setValue(TIP, forKey: "TIP");self.litreLabel.text = UNIT})
            ])
        } else {
            litreLabel.text = UNIT
        }
        

    }
    
    
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    
    func rowListesiOluştur() -> [Any] {
        
        var liste: [Any] = []
        
        var sonTamDolum = 0
        
        for rowIndex in 0..<şimdikiAlımlar.count {
            
           
            var buAlım = şimdikiAlımlar[rowIndex]
            
            guard rowIndex != 0 else {
                if buAlım.tamDolum {
                    sonTamDolum = rowIndex
                }
                liste.append(buAlım)
                continue
            }
            
            
            
            if buAlım.tamDolum /*&& sonTamDolum >= 0*/ {
                
                var kmFarkı = buAlım.kilometre - şimdikiAlımlar[sonTamDolum].kilometre
                var benzin: Float = 0.0
                for alımIndex in (sonTamDolum + 1)...rowIndex {
                    benzin += şimdikiAlımlar[alımIndex].litre
                }
                benzin.round(.up)
                kmFarkı.round(.up)
            
                liste.append([kmFarkı, benzin, benzin / kmFarkı])

                sonTamDolum = rowIndex
                
            }
            
            liste.append(buAlım)
            
            
        }

        return liste
        
    }
    
    func alımIndexi(index: Int) -> Int {
        
        var gerçekler = 0
        
        for r in 0...index {
            
            if bilgi(row: r).0 != nil {
                gerçekler += 1
            }
            
        }
            
        return gerçekler
        
    }
    
    func bilgi(row: Int) -> (Alım?, [Float]?) {
        
        var rowlar = rowListesiOluştur()
        
        
        if rowlar[row] is Alım {
            
            print(1)
            //print(rowlar[row])
            
            return (rowlar[row] as? Alım ?? Alım(tarih: Date(), kilometre: 12, litre: 34, fiyat: 56, tamDolum: true), nil)
            
        } else {
  
            return (nil, (rowlar[row] as? [Float]))
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let alım = bilgi(row: indexPath.row).0, let cell = tableView.dequeueReusableCell(withIdentifier: "YakıtCell") as? AnaEkranTableViewCell {
            
            cell.litreLabel.text = "\(alım.litre.rounded(decimals: 2))"
            cell.doluLabel.text = alım.tamDolum ? "Dolu".loc() : ""
            cell.fiyatLabel.text = alım.fiyat.irs + " ₺".loc()
            cell.kmLabel.text = alım.kilometre.irs + " km".loc()
            cell.tarihLabel.text =
            alım.tarih.gün + " " + alım.tarih.ay + " '" + alım.tarih.yıl.suffix(2)
//            cell.tarihLabel.addCharacterSpacing(kernValue: 1.0)
            
            return cell
            
        } else if let boşData = bilgi(row: indexPath.row).1, let cell = tableView.dequeueReusableCell(withIdentifier: "YaziCell") as? YaziTableViewCell {
            
            cell.araLabel.text = "\(Int(boşData[0]))" + " km'de ".loc() +  "\(Int(boşData[1])) \(UNIT)"
            if Locale.current.usesMetricSystem || UNIT.contains("kW") {
                cell.yüzdeLabel.text = "\(String(format: "%.1f", boşData[2] * 100)) \(UNIT) / "+"100 km".loc()
            } else {
                cell.yüzdeLabel.text = "\(String(format: "%.1f", 1/boşData[2])) km / ".loc()+"gal"
            }
            
            
            return cell
            
        }
        
        return UITableViewCell()
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return rowListesiOluştur().count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        değişecekIndex = alımIndexi(index: indexPath.row) - 1
        if let cell = tableView.cellForRow(at: indexPath) as? AnaEkranTableViewCell {
            performSegue(withIdentifier: "alımGösterSegue", sender: self)
        } else {
            yakıtlarTableView.deselectRow(at:indexPath, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if yakıtlarTableView.indexPathForSelectedRow != nil {
            yakıtlarTableView.deselectRow(at:yakıtlarTableView.indexPathForSelectedRow!, animated: true)
        }
        yakıtlarTableView.scrollToBottomRow()
        puanlamaAl()
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        if yakıtlarTableView.indexPathForSelectedRow != nil {
            yakıtlarTableView.deselectRow(at:yakıtlarTableView.indexPathForSelectedRow!, animated: true)
        }
        
    }
    
    @IBAction func raporaBasıldı(_ sender: UIButton) {
        if şimdikiAlımlar.count > 1 {
            if !paraAlındı {
                presentAd(rapor: true)
            }
            
        } else {
            alert(başlık: "Hata".loc(), mesaj: "Lütfen alımlarınızı ekleyin.".loc())
        }
        
    }
    
    func puanlamaAl() {
        
        let başlangıç = UserDefaults.standard.value(forKey: "Başlangıç") as? Date ?? Date(timeIntervalSince1970: 0)
        
        if Date().timeIntervalSince1970 - başlangıç.timeIntervalSince1970 > 1 * 1 * 60 * 60 && Date().timeIntervalSince1970 - (UserDefaults.standard.value(forKey: "SonPuanİsteme") as? Date ?? Date(timeIntervalSince1970: 0)).timeIntervalSince1970 > 1 * 1 * 60 * 60 {
            SKStoreReviewController.requestReview()
            UserDefaults.standard.set(Date(), forKey: "SonPuanİsteme")
            UserDefaults.standard.setValue(UserDefaults.standard.integer(forKey: "Puanİsteme") + 1, forKey: "Puanİsteme")
            
        }
        
        
    }
    
    @IBAction func ayarlarButtonBasıldı(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "settingsSegue", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SettingsVC {
            destination.anaVC = self
        }
    }
}
var değişecekIndex = 0

