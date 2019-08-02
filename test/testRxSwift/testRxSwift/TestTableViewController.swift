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
 
        
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshBackNormalFooter()

        
        
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


class ViewModel {
    var tableData = BehaviorRelay<[String]>(value: [])
    var endHeaderRefresh: Observable<Bool>
    var endFooterRefresh: Observable<Bool>
    
    init(input: (headerRefresh: Observable<Void>, footerRefresh: Observable<Void>), dependency: (disposeBag: DisposeBag, networkService: NetworkService)) {
        
        let headerRefreshData = input.headerRefresh
            .startWith(())
            .flatMapLatest { _ in
                dependency.networkService.getgetRandomResult()
                .takeUntil(input.footerRefresh)
        }.share(replay: 1)
        
        let footerRefresgData = input.footerRefresh
            .flatMapLatest { _ in
                dependency.networkService.getgetRandomResult()
                .takeUntil(input.headerRefresh)
        }.share(replay: 1)
        
        endHeaderRefresh = Observable.merge(headerRefreshData.map{_ in true}, input.footerRefresh.map({ _ in true}))
        
        endFooterRefresh = Observable.merge(footerRefresgData.map({_ in true}), input.headerRefresh.map({_ in true}))
        
        headerRefreshData.subscribe(onNext: {[weak self] (items) in
            self?.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
        
        footerRefresgData.subscribe(onNext: {[weak self] (items) in
            self?.tableData.accept(self?.tableData.value ?? [] + items)
        }).disposed(by: dependency.disposeBag)
        
    }
}

struct NetworkService {
    func getgetRandomResult() -> Observable<[String]> {
        let item = (0 ..< 15).map { _ in return "随机数据\(Int(arc4random()))" }
        return Observable.just(item).delay(2, scheduler: MainScheduler.instance)
    }
}
