//
//  TextStyle.swift
//  HandyUI
//
//  Created by andy.bin on 2019/5/14.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation
import UIKit

extension UIFont: ViewStyleValueType { }
extension NSTextAlignment: ViewStyleValueType { }

public extension ViewStyleKeys {
    static let textColor = ViewStyleKeys(rawValue: "textColor")
    static let text = ViewStyleKeys(rawValue: "text")
    static let font = ViewStyleKeys(rawValue: "font")
    static let fontSize = ViewStyleKeys(rawValue: "fontSize")
    static let textAlign = ViewStyleKeys(rawValue: "textAlign")
}

public extension ViewStyle {
    static func textColor(_ value: UIColor) -> ViewStyle {
        return ViewStyle(key: .textColor, value: value)
    }
    static func text(_ value: String) -> ViewStyle {
        return ViewStyle(key: .text, value: value)
    }
    static func font(_ value: UIFont) -> ViewStyle {
        return ViewStyle(key: .font, value: value)
    }
    static func fontSize(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .fontSize, value: value)
    }
    static func textAlign(_ value: NSTextAlignment) -> ViewStyle {
        return ViewStyle(key: .textAlign, value: value)
    }
}

public extension UILabel {
    
    convenience init(styles: [ViewStyle] = [], labelRef: inout UILabel?) {
        self.init(styles: styles)
        labelRef = self
    }
    
    @objc override func makeSelfConstraints() {
        super.makeSelfConstraints()
        let styles = self.style
        if let textColor = styles.style(for: .textColor)?.value as? UIColor {
            self.textColor = textColor
        }
        self.text = styles.style(for: .text)?.value as? String
        if let fontSize = styles.style(for: .fontSize)?.value as? CGFloat {
            self.font = UIFont.systemFont(ofSize: fontSize)
        }
        if let font = styles.style(for: .font)?.value as? UIFont {
            self.font = font
        }
        if let textAlign = styles.style(for: .textAlign)?.value as? NSTextAlignment {
            self.textAlignment = textAlign
        }
    }
}
