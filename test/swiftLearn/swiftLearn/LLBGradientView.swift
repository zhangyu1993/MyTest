//
//  LLBGradientView.swift
//  swiftLearn
//
//  Created by zhangyu on 2018/8/8.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

class LLBUIView: UIView {
    /// 渐变色数组
    var gradientColors: [CGColor]? = [hex(from: 0xFF7041E1).cgColor, hex(from: 0xFF4762F6).cgColor] {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// 重新绘制view
    ///
    /// - Parameter rect: <#rect description#>
    override func draw(_ rect: CGRect) {
        if let _ = gradientColors {
            drawGradientView(colors: gradientColors!, rect: rect)
        }
        super.draw(rect)
    }
}

class LLBUILabel: UILabel {
    /// 渐变色数组
    var gradientColors: [CGColor]? = nil {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// 重新绘制view
    ///
    /// - Parameter rect: <#rect description#>
    override func draw(_ rect: CGRect) {
        if let _ = gradientColors {
            drawGradientView(colors: gradientColors!, rect: rect)
        }
        super.draw(rect)
    }
    
}

class LLBUIButton: UIButton {
    /// 渐变色数组
    var gradientColors: [CGColor]? = nil {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// 重新绘制view
    ///
    /// - Parameter rect: <#rect description#>
    override func draw(_ rect: CGRect) {
        if let _ = gradientColors {
            drawGradientView(colors: gradientColors!, rect: rect)
        }
        super.draw(rect)
    }
}

extension UIImage {
    static func getGradientImage(colors: [CGColor]) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 375, height: 64)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.translateBy(x: 0, y: -rect.size.height)
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: nil)
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        if let _ = gradient {
            context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [])
            context?.restoreGState()
        }
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

fileprivate func drawGradientView(colors: [CGColor], rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    context?.saveGState()
    let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: nil)
    let startPoint = CGPoint(x: rect.minX, y: rect.midY)
    let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
    if let _ = gradient {
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [[.drawsAfterEndLocation, .drawsBeforeStartLocation]])
        context?.restoreGState()
    }
}

