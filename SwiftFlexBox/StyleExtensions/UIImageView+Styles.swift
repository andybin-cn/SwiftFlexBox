//
//  UIImageView+Styles.swift
//  SwiftFlexBox
//
//  Created by binea on 2019/5/31.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation


public enum ImageSource {
    case image(UIImage)
    case named(String)
    case url(String)
}

extension Style where Base: UIImageView {
    @discardableResult
    public func image(_ source: ImageSource) -> Style {
        switch source {
        case .image(let image):
            self.base.image = image
        case .named(let imageName):
            self.base.image = UIImage(named: imageName)
        case .url( _):
            fatalError("has not implementation! ")
            break;
        }
        return self
    }
}
