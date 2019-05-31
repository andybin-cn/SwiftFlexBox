//
//  UITextField+Styles.swift
//  SwiftFlexBox
//
//  Created by binea on 2019/5/31.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation


extension Style where Base: UITextField {
    @discardableResult
    public func textColor(_ color: UIColor) -> Style {
        self.base.textColor = color
        return self
    }
    
    @discardableResult
    public func text(_ text: String) -> Style {
        self.base.text = text
        return self
    }
    
    @discardableResult
    public func textAlignment(_ textAlignment: NSTextAlignment) -> Style {
        self.base.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> Style {
        self.base.font = font
        return self
    }
    
    @discardableResult
    public func placeholder(_ placeholder: String) -> Style {
        self.base.placeholder = placeholder
        return self
    }
    
    @discardableResult
    public func keyboardType(_ keyboardType: UIKeyboardType) -> Style {
        self.base.keyboardType = keyboardType
        return self
    }
}
