//
//  ZYKVO.swift
//  testKVO
//
//  Created by zhangyu on 2019/7/22.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import Foundation

typealias ZYObservingBlock = (_ observedObject: Any, _ observedKey: String, _ oldValue: Any, _ newValue: Any) -> ()

extension NSObject {
    
    func ZY_addObserver(observer: NSObject, forKey key: String, withBlock block: ZYObservingBlock) {
        
    }
    
    func ZY_removeObserver(observer: NSObject, forKey key: String) {
        
    }
}
