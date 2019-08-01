//
//  ViewController.swift
//  testKVO
//
//  Created by zhangyu on 2019/7/22.
//  Copyright © 2019 zhangyu. All rights reserved.
//







import UIKit

class ViewController: UIViewController {

    var count: Int = 0
    
    var kvo1: TestKVO1 = TestKVO1()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testKVO1()
    }
 
    func testKVO1() {
//        kvo1.addObserver(self, forKeyPath: "name", options: NSKeyValueObservingOptions.new, context: nil)
        kvo1.addObserver(self, forKeyPath: "kvo2.age", options: NSKeyValueObservingOptions.new, context: nil)
    
    }
    
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        count += 1
//        kvo1.willChangeValue(forKey: "kvo2")
        kvo1.kvo2.age = "\(count)"
        kvo1.kvo2.sex = "\(count)"
        kvo1.name = "\(count)"
//        kvo1.didChangeValue(forKey: "kvo2")
        self.navigationController?.pushViewController(TestViewController(), animated: true)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(keyPath, change)
    }
    
    deinit {
        kvo1.removeObserver(self, forKeyPath: "kvo2")
    }
}


class TestKVO1: NSObject {

    @objc dynamic var name = ""

    @objc dynamic var kvo2 = TestKVO2()
    
//    override class func automaticallyNotifiesObservers(forKey key: String) -> Bool {
//        return false
//    }

    class func logWithEventName(name: String) {
        print(name)
    }
    
}

class TestKVO2: NSObject {
    
     @objc dynamic var sex: String = ""
    
     @objc dynamic var age: String = ""
    
}


extension UIViewController {
    class func exchengeMethod() {
        let originalMethod = class_getInstanceMethod(self, #selector(UIViewController.viewDidAppear(_:)))
        let swizzledMethod = class_getInstanceMethod(self, #selector(UIViewController.swizzled_viewDidAppear(_:)))
        if let oriMethod = originalMethod, let swiMethod = swizzledMethod {
            method_exchangeImplementations(oriMethod, swiMethod)
        }
    }
    
    @objc func swizzled_viewDidAppear(_ animated: Bool) {
        self.swizzled_viewDidAppear(animated)
        TestKVO1.logWithEventName(name: NSStringFromClass(self.classForCoder))
    }
    
}
