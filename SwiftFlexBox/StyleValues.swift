//
//  StyleValueExtensions.swift
//  SwiftFlexBox
//
//  Created by binea on 2019/5/31.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation
import yoga

postfix operator %

extension Int {
    public static postfix func % (value: Int) -> YGValue {
        return YGValue(value: Float(value), unit: .percent)
    }
}

extension Float {
    public static postfix func % (value: Float) -> YGValue {
        return YGValue(value: value, unit: .percent)
    }
}

extension CGFloat {
    public static postfix func % (value: CGFloat) -> YGValue {
        return YGValue(value: Float(value), unit: .percent)
    }
}

extension YGValue: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public init(integerLiteral value: Int) {
        self = YGValue(value: Float(value), unit: .point)
    }
    
    public init(floatLiteral value: Float) {
        self = YGValue(value: value, unit: .point)
    }
    
    public init(_ value: Float) {
        self = YGValue(value: value, unit: .point)
    }
    
    public init(_ value: CGFloat) {
        self = YGValue(value: Float(value), unit: .point)
    }
}


public struct PercentValue {
    let value: CGFloat
}

public postfix func % (v: CGFloat) -> PercentValue {
    return PercentValue(value: v)
}

public postfix func % (v: Int) -> PercentValue {
    return PercentValue(value: CGFloat(v))
}

prefix operator -
public prefix func - (p: PercentValue) -> PercentValue {
    return PercentValue(value: -p.value)
}

extension Style {
    func valueOrUndefined(_ value: CGFloat?) -> YGValue {
        if let value = value {
            return YGValue(value)
        } else {
            return YGValueUndefined
        }
    }
    
    func valueOrAuto(_ value: CGFloat?) -> YGValue {
        if let value = value {
            return YGValue(value)
        } else {
            return YGValueAuto
        }
    }
}
