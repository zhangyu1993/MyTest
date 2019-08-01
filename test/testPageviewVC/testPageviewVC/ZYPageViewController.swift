//
//  ZYPageViewController.swift
//  testPageviewVC
//
//  Created by zhangyu on 2018/5/30.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height


class ZYUIScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return gestureRecognizer is UIPanGestureRecognizer && otherGestureRecognizer is UIPanGestureRecognizer
//    }
}

class ZYTableView: UITableView,  UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer is UIPanGestureRecognizer && otherGestureRecognizer is UIPanGestureRecognizer
        
    }
}


class ZYPageViewController: UIViewController,UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate, BaseControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    private var contentScrillView: ZYUIScrollView = ZYUIScrollView()
    private var headerView: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 200.0)
        v.backgroundColor = .red
        return v
    }()
    private var pageVC: UIPageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
    private var childVCs: [BaseController] = {
        var vcs: [BaseController] = []
        vcs = [TableViewController1(), TableViewController2(), TableViewController3(), TableViewController4(), TableViewController5()]
        return vcs
    }()
    private var childScrollV: UIScrollView?
    
    private var contentTableView: ZYTableView = ZYTableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        configUI()
    }
    
    private func configUI() {
        
//        self.view.addSubview(contentScrillView)
        contentScrillView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        contentScrillView.addSubview(headerView)
   
        self.view.addSubview(contentTableView)
        contentTableView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.view.frame.height)
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contentTableView.bounces = false
        
        let btn1 = UIButton(type: .custom)
        btn1.frame = CGRect(x: 10, y: 30, width: 30, height: 30)
        btn1.backgroundColor = .blue
        headerView.addSubview(btn1)
        btn1.addTarget(self, action: #selector(btnClick1), for: .touchUpInside)
        
        
        let btn2 = UIButton(type: .custom)
        btn2.frame = CGRect(x: 50, y: 30, width: 30, height: 30)
        headerView.addSubview(btn2)
        btn2.backgroundColor = .blue
        btn2.addTarget(self, action: #selector(btnClick2), for: .touchUpInside)
        
        pageVC.delegate = self
        pageVC.dataSource = self
        
        self.addChildViewController(pageVC)
//        contentScrillView.addSubview(pageVC.view)
        contentScrillView.delegate = self
        contentScrillView.showsVerticalScrollIndicator = false
        contentScrillView.alwaysBounceHorizontal = false
        contentScrillView.bounces = false
        contentScrillView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height )
    }
    
    @objc func btnClick1() {
        pageVC.setViewControllers([self.childVCs[2]], direction: .reverse, animated: true) { (finish) in
            if finish {
                DispatchQueue.main.async {
                    self.pageVC.setViewControllers([self.childVCs[2]], direction: UIPageViewControllerNavigationDirection.reverse, animated: false, completion: nil)
                }
            }
        }
    }
    
    @objc func btnClick2() {
        pageVC.setViewControllers([self.childVCs[4]], direction: .forward, animated: true) { (finish) in
            if finish {
                DispatchQueue.main.async {
                    self.pageVC.setViewControllers([self.childVCs[4]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
                }
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var idx: Int? = self.childVCs.index(of: viewController as! BaseController)
        if idx == nil || idx == 0 {
            return nil
        }
        idx! -= 1
        self.childVCs[idx!].delegate = self
        return self.childVCs[idx!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var idx: Int? = self.childVCs.index(of: viewController as! BaseController)
        if idx == nil || idx == self.childVCs.count - 1 {
            return nil
        }
        idx! += 1
        self.childVCs[idx!].delegate = self
        return self.childVCs[idx!]
    }
    

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("--------   " + "\(scrollView.contentOffset.y)")
        if let _ = childScrollV, childScrollV!.contentOffset.y > 0 {
            self.contentTableView.contentOffset = CGPoint(x: 0, y: 200.0)
        }
        if scrollView.contentOffset.y < 200 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ScrollTop"), object: nil)
        }
    }
    
    func scrollViewIsScrolling(scrollView: UIScrollView) -> CGFloat{
        print("++++++++   " + "\(scrollView.contentOffset.y)")
        self.childScrollV = scrollView
//        if scrollView.contentOffset.y <= 0 {
//            return CGFloat(200)
//        }
        if  contentTableView.contentOffset.y < 200.0 && contentTableView.contentOffset.y > -64 {
            scrollView.contentOffset = .zero
        }
        else if contentTableView.contentOffset.y <= -64 {
            
        }
        else {
            self.contentTableView.contentOffset = CGPoint(x: 0, y: 200.0)
        }
        return contentTableView.contentOffset.y
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        pageVC.view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: cell!.contentView.frame.height)
        pageVC.setViewControllers([self.childVCs.first!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        cell!.contentView.addSubview(pageVC.view)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenHeight
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
