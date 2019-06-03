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
    }
    return left
}

