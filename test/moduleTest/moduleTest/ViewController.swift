//
//  ViewController.swift
//  moduleTest
//
//  Created by zhangyu on 2018/7/13.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit


enum aaa: String {
    case qqq
    case www
}


struct proT: tovcProtocol, vmProtocol {
    var name: String = "222"
    init(name: String) {
        self.name = name
    }
}


class ViewController: UIViewController, tovcProtocol {
    var name: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 20, y: 40, width: 50, height: 50)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(btnclick), for: .touchUpInside)
        self.view.addSubview(btn)
        self.view.backgroundColor = .yellow
    
        print(aaa.qqq.rawValue)
//        var p1 = proT.init(name: "1234")
        let cell = testView(frame: CGRect(x: 10, y: 30, width: 200, height: 30))
//        cell.frame =
        self.view.addSubview(cell)
        
        print(cellVMStruct.init(cellM: cellModel()))
        
    }

    @objc func btnclick() {
        
//        self.present(toVC1(par: ["111": 11]), animated: true, completion: nil)
        toVC2(par: ["111": 11])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class testView: UIView, viewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        titleLab.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        titleLab.backgroundColor = .blue
        self.addSubview(titleLab)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


