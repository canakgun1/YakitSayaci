//
//  RaporVC.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 22.01.2024.
//

import UIKit

class RaporVC: UIViewController {
    @IBOutlet weak var ilkTarih: UIDatePicker!
    
    @IBOutlet weak var tlKmLabel: UILabel!
    @IBOutlet weak var litreKmLabel: UILabel!
    @IBOutlet weak var paraLabel: UILabel!
    @IBOutlet weak var litreLabel: UILabel!
    @IBOutlet weak var günLabel: UILabel!
    @IBOutlet weak var bilgiStackView: UIStackView!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var sonTarih: UIDatePicker!
    @IBOutlet weak var alımSayısıLabel: UILabel!
    
    @IBAction func ilkDeğişti(_ sender: UIDatePicker) {
        sonTarih.minimumDate = ilkTarih.date
        yazılarıYaz()
    }
    
    @IBAction func sonDeğişti(_ sender: UIDatePicker) {
        ilkTarih.maximumDate = sonTarih.date
        yazılarıYaz()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ilkTarih.overrideUserInterfaceStyle = .dark
        sonTarih.overrideUserInterfaceStyle = .dark
        ilkTarih.date = şimdikiAlımlar.sorted(by: {$0.tarih.timeIntervalSince1970 < $1.tarih.timeIntervalSince1970}).first?.tarih ?? Date()
        ilkTarih.minimumDate = ilkTarih.date
        ilkTarih.maximumDate = şimdikiAlımlar.sorted(by: {$0.tarih.timeIntervalSince1970 < $1.tarih.timeIntervalSince1970}).last?.tarih ?? Date()
        sonTarih.minimumDate = ilkTarih.date
        sonTarih.maximumDate = şimdikiAlımlar.sorted(by: {$0.tarih.timeIntervalSince1970 < $1.tarih.timeIntervalSince1970}).last?.tarih ?? Date()
        sonTarih.date = sonTarih.maximumDate ?? Date()
        
        yazılarıYaz()

        // Do any additional setup after loading the view.
    }
    
    func yazılarıYaz() {
        
        var sayılar = sayılarıBul()
        
        let paraString = aLabelText(bilgi: [["Ödenen ücret: ".loc() : [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]], ["\(Int(sayılar[4]))₺".loc() : [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)]]])
        let litreString = aLabelText(bilgi: [["Alınan yakıt: ".loc() : [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]], ["\(Int(sayılar[3])) \(UNIT)" : [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)]]])
        let kmString = aLabelText(bilgi: [["Mesafe: ".loc() : [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]], ["\(Int(sayılar[2])) km".loc() : [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)]]])
        let günString = aLabelText(bilgi: [["\(Int(sayılar[1])) " : [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)]], ["günde".loc() : [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]]])
        
        paraLabel.attributedText = paraString
        kmLabel.attributedText = kmString
        litreLabel.attributedText = litreString
        günLabel.attributedText = günString
        alımSayısıLabel.text = "\(Int(sayılar[0])) "+"alım bulundu.".loc()
        
        tlKmLabel.text = "\(String(format: "%.2f", sayılar[4] / sayılar[2])) ₺ / km".loc()
        if Locale.current.usesMetricSystem || UNIT.contains("kW") {
            litreKmLabel.text = "\(String(format: "%.1f", sayılar[3] / sayılar[2] * 100)) \(UNIT) / 100 km"
        } else {
            litreKmLabel.text = "\(String(format: "%.1f", sayılar[2] / sayılar[3])) mi / gal"
        }
        
        
    }

    func sayılarıBul() -> [Double] {
        
        var bakılacaklar = şimdikiAlımlar.filter({$0.tarih.timeIntervalSinceReferenceDate <= sonTarih.date.timeIntervalSinceReferenceDate && $0.tarih.timeIntervalSinceReferenceDate >= ilkTarih.date.timeIntervalSinceReferenceDate})
        
        var alımSayısı = Double(bakılacaklar.count)
        var günSayısı = Double((sonTarih.date.timeIntervalSinceReferenceDate - ilkTarih.date.timeIntervalSinceReferenceDate) / 86400 + 1)
        var mesafe = (bakılacaklar.sorted(by: {$0.kilometre < $1.kilometre}).last?.kilometre ?? 1.0) - (bakılacaklar.sorted(by: {$0.kilometre < $1.kilometre}).first?.kilometre ?? 0.5)
        var litre = 0.0
        var para = 0.0
        for alım in bakılacaklar {
//            mesafe += Double(alım.kilometre)
            litre += Double(alım.litre)
            para += Double(alım.fiyat)
        }
        
        return [alımSayısı, günSayısı, Double(mesafe), litre, para]
        
    }

}
