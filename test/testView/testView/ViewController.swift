//
//  ViewController.swift
//  testView
//
//  Created by zhangyu on 2019/7/18.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var viewModel: GreetingVM! {
        didSet {
            self.viewModel.greetingDidChange = {[unowned self] vm in
                self.greetingLabel.text = vm.greeting
                print(vm.greeting)
            }
        }
    }
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()
    
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testView1()
//        testScrollView1()
//        testMap()
        
//        self.showGreetingButton.addTarget(viewModel, action: Selector("showGreeting"), for: .touchUpInside)
//        let model = Person(firstName: "David", lastName: "Blaine")
//        viewModel = GreetingVM(person: model)
//        viewModel.showGreeting()
        
        // Assembling of MVP
        
//        let view = GreetingViewController()
//        let presenter = GreetingPresenter(view: view, model: model)
//        view.presenter = presenter
        greetingLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        greetingLabel.backgroundColor = .red
        self.view.addSubview(greetingLabel)
//        testMotion()
        
    }
    
    func testView1() {
        let v = TestView1()
        v.frame = CGRect(x: 10, y: 50, width: 30, height: 30)
        v.backgroundColor = .red
        self.view.addSubview(v)
    }

    func testScrollView1() {
        let v = TestScrollView1(frame: CGRect(x: 10, y: 70, width: 355, height: 300))
        v.backgroundColor = .gray
        v.contentSize = CGSize(width: 355, height: 700)
        self.view.addSubview(v)
    }
    
    func testMap() {
        let arr: [Int] = [1, 2, 3, 4]
        print(arr.zyMap({ (i) -> String in
            return "\(i)" + "字符串"
        }))
        
    }
    
    func testMotion() {
        
        guard manager.isAccelerometerAvailable else {
            return
        }
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main) { (data, err) in

            print(data)
        }
    }
}



extension Array {
    func zyMap<T>(_ mapBlock: (Element) throws -> T ) rethrows -> [T] {
        return try self.reduce([]) { (r, e) -> [T] in
            return try r + [mapBlock(e)]
        }
    }
}


struct Person {
    let firstName: String
    let lastName: String
}

protocol GreetingViewModelProtocol: AnyObject {
    associatedtype Model
    associatedtype VM
    var greeting: String? { get }
    var greetingDidChange: ((VM) -> ())? { set get }
    init(person: Model)
    func showGreeting()
    
}

class GreetingVM: GreetingViewModelProtocol {
    
    var greeting: String? {
        didSet {
            greetingDidChange?(self)
        }
    }
    var greetingDidChange: ((GreetingVM) -> ())?
    let person: Person

    
    required init(person: Person) {
        self.person = person
    }
    
    @objc func showGreeting() {
        greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
    }
}
