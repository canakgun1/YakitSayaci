//
//  AlimEkleVC.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 7.08.2023.
//

import UIKit

class AlimEkleVC: UIViewController {

    @IBOutlet weak var tlYazanLabel: UILabel!
    @IBOutlet weak var litreLabel: UILabel!
    @IBOutlet weak var ekleButton: RoundedShadowButton!
    @IBOutlet weak var tamDolumSwitch: UISwitch!
    @IBOutlet weak var tarihPicker: UIDatePicker!
    @IBOutlet weak var kilometreTextField: UITextField!
    
    @IBOutlet weak var litreTextField: UITextField!
    
    @IBOutlet weak var ödenenTextField: UITextField!
    
    @IBOutlet weak var kmYazanLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        kmYazanLabel.text = "km".loc()
        tlYazanLabel.text = "₺".loc()
        tarihPicker.overrideUserInterfaceStyle = .dark
        tamDolumSwitch.layer.opacity = 1.0
        tamDolumSwitch.isOn = false
        litreLabel.text = UNIT
//        tarihPicker.date = Date()
//        tamDolumSwitch.onTintColor = .white
        tamDolumSwitch.thumbTintColor = #colorLiteral(red: 0.8901960784, green: 0.1450980392, blue: 0.2, alpha: 1)
        tamDolumSwitch.layer.cornerRadius = tamDolumSwitch.frame.height / 2.0
        tamDolumSwitch.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8032857905)
       hideKeyboardWhenTappedAround()
        
        tamDolumSwitch.clipsToBounds = true
//        tarihPicker.minimumDate = şimdikiAlımlar.last?.tarih
        
        
     
        // Do any additional setup after loading the view.
    }
    

    @IBAction func ekleButtonPressed(_ sender: Any) {
        
        guard let kilometre = kilometreTextField.text!.fl0,
              let litre = litreTextField.text!.replacingOccurrences(of: ",", with: ".").fl0,
              let fiyat = ödenenTextField.text!.fl0 else {
            alert(başlık: "Hata".loc(), mesaj: "Lütfen tüm alanları doğru bir şekilde doldurun.".loc())
            return
        }
           
        
//        if let sonAlım = şimdikiAlımlar.last {
//            
//            if sonAlım.kilometre >= kilometre {
//                alert(başlık: "Hata", mesaj: "Lütfen aracınızın kilometresini kontrol edin.")
//                return
//            }
//            
//        }
        
        
        
        alımEkle(Alım(tarih: tarihPicker.date, kilometre: kilometreTextField.text!.fl, litre: litreTextField.text!.replacingOccurrences(of: ",", with: ".").fl, fiyat: ödenenTextField.text!.fl, tamDolum: tamDolumSwitch.isOn))
        
        performSegue(withIdentifier: "anaEkranaDön", sender: self)
        
    }


}
