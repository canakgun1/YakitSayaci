//
//  Alımlar.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 18.07.2023.
//

import Foundation

func alımEkle(_ alım: Alım) {
    
    şimdikiAlımlar.append(alım)
    alımlarıKaydet()
}

func alımlarıKaydet() {
    
    
    let alımlar = şimdikiAlımlar
    let encoder = JSONEncoder()
    
    do {
        
        let encoded = try encoder.encode(alımlar)
        UserDefaults.standard.setValue(encoded, forKey: "Alımlar")
        
    } catch {
        print("JSON Encoder hatası")
    }

}

func alımlarıAl() -> Bool {
    
    guard let alımlarEncoded = UserDefaults.standard.value(forKey: "Alımlar") as? Data else { return false }
    let decoder = JSONDecoder()
    
    do {
        let decoded = try decoder.decode([Alım].self, from: alımlarEncoded)
        şimdikiAlımlar = decoded
        
        return true
        
    } catch {
        
        print("JSON Decoder hatası")
        
        return false
        
    }
    
}

struct Alım: Codable {
    
    var tarih: Date
    var kilometre: Float
    var litre: Float
    var fiyat: Float
    var tamDolum: Bool
    
    
}

var şimdikiAlımlar: [Alım] = [] {
    didSet {
        if let ilk = şimdikiAlımlar.first, !ilk.tamDolum {
            şimdikiAlımlar[0].tamDolum = true
        }
        postN("GüncelAlımlarıGöster")
    }
}
