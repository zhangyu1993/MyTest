//
//  ZYFileManager.swift
//  testDownload
//
//  Created by zhangyu on 2019/7/4.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit

class ZYFileManager: NSObject {

    let fileManager = FileManager.default
    
    /// 文件url地址
    var fileUrlStr = "https://dldir1.qq.com/foxmail/work_weixin/WXWork_2.8.5.2051.dmg"
    /// 保存的文件名
    var fileName = "WXWork_2.8.5.2051.dmg"
    /// 总长度
    var totalLength: Int = 0
    /// 已下载长度
    var alreadyLength: Int {
        return getFileLength()
    }
    /// 文件在本地保存的地址
    var filePath:String {
        return getVideoFile() + fileName
    }
    /// 是否完成
    var isFinish: Bool {
        if totalLength != 0, totalLength == alreadyLength {
            return true
        }
        return false
    }
    
    func getFileLength() -> Int {
        let filePath = getVideoFile() + fileName
        do {
            let dic = try fileManager.attributesOfItem(atPath: filePath)
            return dic[FileAttributeKey.size] as? Int ?? 0
        } catch {
            return 0
        }
    }
    
    
    func getVideoFile() -> String {
        let path = NSHomeDirectory() + "/Documents/Video/"
        let exist = fileManager.fileExists(atPath: path)
        if !exist {
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                
            }
        }
        return path
    }
    
}
