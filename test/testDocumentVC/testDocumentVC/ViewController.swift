//
//  ViewController.swift
//  testDocumentVC
//
//  Created by zhangyu on 2018/6/4.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

class ZYDocument: UIDocument {
    
    var fileData: Data?
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        fileData = contents as? Data
    }
    
}


class ViewController: UIViewController, UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate{

    @IBAction func btnClick(_ sender: Any) {
        
        let vc: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf","com.microsoft.word.doc"], in: .open)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        if let url = urls.first {
//            let f: FileManager = FileManager.default
//            let u = f.url(forUbiquityContainerIdentifier: nil)
//            if let _ = u {
                let d: ZYDocument = ZYDocument(fileURL: url)
                d.open { (oSuccess) in
                    if oSuccess {
                        d.close(completionHandler: { (cSuccess) in
                            if cSuccess {
                                print("关闭成功")
                            }
                            else {
                                print("关闭失败")
                            }
                        })
//                        let preview = UIDocumentInteractionController.init(url: url)
//                        preview.delegate = self
//                        if !preview.presentPreview(animated: true) {
//
//                        }
//                        print(d.fileData)
                        
                        self.getData(fileData: d.fileData!, fileName: url.absoluteString.removingPercentEncoding!.components(separatedBy: "/").last!)
                    }
                }
//            }
        }
       
        
    }
    
    func getData(fileData: Data, fileName: String) {
        let f: FileManager = FileManager.default
        var cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        if let _ = cachePath {
            cachePath!.append("/zyfile")
            
            guard let _ = try? f.createDirectory(atPath: cachePath!, withIntermediateDirectories: true, attributes: nil) else {
                return
            }
            cachePath!.append("/\(fileName)")
            guard let _ = try? fileData.write(to: URL.init(fileURLWithPath: cachePath!)) else {
                return
            }
//            fileData.write(to: URL.init(fileURLWithPath: cachePath!), options: Data.WritingOptions)
            
            let preview = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: cachePath!))
            preview.delegate = self
            if !preview.presentPreview(animated: true) {
                
            }
            
        }
        
        print(cachePath)

    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

