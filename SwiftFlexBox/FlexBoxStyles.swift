//
//  FlexBoxStyles.swift
//  SwiftFlexBox
//
//  Created by binea on 2019/5/31.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation
import YogaKit
import yoga

extension Style where Base: UIView {
    private var yoga: YGLayout {
        return base.yoga
    }
    
    public func layout(mode: LayoutMode = .fitContainer) -> Base {
        self.yoga.isEnabled = true
        if case .fitContainer = mode {
            yoga.applyLayout(preservingOrigin: true)
        } else {
            yoga.applyLayout(preservingOrigin: true, dimensionFlexibility: mode == .adjustWidth ? YGDimensionFlexibility.flexibleWidth : YGDimensionFlexibility.flexibleHeight)
        }
        return base
    }
    
    //MARK: - Flex Basic

    @discardableResult
    public func display(_ value: Display) -> Style {
        yoga.display = value.yogaValue
        return self
    }
    
    @discardableResult
    public func direction(_ value: Direction) -> Style {
        yoga.flexDirection = value.yogaValue
        return self
    }
    
    @discardableResult
    public func wrap(_ value: Wrap) -> Style {
        yoga.flexWrap = value.yogaValue
        return self
    }
    
    @discardableResult
    public func layoutDirection(_ value: LayoutDirection) -> Style {
        yoga.direction = value.yogaValue
        return self
    }
    
    @discardableResult
    public func justifyContent(_ value: JustifyContent) -> Style {
        yoga.justifyContent = value.yogaValue
        return self
    }
    
    
    @discardableResult
    public func alignItems(_ value: AlignItems) -> Style {
        yoga.alignItems = value.yogaValue
        return self
    }
    
    
    @discardableResult
    public func alignSelf(_ value: AlignSelf) -> Style {
        yoga.alignSelf = value.yogaValue
        return self
    }
    
    
    @discardableResult
    public func alignContent(_ value: AlignContent) -> Style {
        yoga.alignContent = value.yogaValue
        return self
    }
    
    @discardableResult
     public func overflow(_ value: Overflow) -> Style {
        yoga.overflow = value.yogaValue
        return self
     }
    
    //MARK: - grow / shrink / basis
    
    @discardableResult
    public func grow(_ value: CGFloat) -> Style {
        yoga.flexGrow = value
        return self
    }
    
    
    @discardableResult
    public func shrink(_ value: CGFloat) -> Style {
        yoga.flexShrink = value
        return self
    }
    
    
    @discardableResult
    public func basis(_ value: CGFloat?) -> Style {
        yoga.flexBasis = valueOrAuto(value)
        return self
    }
    
    
    @discardableResult
    public func basis(_ percent: PercentValue) -> Style {
        yoga.flexBasis = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    // MARK: - Width / height

    @discardableResult
    public func width(_ value: CGFloat?) -> Style {
        yoga.width = valueOrAuto(value)
        return self
    }
    
    
    @discardableResult
    public func width(_ percent: PercentValue) -> Style {
        yoga.width = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func height(_ value: CGFloat?) -> Style {
        yoga.height = valueOrAuto(value)
        return self
    }
    
    
    @discardableResult
    public func height(_ percent: PercentValue) -> Style {
        yoga.height = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func size(_ size: CGSize?) -> Style {
        yoga.width = valueOrAuto(size?.width)
        yoga.height = valueOrAuto(size?.height)
        return self
    }
    
    
    @discardableResult
    public func size(_ sideLength: CGFloat) -> Style {
        yoga.width = YGValue(sideLength)
        yoga.height = YGValue(sideLength)
        return self
    }
    
    
    @discardableResult
    public func minWidth(_ value: CGFloat?) -> Style {
        yoga.minWidth = valueOrUndefined(value)
        return self
    }
    
    
    @discardableResult
    public func minWidth(_ percent: PercentValue) -> Style {
        yoga.minWidth = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func maxWidth(_ value: CGFloat?) -> Style {
        yoga.maxWidth = valueOrUndefined(value)
        return self
    }
    
    
    @discardableResult
    public func maxWidth(_ percent: PercentValue) -> Style {
        yoga.maxWidth = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func minHeight(_ value: CGFloat?) -> Style {
        yoga.minHeight = valueOrUndefined(value)
        return self
    }
    
    
    @discardableResult
    public func minHeight(_ percent: PercentValue) -> Style {
        yoga.minHeight = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func maxHeight(_ value: CGFloat?) -> Style {
        yoga.maxHeight = valueOrUndefined(value)
        
        return self
    }
    
    
    @discardableResult
    public func maxHeight(_ percent: PercentValue) -> Style {
        yoga.maxHeight = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func aspectRatio(_ value: CGFloat?) -> Style {
        yoga.aspectRatio = value != nil ? value! : CGFloat(YGValueUndefined.value)
        return self
    }
    
    
    @discardableResult
    public func aspectRatio(of imageView: UIImageView) -> Style {
        if let imageSize = imageView.image?.size {
            yoga.aspectRatio = imageSize.width / imageSize.height
        }
        return self
    }
    
    //MARK: - Absolute positionning
    
    @discardableResult
    public func position(_ value: Position) -> Style {
        yoga.position = value.yogaValue
        return self
    }
    
    
    @discardableResult
    public func left(_ value: CGFloat) -> Style {
        yoga.left = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func left(_ percent: PercentValue) -> Style {
        yoga.left = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func top(_ value: CGFloat) -> Style {
        yoga.top = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func top(_ percent: PercentValue) -> Style {
        yoga.top = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func right(_ value: CGFloat) -> Style {
        yoga.right = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func right(_ percent: PercentValue) -> Style {
        yoga.right = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func bottom(_ value: CGFloat) -> Style {
        yoga.bottom = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func bottom(_ percent: PercentValue) -> Style {
        yoga.bottom = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func start(_ value: CGFloat) -> Style {
        yoga.start = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func start(_ percent: PercentValue) -> Style {
        yoga.start = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func end(_ value: CGFloat) -> Style {
        yoga.end = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func end(_ percent: PercentValue) -> Style {
        yoga.end = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    //MARK: - Margins
    
    @discardableResult
    public func marginTop(_ value: CGFloat) -> Style {
        yoga.marginTop = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginTop(_ percent: PercentValue) -> Style {
        yoga.marginTop = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func marginLeft(_ value: CGFloat) -> Style {
        yoga.marginLeft = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginLeft(_ percent: PercentValue) -> Style {
        yoga.marginLeft = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func marginBottom(_ value: CGFloat) -> Style {
        yoga.marginBottom = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginBottom(_ percent: PercentValue) -> Style {
        yoga.marginBottom = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func marginRight(_ value: CGFloat) -> Style {
        yoga.marginRight = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginRight(_ percent: PercentValue) -> Style {
        yoga.marginRight = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func marginStart(_ value: CGFloat) -> Style {
        yoga.marginStart = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginStart(_ percent: PercentValue) -> Style {
        yoga.marginStart = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func marginEnd(_ value: CGFloat) -> Style {
        yoga.marginEnd = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginEnd(_ percent: PercentValue) -> Style {
        yoga.marginEnd = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func marginHorizontal(_ value: CGFloat) -> Style {
        yoga.marginHorizontal = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginHorizontal(_ percent: PercentValue) -> Style {
        yoga.marginHorizontal = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func marginVertical(_ value: CGFloat) -> Style {
        yoga.marginVertical = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginVertical(_ percent: PercentValue) -> Style {
        yoga.marginVertical = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func margin(_ insets: UIEdgeInsets) -> Style {
        yoga.marginTop = YGValue(insets.top)
        yoga.marginLeft = YGValue(insets.left)
        yoga.marginBottom = YGValue(insets.bottom)
        yoga.marginRight = YGValue(insets.right)
        return self
    }
    
    
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> Style {
        yoga.marginTop = YGValue(directionalInsets.top)
        yoga.marginStart = YGValue(directionalInsets.leading)
        yoga.marginBottom = YGValue(directionalInsets.bottom)
        yoga.marginEnd = YGValue(directionalInsets.trailing)
        return self
    }
    
    
    @discardableResult
    public func margin(_ value: CGFloat) -> Style {
        yoga.margin = YGValue(value)
        return self
    }
    
    @discardableResult
    public func margin(_ percent: PercentValue) -> Style {
        yoga.margin = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    
    
    @discardableResult func margin(_ vertical: CGFloat, _ horizontal: CGFloat) -> Style {
        yoga.marginVertical = YGValue(vertical)
        yoga.marginHorizontal = YGValue(horizontal)
        return self
    }
    
    @discardableResult func margin(_ vertical: PercentValue, _ horizontal: PercentValue) -> Style {
        yoga.marginVertical = YGValue(value: Float(vertical.value), unit: .percent)
        yoga.marginHorizontal = YGValue(value: Float(horizontal.value), unit: .percent)
        return self
    }
    
    
    @discardableResult func margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> Style {
        yoga.marginTop = YGValue(top)
        yoga.marginHorizontal = YGValue(horizontal)
        yoga.marginBottom = YGValue(bottom)
        return self
    }
    
    @discardableResult func margin(_ top: PercentValue, _ horizontal: PercentValue, _ bottom: PercentValue) -> Style {
        yoga.marginTop = YGValue(value: Float(top.value), unit: .percent)
        yoga.marginHorizontal = YGValue(value: Float(horizontal.value), unit: .percent)
        yoga.marginBottom = YGValue(value: Float(bottom.value), unit: .percent)
        return self
    }
    
    
    @discardableResult
    public func margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Style {
        yoga.marginTop = YGValue(top)
        yoga.marginLeft = YGValue(left)
        yoga.marginBottom = YGValue(bottom)
        yoga.marginRight = YGValue(right)
        return self
    }
    
    @discardableResult
    public func margin(_ top: PercentValue, _ left: PercentValue, _ bottom: PercentValue, _ right: PercentValue) -> Style {
        yoga.marginTop = YGValue(value: Float(top.value), unit: .percent)
        yoga.marginLeft = YGValue(value: Float(left.value), unit: .percent)
        yoga.marginBottom = YGValue(value: Float(bottom.value), unit: .percent)
        yoga.marginRight = YGValue(value: Float(right.value), unit: .percent)
        return self
    }
    
    //MARK: - Padding
    
    @discardableResult
    public func paddingTop(_ value: CGFloat) -> Style {
        yoga.paddingTop = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func paddingLeft(_ value: CGFloat) -> Style {
        yoga.paddingLeft = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func paddingBottom(_ value: CGFloat) -> Style {
        yoga.paddingBottom = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func paddingRight(_ value: CGFloat) -> Style {
        yoga.paddingRight = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func paddingStart(_ value: CGFloat) -> Style {
        yoga.paddingStart = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func paddingEnd(_ value: CGFloat) -> Style {
        yoga.paddingEnd = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func paddingHorizontal(_ value: CGFloat) -> Style {
        yoga.paddingHorizontal = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func paddingVertical(_ value: CGFloat) -> Style {
        yoga.paddingVertical = YGValue(value)
        return self
    }
    
    
    @discardableResult
    public func padding(_ insets: UIEdgeInsets) -> Style {
        yoga.paddingTop = YGValue(insets.top)
        yoga.paddingLeft = YGValue(insets.left)
        yoga.paddingBottom = YGValue(insets.bottom)
        yoga.paddingRight = YGValue(insets.right)
        return self
    }
    
    
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    func padding(_ directionalInsets: NSDirectionalEdgeInsets) -> Style {
        yoga.paddingTop = YGValue(directionalInsets.top)
        yoga.paddingStart = YGValue(directionalInsets.leading)
        yoga.paddingBottom = YGValue(directionalInsets.bottom)
        yoga.paddingEnd = YGValue(directionalInsets.trailing)
        return self
    }
    
    
    @discardableResult
    public func padding(_ value: CGFloat) -> Style {
        yoga.padding = YGValue(value)
        return self
    }
    
    
    @discardableResult func padding(_ vertical: CGFloat, _ horizontal: CGFloat) -> Style {
        yoga.paddingVertical = YGValue(vertical)
        yoga.paddingHorizontal = YGValue(horizontal)
        return self
    }
    
    
    @discardableResult func padding(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> Style {
        yoga.paddingTop = YGValue(top)
        yoga.paddingHorizontal = YGValue(horizontal)
        yoga.paddingBottom = YGValue(bottom)
        return self
    }
    
    
    @discardableResult
    public func padding(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Style {
        yoga.paddingTop = YGValue(top)
        yoga.paddingLeft = YGValue(left)
        yoga.paddingBottom = YGValue(bottom)
        yoga.paddingRight = YGValue(right)
        return self
    }
}
