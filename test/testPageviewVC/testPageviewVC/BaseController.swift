//
//  BaseController.swift
//  testPageviewVC
//
//  Created by zhangyu on 2018/6/1.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

protocol BaseControllerDelegate: class {
    func scrollViewIsScrolling(scrollView: UIScrollView) -> CGFloat
}

class BaseController: UITableViewController, UIGestureRecognizerDelegate {
    
    var scrollV: UIScrollView!
    var delegate: BaseControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(scrollTotop), name: Notification.Name(rawValue: "ScrollTop"), object: nil)
    }

    @objc func scrollTotop() {
        self.tableView.contentOffset = .zero
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollV = scrollView
        if let _ = self.delegate {
            if self.delegate!.scrollViewIsScrolling(scrollView: scrollView) < CGFloat(200.0) {
                
            }
            else {
                
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.delegate!.scrollViewIsScrolling(scrollView: scrollV) < CGFloat(200.0) ? false : true
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
