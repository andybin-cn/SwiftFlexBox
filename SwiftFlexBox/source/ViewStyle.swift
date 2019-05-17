//
//  ViewStyle.swift
//  HandyUI
//
//  Created by andy.bin on 2019/5/14.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation
import UIKit


public extension UIView {
    convenience init(styles: [ViewStyle] = []) {
        self.init()
        let newStyle = styles + ConstraintMaker.defaultStyles
        self.style = newStyle.unique
        self.makeSelfConstraints()
    }
    convenience init(styles: [ViewStyle] = [], viewRef: inout UIView?) {
        self.init(styles: styles)
        viewRef = self
    }
    
    private static var styleKey: Int8 = 0
    internal var style: [ViewStyle] {
        get {
            return (objc_getAssociatedObject(self, &UIView.styleKey) as? [ViewStyle]) ?? ConstraintMaker.defaultStyles
        }
        set(newValue) {
            objc_setAssociatedObject(self, &UIView.styleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    
    @objc func onAddToSupperView(`super`: UIView) {
        
    }
    
    @objc func onAddAllSubviews(subViews: [UIView]) {
        ConstraintMaker.makeRelatedConstraints(currentView: self, subViews: subViews)
    }
    
    @objc func makeSelfConstraints() {
        let styles = self.style
        if let width = styles.style(for: ViewStyleKeys.width)?.value as? CGFloat {
            self.snp.makeConstraints { (make) in
                make.width.equalTo(width)
            }
        }
        if let height = styles.style(for: ViewStyleKeys.height)?.value as? CGFloat {
            self.snp.makeConstraints { (make) in
                make.height.equalTo(height)
            }
        }
        self.backgroundColor = styles.style(for: .background)?.value as? UIColor
        self.alpha = styles.style(for: ViewStyleKeys.alpha)?.value as? CGFloat ?? 1.0
        if let contentMode = styles.style(for: ViewStyleKeys.contentMode)?.value as? UIView.ContentMode {
            self.contentMode = contentMode
        }
    }
}

public class ViewStyleKeys {
    public let rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    
    public static let position = ViewStyleKeys(rawValue: "position")
    
    public static let left = ViewStyleKeys(rawValue: "left")
    public static let right = ViewStyleKeys(rawValue: "right")
    public static let top = ViewStyleKeys(rawValue: "top")
    public static let bottom = ViewStyleKeys(rawValue: "bottom")
    public static let width = ViewStyleKeys(rawValue: "width")
    public static let height = ViewStyleKeys(rawValue: "height")
    
    public static let background = ViewStyleKeys(rawValue: "background")
    public static let alpha = ViewStyleKeys(rawValue: "alpha")
    public static let contentMode = ViewStyleKeys(rawValue: "contentMode")
    
    public static let direction = ViewStyleKeys(rawValue: "direction")
    public static let justifyContent = ViewStyleKeys(rawValue: "justifyContent")
    public static let alignItems = ViewStyleKeys(rawValue: "alignItems")
    public static let alignSelf = ViewStyleKeys(rawValue: "alignSelf")
    public static let flexGrow = ViewStyleKeys(rawValue: "flexGrow")
    public static let flexShrink = ViewStyleKeys(rawValue: "flexShrink")
}

public extension ViewStyle {
    static func position(_ value: StylePosition) -> ViewStyle {
        return ViewStyle(key: .position, value: value)
    }
    
    static func left(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .left, value: value)
    }
    static func right(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .right, value: value)
    }
    static func top(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .top, value: value)
    }
    static func bottom(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .bottom, value: value)
    }
    static func width(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .width, value: value)
    }
    static func height(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .height, value: value)
    }
    
    static func background(_ value: UIColor) -> ViewStyle {
        return ViewStyle(key: .background, value: value)
    }
    static func alpha(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .alpha, value: value)
    }
    static func contentMode(_ value: UIView.ContentMode) -> ViewStyle {
        return ViewStyle(key: .contentMode, value: value)
    }
    
    static func direction(_ value: StyleDirection) -> ViewStyle {
        return ViewStyle(key: .direction, value: value)
    }
    static func justifyContent(_ value: StyleJustifyContent) -> ViewStyle {
        return ViewStyle(key: .justifyContent, value: value)
    }
    static func alignItems(_ value: StyleAlignItems) -> ViewStyle {
        return ViewStyle(key: .alignItems, value: value)
    }
    static func alignSelf(_ value: StyleAlignItems) -> ViewStyle {
        return ViewStyle(key: .alignSelf, value: value)
    }
    static func flexGrow(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .flexGrow, value: value)
    }
    static func flexShrink(_ value: CGFloat) -> ViewStyle {
        return ViewStyle(key: .flexShrink, value: value)
    }
}


