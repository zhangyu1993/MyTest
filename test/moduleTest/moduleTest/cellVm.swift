//
//  cellVm.swift
//  moduleTest
//
//  Created by zhangyu on 2018/7/17.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import Foundation

protocol cellVMProtocol {
    
}

extension cellVMProtocol {
    var cellTitle: String {
        get {
            return ""
        }
        set {
            
        }
    }
    var cellDesc: String {
        get {
            return ""
        }
        set {
            
        }
    }
}

struct cellVMStruct: cellVMProtocol {
//    var cellDesc: String
//    var cellTitle: String
    init(cellM: cellModel) {
        self.cellTitle = cellM.title + "..."
        self.cellDesc = cellM.desc + "+++"
    }
}

class cellModel {
    let title: String = "123"
    let desc: String = "456"
}
