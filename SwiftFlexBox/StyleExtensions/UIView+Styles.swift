//
//  UIView+Styles.swift
//  SwiftFlexBox
//
//  Created by binea on 2019/5/31.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation

extension Style where Base: UIView {
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Style {
        self.base.backgroundColor = color
        return self
    }
}
