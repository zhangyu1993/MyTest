//
//  ViewController.swift
//  testPageviewVC
//
//  Created by zhangyu on 2018/5/30.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBAction func aaaaaaaa(_ sender: Any) {
//        self.present(ZYPageViewController(), animated: true, completion: nil)
        self.navigationController?.pushViewController(ZYPageViewController(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        try! lookforSomething(name: "hello")
//        self.view.backgroundColor = UIColor.gray
//        let vc = ZYPageViewController()
//        vc.view.frame = CGRect(x: 0, y: 100, width: kScreenWidth, height: 400)
//        self.view.addSubview(vc.view)
//        self.addChildViewController(vc)
        
    }
    

    func lookforSomething(name:String) throws{
        //这里是作用域1 整个函数作用域

        print("1-1")
        if name == ""{
            //这里是作用域2 if的作用域
            print("2-1")
            defer{
                print("2-2")
            }
            print("2-3")
        }
        print("1-2")
        defer{
            print("1-3")
        }
        print("1-4")
        
        if name == "hello"{
            //作用域3
            print("3-1")
            defer{
                print("3-2")
            }
            print("3-3")
            defer{
                print("3-4")
            }
        }
        defer{
            print("4-1")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

