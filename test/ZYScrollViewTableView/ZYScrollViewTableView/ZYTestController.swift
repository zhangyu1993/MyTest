//
//  ZYTestController.swift
//  ZYScrollViewTableView
//
//  Created by zhangyu on 2018/8/20.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

class ZYTestController: UIViewController, UIScrollViewDelegate {

    lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.isPagingEnabled = true
        s.delegate = self
        self.view.addSubview(s)
        return s
    }()
    /// 当前seg的idx
    var currentIdx = 0
    
    var vcArr: [UIViewController] = [ZYOneViewController(), ZYTwoViewController(), ZYThreeViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        scrollView.frame = CGRect(x: 0, y: 64, width: 375, height: 667 - 64)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 3, height: scrollView.frame.height)
        let one = vcArr[0]
        one.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        let two = vcArr[1]
        two.view.frame = CGRect(x: scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        let three = vcArr[2]
        three.view.frame = CGRect(x: scrollView.frame.width * 2, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        
        scrollView.addSubview(one.view)
        self.addChildViewController(one)
        scrollView.addSubview(two.view)
        scrollView.addSubview(three.view)
    
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
        let index = Int(scrollView.contentOffset.x / 375)

    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / 375)
        print(index)
        if index == currentIdx { return }
        print("scrollViewDidEndDecelerating")
        
        let fromVC = vcArr[currentIdx]
        let toVC = vcArr[index]
        self.addChildViewController(toVC)
        fromVC.removeFromParentViewController()
        self.transition(from: fromVC, to: toVC, duration: 0, options: [], animations: nil) { (bool) in
            if bool {
                toVC.didMove(toParentViewController: self)
                fromVC.willMove(toParentViewController: nil)
                fromVC.removeFromParentViewController()
            }
        }
        currentIdx = index
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
