//
//  Handy+Component.swift
//  HandyUI
//
//  Created by andy.bin on 2019/3/7.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation
import UIKit
precedencegroup MyPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: left                // 结合方向:left, right or none
    assignment: false                  // true=赋值运算符,false=非赋值运算符
}

infix operator <- : MyPrecedence

public func <-(left: UIView, right: [UIView]) -> UIView {
    for item in right {
        left.addSubview(item)
        item.onAddToSupperView(super: left)
    }
    left.onAddAllSubviews(subViews: right)
    return left
}


public protocol ViewStyleValueType { }

extension Int: ViewStyleValueType { }
extension UInt: ViewStyleValueType { }
extension Float: ViewStyleValueType { }
extension Double: ViewStyleValueType { }
extension CGFloat: ViewStyleValueType { }
extension CGSize: ViewStyleValueType { }
extension CGPoint: ViewStyleValueType { }
extension String: ViewStyleValueType { }
extension UIColor: ViewStyleValueType { }
extension UIView.ContentMode: ViewStyleValueType { }

public class ViewStyle: Hashable {
    public static func == (lhs: ViewStyle, rhs: ViewStyle) -> Bool {
        return lhs.key == rhs.key
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    public let key: String
    public let value: ViewStyleValueType
    
    public init(key: ViewStyleKeys, value: ViewStyleValueType) {
        self.key = key.rawValue
        self.value = value
    }
}

public enum StylePosition: ViewStyleValueType {
    case relative
    case absolute
}

public enum StyleDirection: ViewStyleValueType {
    case row
    case rowReverse
    case column
    case columnReverse
}

public enum StyleJustifyContent: ViewStyleValueType {
    case flexStart
    case flexEnd
    case center
    case spaceBetween
    case spaceAround
}

public enum StyleAlignItems: ViewStyleValueType {
    case flexStart
    case flexEnd
    case center
    case baseline
    case stretch
}


public extension Array where Element: Hashable {
    var unique: [Element] {
        var uniq = Set<Element>()
        uniq.reserveCapacity(self.count)
        return self.filter {
            return uniq.insert($0).inserted
        }
    }
}




