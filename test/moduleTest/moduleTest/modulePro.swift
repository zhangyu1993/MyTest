//
//  modulePro.swift
//  moduleTest
//
//  Created by zhangyu on 2018/7/13.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import Foundation
import UIKit


protocol tovcProtocol {
    var name: String { get set }
}

protocol vmProtocol {
    var name: String { get set }
}

protocol viewProtocol {
    
}

extension tovcProtocol where Self : UIViewController {
    func toVC1(par:[String:Any]) -> ViewController1 {
        let vc = ViewController1()
        vc.id = 1
        vc.type = "111"
//        print(self.view)
        return vc
    }
    
    func toVC2(par:[String:Any]) {
        let vc = ViewController2()
        print(self)
        self.present(vc, animated: true, completion: nil)
    }
    
    func toVC3(par:[String:Any]) -> ViewController3 {
        let vc = ViewController3()
        return vc
    }
}

extension viewProtocol {
    var titleLab: UILabel {
        get {
            let l = UILabel()
            l.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
            l.text = "qwer"
            l.backgroundColor = .red
            return l
        }
    }
}

class proCell<T>: UITableViewCell, viewProtocol where T: tovcProtocol, T: vmProtocol{
    private var degelate: T?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


