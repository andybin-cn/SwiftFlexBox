//
//  ConstraintMaker.swift
//  HandyUI
//
//  Created by andy.bin on 2019/5/14.
//  Copyright © 2019 Binea. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ConstraintMaker {
    static let defaultPosition = ViewStyle.position(.relative)
    static let defaultDirection = ViewStyle.direction(.row)
    static let defaultJustifyContent = ViewStyle.justifyContent(.flexStart)
    static let defaultAlignItems = ViewStyle.alignItems(.flexStart)
    
    static let defaultStyles: [ViewStyle] = [defaultPosition, defaultDirection, defaultJustifyContent, defaultAlignItems]
    
    class func makeSelfConstraints(currentView: UIView) {
        let styles = currentView.style
        if let width = styles.style(for: ViewStyleKeys.width)?.value as? CGFloat {
            currentView.snp.makeConstraints { (make) in
                make.width.equalTo(width)
            }
        }
        if let height = styles.style(for: ViewStyleKeys.height)?.value as? CGFloat {
            currentView.snp.makeConstraints { (make) in
                make.height.equalTo(height)
            }
        }
        currentView.backgroundColor = styles.style(for: .background)?.value as? UIColor
        currentView.alpha = styles.style(for: ViewStyleKeys.alpha)?.value as? CGFloat ?? 1.0
        if let contentMode = styles.style(for: ViewStyleKeys.contentMode)?.value as? UIView.ContentMode {
            currentView.contentMode = contentMode
        }
    }
    
    class func makeAbsoluteConstraints(currentView: UIView) -> Bool {
        let styles = currentView.style
        if let position = styles.style(for: .position), let value = position.value as? StylePosition, value == StylePosition.absolute {
            if let left = styles.style(for: .left)?.value as? CGFloat {
                currentView.snp.makeConstraints { (make) in
                    make.left.equalTo(left)
                }
            }
            if let right = styles.style(for: .right)?.value as? CGFloat {
                currentView.snp.makeConstraints { (make) in
                    make.right.equalTo(-right)
                }
            }
            if let top = styles.style(for: .top)?.value as? CGFloat {
                currentView.snp.makeConstraints { (make) in
                    make.top.equalTo(top)
                }
            }
            if let bottom = styles.style(for: .bottom)?.value as? CGFloat {
                currentView.snp.makeConstraints { (make) in
                    make.bottom.equalTo(-bottom)
                }
            }
            return true
        } else {
            return false
        }
    }
    
    class func makeRelatedConstraints(currentView: UIView, subViews: [UIView]) {
        var direction = defaultDirection.value as! StyleDirection
        var alignItems = defaultAlignItems.value as! StyleAlignItems
        var justifyContent = defaultJustifyContent.value as! StyleJustifyContent
        let styles = currentView.style
        if let directionTemp = styles.style(for: .direction)?.value as? StyleDirection {
            direction = directionTemp
        }
        if let alignItemsTemp = styles.style(for: .alignItems)?.value as? StyleAlignItems {
            alignItems = alignItemsTemp
        }
        if let justifyContentTemp = styles.style(for: .justifyContent)?.value as? StyleJustifyContent {
            justifyContent = justifyContentTemp
        }
        var newSubViews = subViews
        switch direction {
        case .rowReverse:
            newSubViews.reverse()
            fallthrough
        case .row:
            ConstraintMaker.makeRelatedConstraints(currentView: currentView, subViews: newSubViews, direction: .row, alignItems: alignItems, justifyContent: justifyContent)
            break;
        case .columnReverse:
            newSubViews.reverse()
            fallthrough
        case .column:
            ConstraintMaker.makeRelatedConstraints(currentView: currentView, subViews: newSubViews, direction: .column, alignItems: alignItems, justifyContent: justifyContent)
            break;
        }
    }
    
    class func makeSpaceingView(currentView: UIView, preAxisConstraintItem: ConstraintItem, direction: StyleDirection) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        currentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            if direction == .row {
                view.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .horizontal)
                make.left.equalTo(preAxisConstraintItem)
                make.centerY.equalToSuperview()
                make.height.equalTo(0)
            } else {
                view.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .vertical)
                make.top.equalTo(preAxisConstraintItem)
                make.centerX.equalToSuperview()
                make.width.equalTo(0)
            }
        }
        return view
    }
    
    class func makeRowDirectionConstraints(currentView: UIView, subViews: [UIView], direction: StyleDirection, alignItems: StyleAlignItems, justifyContent: StyleJustifyContent) {
        var preAxisConstraintItem = direction == .row ? currentView.snp.left : currentView.snp.top
        let endAxisConstraintItem = direction == .row ? currentView.snp.right : currentView.snp.bottom
        var preSpacingView: UIView?
        var preAxisSpacing: CGFloat = 0
        subViews.enumerated().forEach { (index, subView) in
            if(ConstraintMaker.makeAbsoluteConstraints(currentView: subView)) {
                return
            }
            let left = subView.style.style(for: .left)?.value as? CGFloat ?? 0
            let right = subView.style.style(for: .right)?.value as? CGFloat ?? 0
            let top = subView.style.style(for: .top)?.value as? CGFloat ?? 0
            let bottom = subView.style.style(for: .bottom)?.value as? CGFloat ?? 0
            
            subView.snp.makeConstraints({ (make) in
                let isLastOne = index == subViews.count - 1
                let isFirstOne = index == 0
                switch justifyContent {
                case .flexStart:
                    make.left.equalTo(preAxisConstraintItem).offset(left + preAxisSpacing)
                    if isLastOne {
                        make.right.lessThanOrEqualTo(endAxisConstraintItem).offset(-right)
                    }
                    break
                case .flexEnd:
                    if isFirstOne {
                        make.left.greaterThanOrEqualTo(preAxisConstraintItem).offset(left + preAxisSpacing)
                    } else {
                        make.left.equalTo(preAxisConstraintItem).offset(left + preAxisSpacing)
                    }
                    if isLastOne {
                        make.right.equalTo(endAxisConstraintItem).offset(-right)
                    }
                    break
                case .center:
                    if isFirstOne {
                        preSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: preAxisConstraintItem, direction: direction)
                        make.left.equalTo(preSpacingView!.snp.right).offset(left + preAxisSpacing)
                    } else {
                        make.left.equalTo(preAxisConstraintItem).offset(left + preAxisSpacing)
                        
                    }
                    if isLastOne {
                        let newSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: subView.snp.right, direction: direction)
                        newSpacingView.snp.makeConstraints({ (make) in
                            make.width.equalTo(preSpacingView!.snp.width)
                            make.right.equalToSuperview()
                        })
                        make.right.equalTo(newSpacingView.snp.left).offset(-right)
                    }
                    break
                case .spaceBetween:
                    let newSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: preAxisConstraintItem, direction: direction)
                    make.left.equalTo(newSpacingView.snp.right).offset(left + preAxisSpacing)
                    
                    if isFirstOne {
                        newSpacingView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
                    }
                    if let preSpacingView = preSpacingView, index > 1 {
                        newSpacingView.snp.makeConstraints({ (make) in
                            make.width.equalTo(preSpacingView.snp.width)
                        })
                    }
                    
                    if isLastOne {
                        let endSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: subView.snp.right, direction: direction)
                        endSpacingView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
                        endSpacingView.snp.makeConstraints({ (make) in
                            make.right.equalToSuperview()
                            if isFirstOne {
                                make.width.equalTo(newSpacingView.snp.width)
                            }
                        })
                    }
                    preSpacingView = newSpacingView
                    break
                case .spaceAround:
                    let newSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: preAxisConstraintItem, direction: direction)
                    make.left.equalTo(newSpacingView.snp.right).offset(left + preAxisSpacing)
                    
                    if let preSpacingView = preSpacingView {
                        newSpacingView.snp.makeConstraints({ (make) in
                            make.width.equalTo(preSpacingView.snp.width).multipliedBy(index == 1 ? 2 : 1)
                        })
                    }
                    
                    if isLastOne {
                        let endSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: subView.snp.right, direction: direction)
                        endSpacingView.snp.makeConstraints({ (make) in
                            make.right.equalToSuperview()
                            if isFirstOne {
                                make.width.equalTo(newSpacingView.snp.width)
                            } else {
                                make.width.equalTo(preSpacingView!.snp.width).dividedBy(2)
                            }
                        })
                    }
                    preSpacingView = newSpacingView
                    break
                }
                preAxisConstraintItem = subView.snp.right
                preAxisSpacing = right
                
                let newAlignItems = subView.style.style(for: .alignSelf)?.value as? StyleAlignItems ?? alignItems
//                subView.setContentHuggingPriority(UILayoutPriority(300), for: .vertical)
                switch newAlignItems {
                case .flexStart:
                    make.top.equalTo(top)
                    make.bottom.lessThanOrEqualToSuperview()
//                    subView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
                    break
                case .center:
                    make.centerY.equalTo(currentView.snp.centerY).offset(top - bottom)
                    make.top.greaterThanOrEqualToSuperview()
                    make.bottom.lessThanOrEqualToSuperview()
                    make.height.equalToSuperview().priority(.high)
                    break
                case .flexEnd:
                    make.bottom.equalTo(-bottom)
                    break
                case .baseline:
                    make.top.greaterThanOrEqualToSuperview()
                    if !isFirstOne {
                        make.lastBaseline.equalTo(subViews[index-1].snp.lastBaseline)
                    }
                    make.bottom.lessThanOrEqualToSuperview()
                    break
                case .stretch:
                    make.top.equalTo(top)
                    make.bottom.equalTo(-bottom)
                    break
                }
            })
        }
    }
    class func makeColumnDirectionConstraints(currentView: UIView, subViews: [UIView], direction: StyleDirection, alignItems: StyleAlignItems, justifyContent: StyleJustifyContent) {
        var preAxisConstraintItem = direction == .row ? currentView.snp.left : currentView.snp.top
        let endAxisConstraintItem = direction == .row ? currentView.snp.right : currentView.snp.bottom
        var preSpacingView: UIView?
        var preAxisSpacing: CGFloat = 0
        subViews.enumerated().forEach { (index, subView) in
            if(ConstraintMaker.makeAbsoluteConstraints(currentView: subView)) {
                return
            }
            let left = subView.style.style(for: .left)?.value as? CGFloat ?? 0
            let right = subView.style.style(for: .right)?.value as? CGFloat ?? 0
            let top = subView.style.style(for: .top)?.value as? CGFloat ?? 0
            let bottom = subView.style.style(for: .bottom)?.value as? CGFloat ?? 0
            
            subView.snp.makeConstraints({ (make) in
                let isLastOne = index == subViews.count - 1
                let isFirstOne = index == 0
                switch justifyContent {
                case .flexStart:
                    make.top.equalTo(preAxisConstraintItem).offset(top + preAxisSpacing)
                    if isLastOne {
                        make.bottom.lessThanOrEqualTo(endAxisConstraintItem).offset(-bottom)
                    }
                    break
                case .flexEnd:
                    if isFirstOne {
                        make.top.greaterThanOrEqualTo(preAxisConstraintItem).offset(top + preAxisSpacing)
                    } else {
                        make.top.equalTo(preAxisConstraintItem).offset(top + preAxisSpacing)
                    }
                    if isLastOne {
                        make.bottom.equalTo(endAxisConstraintItem).offset(-bottom)
                    }
                    break
                case .center:
                    if isFirstOne {
                        preSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: preAxisConstraintItem, direction: direction)
                        make.top.equalTo(preSpacingView!.snp.bottom).offset(top + preAxisSpacing)
                    } else {
                        make.top.equalTo(preAxisConstraintItem).offset(top + preAxisSpacing)
                        
                    }
                    if isLastOne {
                        let newSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: subView.snp.bottom, direction: direction)
                        newSpacingView.snp.makeConstraints({ (make) in
                            make.height.equalTo(preSpacingView!.snp.height)
                            make.bottom.equalToSuperview()
                        })
                        make.bottom.equalTo(newSpacingView.snp.top).offset(-bottom)
                    }
                    break
                case .spaceBetween:
                    let newSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: preAxisConstraintItem, direction: direction)
                    make.top.equalTo(newSpacingView.snp.bottom).offset(top + preAxisSpacing)
                    
                    if isFirstOne {
                        newSpacingView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
                    }
                    if let preSpacingView = preSpacingView, index > 1 {
                        newSpacingView.snp.makeConstraints({ (make) in
                            make.height.equalTo(preSpacingView.snp.height)
                        })
                    }
                    
                    if isLastOne {
                        let endSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: subView.snp.bottom, direction: direction)
                        endSpacingView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
                        endSpacingView.snp.makeConstraints({ (make) in
                            make.bottom.equalToSuperview()
                            if isFirstOne {
                                make.height.equalTo(newSpacingView.snp.height)
                            }
                        })
                    }
                    preSpacingView = newSpacingView
                    break
                case .spaceAround:
                    let newSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: preAxisConstraintItem, direction: direction)
                    make.top.equalTo(newSpacingView.snp.bottom).offset(top + preAxisSpacing)
                    
                    if let preSpacingView = preSpacingView {
                        newSpacingView.snp.makeConstraints({ (make) in
                            make.height.equalTo(preSpacingView.snp.height).multipliedBy(index == 1 ? 2 : 1)
                        })
                    }
                    
                    if isLastOne {
                        let endSpacingView = ConstraintMaker.makeSpaceingView(currentView: currentView, preAxisConstraintItem: subView.snp.bottom, direction: direction)
                        endSpacingView.snp.makeConstraints({ (make) in
                            make.bottom.equalToSuperview()
                            if isFirstOne {
                                make.height.equalTo(newSpacingView.snp.height)
                            } else {
                                make.height.equalTo(preSpacingView!.snp.height).dividedBy(2)
                            }
                        })
                    }
                    preSpacingView = newSpacingView
                    break
                }
                preAxisConstraintItem = subView.snp.bottom
                preAxisSpacing = bottom
                
                let newAlignItems = subView.style.style(for: .alignSelf)?.value as? StyleAlignItems ?? alignItems
                switch newAlignItems {
                case .flexStart:
                    make.left.equalTo(left)
                    break
                case .center:
                    make.centerX.equalTo(currentView.snp.centerX).offset(left - right)
                    break
                case .flexEnd:
                    make.right.equalTo(-right)
                    break
                case .baseline:
                    make.centerX.equalTo(currentView.snp.centerX).offset(left - right)
                    break
                case .stretch:
                    make.left.equalTo(left)
                    make.right.equalTo(-right)
                    break
                }
            })
        }
    }
    class func makeRelatedConstraints(currentView: UIView, subViews: [UIView], direction: StyleDirection, alignItems: StyleAlignItems, justifyContent: StyleJustifyContent) {
        if direction == .row {
            ConstraintMaker.makeRowDirectionConstraints(currentView: currentView, subViews: subViews, direction: direction, alignItems: alignItems, justifyContent: justifyContent)
        } else {
            ConstraintMaker.makeColumnDirectionConstraints(currentView: currentView, subViews: subViews, direction: direction, alignItems: alignItems, justifyContent: justifyContent)
        }
    }
}

extension Array where Element: ViewStyle {
    func style(for key: ViewStyleKeys) -> ViewStyle? {
        return self.first(where: { (style) -> Bool in
            return style.key == key.rawValue
        })
    }
}
