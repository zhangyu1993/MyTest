//
//  ViewController.swift
//  swiftTips
//
//  Created by zhangyu on 2019/3/12.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit



class ViewController: BaseViewController {
    
    override var isShowLoadingView: Bool { return true }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 5) {
            DispatchQueue.main.async {
                self.removeLoadingView()
            }
        }
    
        var counts: [Int] = [1, 2, 2, 3, 1, 4, 2, 5, 6]
        var titles: [String] = ["11", "22", "33", "44", "55"]
        for item in zip(counts, titles) {
            print(item.0)
            print(item.1)
        }
        
        var f1: CGFloat = 0.1
        let f2 = f1 * counts.count
        
      
    }
    

    override func customLoadingView() -> UIViewController? {
        return CustomLoadingViewController()
    }
    
}


class CustomLoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let l = UILabel(frame: CGRect(x: 0, y: 100, width: 375, height: 50))
        l.text = "这是自定义的loadingview，随便布局"
        l.backgroundColor = .yellow
        self.view.addSubview(l)
    }
}


extension CGFloat {
    static func *(a: CGFloat, b: Int) -> CGFloat {
        return a * CGFloat(b)
    }
}



