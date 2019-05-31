//
//  Style.swift
//  SwiftFlexBox
//
//  Created by binea on 2019/5/31.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation

public struct Style<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol StyleCompatible {
    associatedtype StyleBase
    
    var style: Style<StyleBase> { get }
}

extension StyleCompatible {
    public var style: Style<Self> {
        get {
            return Style(self)
        }
    }
}

import class UIKit.UIView

extension UIView: StyleCompatible { }
