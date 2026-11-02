//
//  RoundedViews.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 11.07.2023.
//

import Foundation
import UIKit

class RoundedShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.shadowColor = #colorLiteral(red: 0.2174814343, green: 0.2681963146, blue: 0.3689454794, alpha: 1).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

class RoundedImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

class RoundedShadowButton: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = 5
        layer.shadowColor = #colorLiteral(red: 0.2174814343, green: 0.2681963146, blue: 0.3689454794, alpha: 1).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

class RoundedShadowButton10: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.shadowColor = #colorLiteral(red: 0.2174814343, green: 0.2681963146, blue: 0.3689454794, alpha: 1).cgColor
        layer.shadowOpacity = 0.85
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 15
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
}


class RoundedShadowView2: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.shadowColor = #colorLiteral(red: 0.2174814343, green: 0.2681963146, blue: 0.3689454794, alpha: 1).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

class RoundedView: UIView {
    override func awakeFromNib() {
        layer.cornerRadius = 10
    }
}

class RoundedStackView: UIStackView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.shadowColor = #colorLiteral(red: 0.2174814343, green: 0.2681963146, blue: 0.3689454794, alpha: 1).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}
