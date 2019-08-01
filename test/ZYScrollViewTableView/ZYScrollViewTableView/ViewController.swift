//
//  ViewController.swift
//  ZYScrollViewTableView
//
//  Created by zhangyu on 2018/7/30.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 375, height: 627)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: CGRect(x: 0, y: 40, width: 375, height: 627), collectionViewLayout: layout)
        c.delegate = self
        c.dataSource = self
        c.bounces = false
        c.showsHorizontalScrollIndicator = false
        c.isPagingEnabled = true
        c.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ZYScrollContenViewCollectionViewCell")
        self.view.addSubview(c)
        return c
    }()
    
    var firstIn: Bool = true
    var willDisplayIdx: Int = 0
    var endDisplayIdx: Int = -1
    
    
    lazy var vcArr: [UIViewController] = {
        let a = [ZYOneViewController(), ZYTwoViewController(), ZYThreeViewController(), ZYFourViewController(), ZYFiveViewController()]
        return a
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "one")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "two")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "three")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "four")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "five")
        collectionView.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vcArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "one", for: indexPath)
            let toVc = vcArr[indexPath.item]
            toVc.view.frame = cell.bounds
            cell.contentView.addSubview(toVc.view)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "two", for: indexPath)
//            let toVc = vcArr[indexPath.item]
//            toVc.view.frame = cell.bounds
//            cell.contentView.addSubview(toVc.view)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "three", for: indexPath)
//            let toVc = vcArr[indexPath.item]
//            toVc.view.frame = cell.bounds
//            cell.contentView.addSubview(toVc.view)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "four", for: indexPath)
//            let toVc = vcArr[indexPath.item]
//            toVc.view.frame = cell.bounds
//            cell.contentView.addSubview(toVc.view)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "five", for: indexPath)
//            let toVc = vcArr[indexPath.item]
//            toVc.view.frame = cell.bounds
//            cell.contentView.addSubview(toVc.view)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZYScrollContenViewCollectionViewCell", for: indexPath)
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplay--\(indexPath.item)")
        willDisplayIdx = indexPath.item
//        if firstIn {
//            firstIn = false
            cell.contentView.subviews.forEach( {$0.removeFromSuperview()} )
            let toVc = vcArr[willDisplayIdx]
            toVc.view.frame = cell.bounds
            cell.contentView.addSubview(toVc.view)
            self.addChildViewController(toVc)
            toVc.didMove(toParentViewController: self)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("didEndDisplaying==\(indexPath.item)")
        endDisplayIdx = indexPath.item
//        if willDisplayIdx != endDisplayIdx {
//            cell.contentView.subviews.forEach( {$0.removeFromSuperview()} )
//            let fromVc = vcArr[endDisplayIdx]
//            let toVc = vcArr[willDisplayIdx]
//            toVc.view.frame = cell.bounds
//            cell.contentView.addSubview(toVc.view)
//            self.addChildViewController(toVc)
//            toVc.didMove(toParentViewController: self)
//            fromVc.didMove(toParentViewController: nil)
//            fromVc.removeFromParentViewController()
//        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

