//
//  ViewController.swift
//  SwiftFlexBoxExamples
//
//  Created by andy.bin on 2019/5/17.
//  Copyright © 2019 Binea. All rights reserved.
//

import UIKit
import SwiftFlexBox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var ref: UILabel!
        // Do any additional setup after loading the view.
        //        let v1 = UIView(position: nil, subView: nil)
        //        UIView(configs: (position: CGPoint.zero))
        //            <- UIView()
        //                <- [
        //                    UIView(),
        //                    UIView()
        //                ]
        //
        //        self.view <- [
        //            UIView(style: [.direction(.column), .left(0), .top(0), .bottom(0), .right(0), .background(.red)]) <- [
        //                UIView(style: [.top(40),.bottom(30), .background(.yellow)]),
        //                UIView(style: [.left(20), .top(40), .right(10), .bottom(30), .background(.blue)])
        //            ],
        //            UIView(style: [.direction(.column), .left(0), .top(0), .bottom(0), .right(0), .background(.red)])
        //        ]
        self.view <- [
            UIView(styles: [.alignSelf(.center), .direction(.row), .justifyContent(.flexStart), .alignItems(.flexStart), .top(100), .left(0), .background(.gray)]) <- [
                UILabel(styles: [.height(50), .top(0), .left(10), .background(.red), .text("测试"), .textAlign(.center)]),
                UIView(styles: [.width(80), .height(60), .right(20), .background(.blue)]),
                UILabel(styles: [.width(60), .height(80), .right(5), .background(.red), .text("测试"),.textAlign(.center)])
            ],
            UIView(styles: [.alignSelf(.flexEnd), .direction(.row), .justifyContent(.flexStart), .alignItems(.flexStart), .top(100), .left(0), .background(.gray)]) <- [
                UILabel(styles: [.height(50), .top(0), .left(10), .background(.red), .text("测试"), .textAlign(.center)]),
                UIView(styles: [.width(80), .height(60), .right(20), .background(.blue)]),
                UILabel(styles: [.width(60), .height(80), .right(5), .background(.red), .text("测试"),.textAlign(.center)])
            ]
        ]
        
//        print("ref.text:\(String(describing: ref.text))")
    }


}

