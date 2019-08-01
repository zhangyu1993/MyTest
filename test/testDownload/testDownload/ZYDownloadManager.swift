//
//  ZYDownloadManager.swift
//  testDownload
//
//  Created by zhangyu on 2019/7/4.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit

class ZYDownloadManager: NSObject, URLSessionDataDelegate {
    
    /// 文件模型
    var fileModel: ZYFileManager = ZYFileManager()
    /// 流处理类
    var stream: OutputStream?
    /// 当前下载的流长度
    var currentLength: Int = 0
    
    lazy var session: URLSession = {
        let s = URLSession(configuration: .background(withIdentifier: "ZYFileManager.BackgroundSession"), delegate: self, delegateQueue: OperationQueue.main)
        return s
    }()
    
    lazy var dataTask: URLSessionDataTask? = {
        currentLength = fileModel.alreadyLength
        if let url = URL(string: fileModel.fileUrlStr) {
            var request = URLRequest(url: url)
            request.addValue("bytes=\(currentLength)-", forHTTPHeaderField: "Range")
            return session.dataTask(with: request)
        }
        return nil
    }()
    
    override init() {
        stream = OutputStream(toFileAtPath: fileModel.filePath, append: true)
    }
    
    func start() {
        dataTask?.resume()
    }
    
    func stop() {
        dataTask?.suspend()
    }
    
    func cancel() {
        dataTask?.cancel()
    }
    
    // MARK: - URLSessionDataDelegate -----
    
    /// 接收到服务器响应
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("didReceive response")
        stream?.open()
        completionHandler(.allow)
    }
    
    /// 开始下载数据
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask) {
        print("didBecome downloadTask")
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask) {
        print("didBecome streamTask")
    }
    
    /// 接收到数据回调
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        currentLength += data.count
        print(currentLength)
        stream?.write([UInt8](data), maxLength: data.count)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        print("willCacheResponse")
    }
    
    /// 当请求完成之后调用，如果请求失败error有值
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        stream?.close()
        stream = nil
        print("下载结束", error)
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("urlSessionDidFinishEvents")
    }
    
}
