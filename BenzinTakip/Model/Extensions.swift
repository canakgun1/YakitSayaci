//
//  Extensions.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 20.07.2023.
//

import UIKit
import Foundation
import Security
import MapKit

// MARK: Alert

extension UIViewController {
    
    func alert(başlık: String, mesaj: String) {
        
        let controller = UIAlertController(title: başlık, message: mesaj, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
        
    }
    
    func alert(başlık: String, mesaj: String, actions: [UIAlertAction]) {
        
        let controller = UIAlertController(title: başlık, message: mesaj, preferredStyle: .alert)
        for action in actions {
            controller.addAction(action)
        }
        present(controller, animated: true, completion: nil)
        
    }
    
}

// MARK: Device

public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                       return "iPod touch (5th generation)"
            case "iPod7,1":                                       return "iPod touch (6th generation)"
            case "iPod9,1":                                       return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return "iPhone 4"
            case "iPhone4,1":                                     return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                        return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                        return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                        return "iPhone 5s"
            case "iPhone7,2":                                     return "iPhone 6"
            case "iPhone7,1":                                     return "iPhone 6 Plus"
            case "iPhone8,1":                                     return "iPhone 6s"
            case "iPhone8,2":                                     return "iPhone 6s Plus"
            case "iPhone8,4":                                     return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                        return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                        return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                      return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                      return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                      return "iPhone X"
            case "iPhone11,2":                                    return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                      return "iPhone XS Max"
            case "iPhone11,8":                                    return "iPhone XR"
            case "iPhone12,1":                                    return "iPhone 11"
            case "iPhone12,3":                                    return "iPhone 11 Pro"
            case "iPhone12,5":                                    return "iPhone 11 Pro Max"
            case "iPhone12,8":                                    return "iPhone SE (2nd generation)"
            case "iPhone13,1":                                    return "iPhone 12 mini"
            case "iPhone13,2":                                    return "iPhone 12"
            case "iPhone13,3":                                    return "iPhone 12 Pro"
            case "iPhone13,4":                                    return "iPhone 12 Pro Max"
            case "iPhone14,4":                                    return "iPhone 13 mini"
            case "iPhone14,5":                                    return "iPhone 13"
            case "iPhone14,2":                                    return "iPhone 13 Pro"
            case "iPhone14,3":                                    return "iPhone 13 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":                 return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":                 return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
            case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":                 return "iPad Air"
            case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                          return "iPad Air (4th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":                 return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":                 return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":                 return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                            return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
            case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
            case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
            case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
            case "AppleTV5,3":                                    return "Apple TV"
            case "AppleTV6,2":                                    return "Apple TV 4K"
            case "AudioAccessory1,1":                             return "HomePod"
            case "AudioAccessory5,1":                             return "HomePod mini"
            case "i386", "x86_64", "arm64":                                return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                              return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

// MARK: Time

func formatClock(hour: Int, minute: Int) -> String {
    
    var h = "\(hour)"
    var m = "\(minute)"
    
    if hour < 10 {
        
        h = "0\(hour)"
        
    }
    
    if minute < 10 {
        
        m = "0\(minute)"
        
    }
    
    return h + "." + m
    
}

extension Date {
    
    var saat: String {
        "\(Calendar.current.component(.hour, from: self))"
    }
    
    var dakika: String {
        "\(Calendar.current.component(.minute, from: self))"
    }
    
    var gün: String {
        "\(Calendar.current.component(.day, from: self))"
    }
    var aySayı: String {
        "\(Calendar.current.component(.month, from: self))"
    }
    var ay: String {
        switch Calendar.current.component(.month, from: self) {
        case 1:
            return "Ocak".loc()
        case 2:
            return "Şubat".loc()
        case 3:
            return "Mart".loc()
        case 4:
            return "Nisan".loc()
        case 5:
            return "Mayıs".loc()
        case 6:
            return "Haziran".loc()
        case 7:
            return "Temmuz".loc()
        case 8:
            return "Ağustos".loc()
        case 9:
            return "Eylül".loc()
        case 10:
            return "Ekim".loc()
        case 11:
            return "Kasım".loc()
        case 12:
            return "Aralık".loc()
        default:
            return "Yok".loc()
        }
    }
    var yıl: String {
        "\(Calendar.current.component(.year, from: self))"
    }
    
    var günAy: String {
        gün + " " + ay
    }
    
    var günAyYıl: String {
        gün + " " + ay + " " + yıl
    }
    
    var günAyYılSaatDk: String {
        gün + " " + ay + " " + yıl + " " + saat + ":" + dakika
    }
    
}

// MARK: Numbers

extension Double {
    
    func rounded(decimals: Int) -> Double {
        
        guard decimals > 0 else { return self }
        let num = pow(10, Double(decimals))
        return ((self * num).rounded() / num)
        
    }
    
}

extension Float {
    
    func rounded(decimals: Int) -> Float {
        
        guard decimals > 0 else { return self }
        let num = pow(10, Float(decimals))
        return ((self * num).rounded() / num)
        
    }
    
}

// MARK: Map

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
}

extension CLLocationCoordinate2D {
    
    enum CodingKeys: String, CodingKey {
        
        case latitude
        case longitude
        
    }
}

// MARK: Keychain

class KeyChain {

    class func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
}

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}

func yaz(_ sayı: Int, forKey: String) {
    
    let data = Data(from: sayı)
    KeyChain.save(key: forKey, data: data)
        
}

func al(forKey: String) -> Int {
    
    let val = UserDefaults.standard.integer(forKey: forKey)
    if val != 0 {
        UserDefaults.standard.set(0, forKey: forKey)
        yaz(val, forKey: forKey)
        return val
    }
    
    if let receivedData = KeyChain.load(key: forKey) {
        return receivedData.to(type: Int.self)
    }
    return 0
}

// MARK: Notification

func postN(_ name: String) {
    NotificationCenter.default.post(name: Notification.Name(name), object: nil)
}

func postN(_ name: String, info: [AnyHashable : Any]?) {
    NotificationCenter.default.post(name: Notification.Name(name), object: nil, userInfo: info)
}

func removeN(_ name: String, of observer: Any) {
    NotificationCenter.default.removeObserver(observer, name: Notification.Name(name), object: nil)
}

func addN(_ name: String, to observer: Any, action: Selector) {
    NotificationCenter.default.addObserver(observer, selector: action, name: Notification.Name(name), object: nil)
}

// MARK: Localization

extension String {
    var l: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

func türk() -> Bool {
    
    NSLocale.current.languageCode == "tr"
    
}

// MARK: Views

class RoundedButton10: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
}

class RoundedView8: UIView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 8
    }
    
}

class RoundedView10: UIView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 10
    }
    
}

class RoundedView12: UIView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 12
    }
    
}

class RoundedShadowView10: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        layer.shadowColor = #colorLiteral(red: 0.2174814343, green: 0.2681963146, blue: 0.3689454794, alpha: 1).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

class RoundedShadowView15: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        layer.shadowColor = #colorLiteral(red: 0.2174814343, green: 0.2681963146, blue: 0.3689454794, alpha: 1).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

// MARK: Constraint

extension NSLayoutConstraint {

    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {

        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

extension Float {
    
    var s: String {
        return "\(self)"
    }
    
    var irs: String {
        return "\(Int(self.rounded()))"
    }
    
}

extension String {
    
    
    var fl: Float {
        return Float(self) ?? 0
    }
    var fl0: Float? {
        return Float(self) != 0.0 ? Float(self) : nil
    }
    
}

extension Float {
    
    var unNegate: Float {
        return self < 0 ? 0 : self
    }
    
}

extension Int {
    
    var unNegate: Int {
        return self < 0 ? 0 : self
    }
    
}

extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    guard let text = text, !text.isEmpty else { return }
    let string = NSMutableAttributedString(string: text)
    string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
    attributedText = string
  }
}

func aLabelText(bilgi: [[String : [NSAttributedString.Key : Any]]]) -> NSMutableAttributedString {
    
    let boşString = NSMutableAttributedString(string: "")
    var index = 0
    
    for b in bilgi {
        guard let yazı = b.keys.first else { return NSMutableAttributedString()}
        let attributes = bilgi[index][yazı]
        
        let attributedString = NSMutableAttributedString(string: yazı, attributes: attributes)
        boşString.append(attributedString)
        
        index += 1
    }
    
    return boşString
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String {
    
    func loc() -> String {
        
        var new = self
        
        if let sym = Locale.current.currencySymbol {
            new = new.replacingOccurrences(of: "₺", with: sym)
            new = new.replacingOccurrences(of: "$", with: sym)
        }
        if !Locale.current.usesMetricSystem {

            new = new.replacingOccurrences(of: "km", with: "mi")
            new = new.replacingOccurrences(of: "L", with: "gal")
        }
        
        return NSLocalizedString(new, comment: "")
        
    }
    
}
