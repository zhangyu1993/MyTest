//
//  AAAAViewController.swift
//  swiftLearn
//
//  Created by zhangyu on 2018/8/16.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

class AAAAViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 375, height: 30))
        cell.contentView.addSubview(lab)
        lab.text = "qqqqqq222222"
        lab.textColor = .red
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
       
        
        let tab = UITableView(frame: CGRect(x: 0, y: 0, width: 375, height: 667), style: UITableViewStyle.plain)
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tab.delegate = self
        tab.dataSource = self
        tab.reloadData()
//        tab.contentInset = UIEdgeInsets(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
        if #available(iOS 11.0, *) {
            tab.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(tab)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getGradientImage(colors: [UIColor.clear.cgColor, UIColor.clear.cgColor]), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getGradientImage(colors: [UIColor.red.cgColor, UIColor.yellow.cgColor]), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getGradientImage(colors: [UIColor.clear.cgColor, UIColor.clear.cgColor]), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.isTranslucent = true
//    }
    

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
