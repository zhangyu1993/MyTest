//
//  BaseViewController.swift
//  swiftTips
//
//  Created by zhangyu on 2019/3/12.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var isShowLoadingView: Bool { return true }
    
    private var loadingView: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configBaseViewControllerUI()
    }
    
    private func configBaseViewControllerUI() {
        if isShowLoadingView {
            loadingView = customLoadingView()
            addLoadingView()
        }
    }
    
    private func addLoadingView() {
        guard loadingView != nil else { return }
        add(loadingView!)
    }
    
    func removeLoadingView() {
        loadingView?.remove()
    }
    
    func customLoadingView() -> UIViewController? {
        return LoadingViewController()
    }

}



extension UIViewController {
    func add(_ childVC: UIViewController) {
        self.addChild(childVC)
        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    
    func remove() {
        guard self.parent != nil else { return }
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
