//
//  LoadingViewController.swift
//  swiftTips
//
//  Created by zhangyu on 2019/3/12.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let l = UILabel(frame: CGRect(x: 0, y: 100, width: 375, height: 50))
        l.text = "这是loadingview，随便布局"
        l.backgroundColor = .red
        self.view.addSubview(l)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
