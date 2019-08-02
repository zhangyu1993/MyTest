//
//  ViewController.swift
//  testRxSwift
//
//  Created by zhangyu on 2019/5/30.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var countLab: UILabel!
    let musicListViewModel = MusicListViewModel()
    @IBOutlet weak var rxButton: UIButton!
    @IBOutlet weak var rxTextField: UITextField!
    @IBOutlet weak var rxButton2: UIButton!
    @IBOutlet weak var rxButton3: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let disposeBag = DisposeBag()
    let leftTime = Variable(TimeInterval(180))
    let countDownStopped = Variable(true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        musicListViewModel.data.bind(to: tableview.rx.items(cellIdentifier: "musicCell")) { (i, model, cell) in
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.singer
        }.disposed(by: disposeBag)
        
        tableview.rx.modelSelected(Music.self).subscribe(onNext: { (music) in
            print(music.description)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        let buttons = [rxButton, rxButton2, rxButton3].map { $0! }
        
        let selectedBtn = Observable.from(buttons.map({ (btn) in
            return btn.rx.tap.map { (btn, btn.tag) }
        })).merge()
        
        for btn in buttons {
            selectedBtn.map { $0.0 == btn }.bind(to: btn.rx.isSelected).disposed(by: disposeBag)
            selectedBtn.subscribe(onNext: {[weak self] (item) in
                self?.countLab.text = "这是第\(item.1)个按钮"
            }).disposed(by: disposeBag)
        }
        
        getp("0").subscribe { (event) in
            switch event {
            case .success(let json):
                print(json)
            case .error(let err):
                print(err)
            }
        }.disposed(by: disposeBag)
        
        let results = rxTextField.rx.text.asDriver()
            .throttle(0.3)
            .flatMapLatest{self.getp($0!).asDriver(onErrorJustReturn: [:])}
        results.drive(onNext: { (item) in
            print(item)
        }).disposed(by: disposeBag)
        
    }

    func getPlaylist(_ channel: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create(subscribe: { (single) -> Disposable in
            single(.success(["1": "2"]))
            
            return Disposables.create {
                
            }
        })
    }
    
    ///延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - closure: 延迟执行的闭包
    public func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    //显示消息提示框
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func getp(_ channel: String) -> Single<[String:Any]> {
        return Single<[String:Any]>.create(subscribe: { (single) -> Disposable in
            let url = "https://douban.fm/j/mine/playlist?"
                + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, res, err) in
                if let e = err {
                    single(.error(e))
                    return
                }
                guard let d = data, let json = try? JSONSerialization.jsonObject(with: d, options: .mutableLeaves), let result = json as? [String:Any] else {
                    single(.error(DataError.cantParseJSON))
                    return
                }
                single(.success(result))
            })
            task.resume()
            return Disposables.create { task.cancel() }
        })
    }

}


//与数据相关的错误类型
enum DataError: Error {
    case cantParseJSON
}

struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}


extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self, binding: { (lab, size) in
            lab.font = UIFont.systemFont(ofSize: size)
        })
    }
}
