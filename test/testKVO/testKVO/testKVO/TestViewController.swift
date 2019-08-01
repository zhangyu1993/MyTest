//
//  TestViewController.swift
//  testKVO
//
//  Created by zhangyu on 2019/7/23.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print(self.classForCoder)
        print(super.classForCoder)
        testCorduis()
        add(sum: 0, n: 5)
        print(sum)
    }
    
    func add(sum: Int, n: Int) {
//        var sum = 0
        if n > 0 {
            add(sum: sum, n: n - 1)
        }
        else {
            self.sum = sum
        }
    }
    
    override func swizzled_viewDidAppear(_ animated: Bool) {
        super.swizzled_viewDidAppear(animated)
        print(111111111111111)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    func testCorduis() {
        let img = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(img)
        let i = UIImage(named: "pic_hunting_bg")
        img.image = i?.corner()
//        DispatchQueue.global().async {
//            var i2: UIImage?
//            UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 100), false, 1.0)
//            UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 50, height: 50)).addClip()
//            i?.draw(in: CGRect(x: 0, y: 0, width: 100, height: 100))
//            i2 = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            DispatchQueue.main.async {
//                img.image = i2
//            }
//        }
      
    }

}

extension UIImage {
    func corner(byRoundingCorners: UIRectCorner = [], cornerRadii: CGSize = .zero) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.addEllipse(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        ctx?.clip()
        draw(in: CGRect(origin: .zero, size: self.size))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
