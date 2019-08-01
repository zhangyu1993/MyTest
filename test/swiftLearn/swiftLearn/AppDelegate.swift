//
//  AppDelegate.swift
//  swiftLearn
//
//  Created by zhangyu on 2018/5/28.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension UILabel {
//    open override func draw(_ rect: CGRect) {
//        let context = UIGraphicsGetCurrentContext()
//        context?.saveGState()
//        context?.scaleBy(x: 1.0, y: -1.0)
//        context?.translateBy(x: 0, y: -rect.size.height)
//        //        let locations: [CGFloat] = [0, 1]
//        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [hex(from: 0xFF7041E1).cgColor, hex(from: 0xFF4762F6).cgColor] as CFArray, locations: nil)
//        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
//        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
//        if let _ = gradient {
//            context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [[.drawsAfterEndLocation, .drawsBeforeStartLocation]])
//            context?.restoreGState()
//        }
//        super.draw(rect)
//    }
}

func hex(from hex: UInt) -> UIColor {
    let a = CGFloat((hex >> 24) & 0xFF)
    let r = CGFloat((hex >> 16) & 0xFF)
    let g = CGFloat((hex >> 8) & 0xFF)
    let b = CGFloat(hex & 0xFF)
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0)
}

