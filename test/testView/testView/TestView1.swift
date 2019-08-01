//
//  TestView1.swift
//  testView
//
//  Created by zhangyu on 2019/7/18.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit

class TestView1: UIView {

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()
        if let curP = touch?.location(in: self), let perP = touch?.previousLocation(in: self) {
            self.transform = self.transform.concatenating(CGAffineTransform(translationX: curP.x - perP.x, y: curP.y - perP.y)) 
        }
        
    }

}
