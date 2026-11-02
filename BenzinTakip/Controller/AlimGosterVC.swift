//
//  AlimGosterVC.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 21.01.2024.
//

import UIKit

class AlimGosterVC: UIViewController {
    
    @IBOutlet weak var litreLabel: UILabel!
    @IBOutlet weak var litreTextF: UITextField!
    @IBOutlet weak var tamDolumS: UISwitch!
    @IBOutlet weak var fiyatTextF: UITextField!
    @IBOutlet weak var tarihPicker: UIDatePicker!
    @IBOutlet weak var kilometreTextF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        litreLabel.text = UNIT
        tarihPicker.overrideUserInterfaceStyle = .dark
        tamDolumS.layer.opacity = 1.0
        tamDolumS.isOn = false
//        tamDolumSwitch.onTintColor = .white
        tamDolumS.thumbTintColor = #colorLiteral(red: 0.8901960784, green: 0.1450980392, blue: 0.2, alpha: 1)
        tamDolumS.layer.cornerRadius = tamDolumS.frame.height / 2.0
        tamDolumS.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8032857905)
       hideKeyboardWhenTappedAround()
        
        tamDolumS.clipsToBounds = true
        // Do any additional setup after loading the view.
        
        kilometreTextF.text = "\(Int(şimdikiAlımlar[değişecekIndex].kilometre))"
        fiyatTextF.text = "\(Int(şimdikiAlımlar[değişecekIndex].fiyat))"
        litreTextF.text = "\(Float(şimdikiAlımlar[değişecekIndex].litre).rounded(decimals: 2))"
        tamDolumS.isOn = şimdikiAlımlar[değişecekIndex].tamDolum
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func kaydeteBasıldı(_ sender: UIButton) {
        guard let kilometre = kilometreTextF.text!.fl0,
              let litre = litreTextF.text!.replacingOccurrences(of: ",", with: ".").fl0,
              let fiyat = fiyatTextF.text!.fl0 else {
            alert(başlık: "Hata".loc(), mesaj: "Lütfen tüm alanları doğru bir şekilde doldurun.".loc())
            return
        }
        şimdikiAlımlar[değişecekIndex] = Alım(tarih: tarihPicker.date, kilometre: kilometre, litre: litre, fiyat: fiyat, tamDolum: tamDolumS.isOn)
        alımlarıKaydet()
        performSegue(withIdentifier: "anaEkranaDön2", sender: self)
    }
    @IBAction func sileBasıldı(_ sender: UIButton) {
        şimdikiAlımlar.remove(at: değişecekIndex)
        alımlarıKaydet()
        performSegue(withIdentifier: "anaEkranaDön2", sender: self)
    }
    
}
