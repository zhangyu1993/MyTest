//
//  TableViewController1.swift
//  testPageviewVC
//
//  Created by zhangyu on 2018/5/30.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

class TableViewController1: BaseController {

    var datas: [String] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear" + "1")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear" + "1")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear" + "1")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear" + "1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.datas = ["12","34","56","78"]
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = datas[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(ZYPageViewController(), animated: true, completion: nil)
    }
}

extension UITableView {
    public class func myOnceMethod() {
        DispatchQueue.once(token: "once") {
            
            let originalSelector = #selector(UITableView.reloadData)
            let swizzledSelector = #selector(UITableView.zy_reloadData)
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
            let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
            //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
                
                
            } else {
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
    }
    
    @objc func zy_reloadData() {
        print("zy_reloadData")
        self.zy_reloadData()
    }
    
}

extension DispatchQueue {
    private static var onceTracker = [String]()
    
    open class func once(token: String, block:() -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self)}
        
        if onceTracker.contains(token) {
            return
        }
        onceTracker.append(token)
        block()
    }
}
