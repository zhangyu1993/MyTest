//
//  ZYScrollContenView.swift
//  ZYScrollViewTableView
//
//  Created by zhangyu on 2018/7/30.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

/// 逻辑协议
protocol ZYScrollContenViewDelegate: AnyObject {
    
}
/// 数据源协议
protocol ZYScrollContenViewDataSource: AnyObject {
    
}

class ZYScrollContenView: UIView {
    /// 逻辑代理
    weak var delegate: ZYScrollContenViewDelegate?
    /// 数据源代理
    weak var dataSource: ZYScrollContenViewDataSource?
    /// 父视图控制器
    weak var parentVC: UIViewController?
    /// 存储注册的vc
    lazy var registerVCDic: [String:UIViewController] = [:]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        c.delegate = self
        c.dataSource = self
        c.bounces = false
        c.showsHorizontalScrollIndicator = false
        c.isPagingEnabled = true
        c.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ZYScrollContenViewCollectionViewCell")
        self.addSubview(c)
        return c
    }()
    
    /// 初始化视图
    ///
    /// - Parameters:
    ///   - frame: 视图大小
    ///   - parentVC: 父视图控制器
    init(frame: CGRect, parentVC: UIViewController) {
        super.init(frame: frame)
        self.parentVC = parentVC
        collectionView.reloadData()
    }
    
    /// 注册vc
    ///
    /// - Parameters:
    ///   - subVC: 要显示的vc
    ///   - identifier: id
    open func register(_ subVC: UIViewController, forVCWithReuseIdentifier identifier: String) {
        registerVCDic[identifier] = subVC
    }
    
    /// 从注册池里面获取vc
    ///
    /// - Parameters:
    ///   - identifier: id
    ///   - index: 当前显示的vc 下标
    /// - Returns: id对应的vc
    open func dequeueReusableVC(withReuseIdentifier identifier: String, for index: Int) -> UIViewController? {
        return registerVCDic[identifier]
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - collectionView代理
extension ZYScrollContenView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
