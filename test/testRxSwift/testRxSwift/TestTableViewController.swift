//
//  TestTableViewController.swift
//  testRxSwift
//
//  Created by zhangyu on 2019/8/1.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class TestTableViewController: UIViewController {

    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var randomResult = BehaviorSubject(value: [SectionModel<String,Int>]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
 
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,Int>>(configureCell: { (data, tb, idx, model) -> UITableViewCell in
            let cell = tb.dequeueReusableCell(withIdentifier: "cell", for: idx)
            cell.textLabel?.text = "条目\(idx.row)：\(model)"
            return cell
        })

        randomResult.asObservable().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
    
    func getRandomResult() -> BehaviorSubject<[SectionModel<String,Int>]> {
        print("请求中...")
        let item = (0 ..< 5).map { _ in Int(arc4random()) }
        var arr = try! randomResult.value()
        arr[0].items.append(contentsOf: item)
        randomResult.onNext(arr)
        return randomResult
    }

    
    
}
