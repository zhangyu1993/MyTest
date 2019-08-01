//
//  ViewController.swift
//  testDownload
//
//  Created by zhangyu on 2019/7/4.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testBtn: UIButton!
    @IBAction func testBtnClick(_ sender: Any) {
//        disPath()
        useInvocationOperation()
//        runLoopTest()
    }
    
    var totalTicket: Int = 20
    var p = pthread_mutex_t()
    let semaphore = DispatchSemaphore(value: 1)
    
    var thread: Thread!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let d = ZYDownloadManager()
//        d.start()
//        useInvocationOperation()
//        disPath()
//        dispathTicket()
//        runLoopTest()
//        NotificationCenter.default.addObserver(self, selector: #selector(threadWillExit), name: Notification.Name.NSThreadWillExit, object: nil)
        
        
    }
    
    func runLoopTest() {
//        let o = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0) { (obs, act) in
//            print("监听到RunLoop发生改变--", act)
//        }
//        CFRunLoopAddObserver(CFRunLoopGetCurrent(), o, CFRunLoopMode.defaultMode)
        
        thread = Thread(target: self, selector: #selector(run1), object: nil)
    
        thread.start()
    
        Thread {
            print("1111", Thread.current)
        }.start()
        
      
    }
    
    @objc func run1() {
        print(thread)
        print(4444444444)
        print("----run1-----")
//        RunLoop.current.add(Port(), forMode: .default)
//        RunLoop.current.run()
        print("未开启RunLoop")
    }
    
    @objc func run2() {
        
        print("----run2-----")
    }
    
    @objc func threadWillExit() {
        print("threadWillExit")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        perform(#selector(run2), on: thread, with: nil, waitUntilDone: false)
    }
    
    func disPath() {
        
        let queue = DispatchQueue(label: "text.dispathqueue", qos: .default, attributes: [.concurrent])
//        for i in 0 ..< 200 {
//            queue.async {
//                Thread.sleep(forTimeInterval: 0.5)
//                print("----", i, Thread.current)
//            }
//        }
        
        queue.async {
            for i in 0 ..< 2 {
                print("++++", i, Thread.current)
            }
        }
        
        queue.sync {
            for i in 0 ..< 10 {
                print("++++", i, Thread.current)
            }
        }
        

        
        
//        let group = DispatchGroup()
//        queue.async(group: group) {
//            for i in 0 ..< 5 {
//                print("@@@@@@", i, Thread.current)
//            }
//        }
//        queue.async(group: group) {
//            for i in 0 ..< 5 {
//                print("######", i, Thread.current)
//            }
//        }
        
//
//        group.wait()
//        print("group结束", Thread.current)

//        var count = 0
//        let semaphore = DispatchSemaphore(value: 0)
//        queue.async {
//            for i in 0 ..< 5 {
//                print("$$$$$$", i, Thread.current)
//            }
//            count = 100
//            let s = semaphore.signal()
//            print("semaphore", s)
//
//        }
//        print("!!!!!!!!", count)
//        semaphore.wait()
//        print("%%%%%%%%%", count)
        
    }
    
    func dispathTicket() {

        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue1")
        
        queue1.async { [weak self] in
            self?.sendDispathTicket()
        }
        
        queue2.async { [weak self] in
            self?.sendDispathTicket()
        }
    }
    
    func useInvocationOperation() {
        
        
//        pthread_mutex_init(&p, nil)
        
        let queen1 = OperationQueue()
        queen1.maxConcurrentOperationCount = 2
    
        let q1 = BlockOperation {
            for i in 0 ..< 2 {
                Thread.sleep(forTimeInterval: 0.5)
                print("AAAA", i, Thread.current)
            }
        }
        let q2 = BlockOperation {
            for i in 0 ..< 2 {
                Thread.sleep(forTimeInterval: 0.5)
                print("BBBB", i, Thread.current)
            }
        }
        let q3 = BlockOperation {
            for i in 0 ..< 2 {
                Thread.sleep(forTimeInterval: 0.5)
                print("CCCC", i, Thread.current)
            }
        }
        let q4 = BlockOperation {
            for i in 0 ..< 2 {
                Thread.sleep(forTimeInterval: 0.5)
                print("DDDD", i, Thread.current)
            }
        }
        let q5 = BlockOperation {
            for i in 0 ..< 2 {
                Thread.sleep(forTimeInterval: 0.5)
                print("FFFF", i, Thread.current)
            }
        }
        
        q1.addDependency(q2)
        q1.addDependency(q3)
        q1.addDependency(q4)
        q1.addDependency(q5)
        
        queen1.addOperation(q1)
        queen1.addOperation(q2)
        queen1.addOperation(q3)
        queen1.addOperation(q4)
        queen1.addOperation(q5)
        
//        let queen2 = OperationQueue()
//        queen2.maxConcurrentOperationCount = 1
//
//
//        let op2 = BlockOperation(block: {
//            self.sendDispathTicket()
//        })
//
//
//        queen1.addOperation(op1)
//        queen2.addOperation(op2)
        
//        queen1.addOperation(zo)
        
    }

    func sendDispathTicket() {
        while true {
            semaphore.wait()
            if totalTicket > 0 {
                totalTicket -= 1
                print(totalTicket, Thread.current)
                Thread.sleep(forTimeInterval: 1)
            }
            if totalTicket == 0 {
                print("卖完了")
                semaphore.signal()
                break
            }
            semaphore.signal()
        }
    }
    
    func sendTicket() {
        while true {
            pthread_mutex_lock(&p)
            if totalTicket > 0 {
                totalTicket -= 1
                print(totalTicket, Thread.current)
                Thread.sleep(forTimeInterval: 1)
            }
            pthread_mutex_unlock(&p)
            if totalTicket == 0 {
                print("卖完了")
                pthread_mutex_destroy(&p)
                break
            }
        }
    }
    
}

class ZYOperation: Operation {
    
    override func main() {
        print(isExecuting, isFinished, isConcurrent)
        for i in 0 ..< 2 {
            print(i, Thread.current)
            Thread.sleep(forTimeInterval: 1)
        }
    }
    
    override func start() {
        
    }
    
    
}
