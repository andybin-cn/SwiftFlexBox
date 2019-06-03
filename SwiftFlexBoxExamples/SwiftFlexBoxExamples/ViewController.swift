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
    
    var ref: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view <- [
            UIView().style
                .justifyContent(.center)
                .direction(.column)
                .alignItems(.center)
                .marginTop(100)
                .backgroundColor(.gray).layout()
            <- [
                UIView().style
                    .direction(.row)
                    .justifyContent(.start)
                    .height(20)
                    .width(30)
                    .marginTop(100)
                    .backgroundColor(.red).layout(),
                UIButton().style
                    .ref(&ref)
                    .marginTop(10)
                    .height(35)
                    .width(100)
                    .backgroundColor(.blue).layout(),
                UIView().style
                    .direction(.row)
                    .justifyContent(.start)
                    .height(40)
                    .width(70)
                    .backgroundColor(.yellow).layout(),
                
            ]
        ]
        
        ref.addTarget(self, action: #selector(onTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.style.layout()
    }
    
    
    @objc func onTapped() {
        self.view.style.layout()
        self.ref.style.marginTop(100).backgroundColor(.green).layout()
    }
    
    
}

