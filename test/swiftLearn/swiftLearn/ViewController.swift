//
//  ViewController.swift
//  swiftLearn
//
//  Created by zhangyu on 2018/5/28.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit
//import IconButton

enum TestEnum {
    case interView(name: String , color: UIColor)
}

struct TestStructArr {
    var name: String = ""
}

class TestClassArr: Equatable {
    static func == (lhs: TestClassArr, rhs: TestClassArr) -> Bool {
        return lhs.name == rhs.name
    }

    var name: String = ""
    
}

protocol TestProtocol {
    var stringDes: String { get set }
    mutating func adjust()
    
}

class testProClass: TestProtocol {
    var stringDes: String = ""
    func adjust() {
        stringDes = "new stringDes"
    }
    func noProFunc() {
        
    }
}

struct testproStruct: TestProtocol {
    
    var stringDes: String = ""
    
    mutating func adjust() {
        stringDes = "new stringDes"
    }
}

class TestHash: NSObject {
    var name = ""
    var age = 0
    var isSelect = false
}

infix operator +++
infix operator ???
func +++(a: Int, b: Int) -> Int {
    return (a + b) * a * b
}


typealias Filter = (CIImage) -> (CIImage)

class GradientView: UIView {
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var colors: [UIColor]? {
        didSet { updateLayer() }
    }
    
    private func updateLayer() {
        let layer = self.layer as! CAGradientLayer
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.colors = colors?.map({ $0.cgColor })
        
    }
    
}


class ViewController: UIViewController, UITextFieldDelegate {
    
    let txtLayer: CATextLayer = CATextLayer()
    let txtField: UITextField = UITextField()
    
    var testClass1 = TestClassArr() {
        willSet {
            print(testClass1 == newValue)
            print(testClass1 === newValue)
        }
    }
    let testClass2 = TestClassArr()
    
    var str: String? {
        willSet{
        
        }
    }
    var testSet: Set<TestHash> = []
    
    func blur(radius: Double) -> Filter {
        return {
            image in
            let parmenters = [kCIInputRadiusKey : radius, kCIInputImageKey: image] as [String : Any]
            guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parmenters) else {
                fatalError()
            }
            guard let outputImg = filter.outputImage else {
                fatalError()
            }
            return outputImg
        }
    }
    

    lazy var lazyLab: UILabel = {
        let l = UILabel()
        print("lazyLab")
        return l
    }()
    
    var Lab: UILabel = {
        let l = UILabel()
        return l
    }()
    var block: (() -> ())?
    @IBOutlet weak var testLab: LLBUILabel!
//    💩😈👹👺💀👻
    @IBOutlet weak var labH: NSLayoutConstraint!
    
    var dispalyliker: CADisplayLink?
    var i = 0
    @objc func run() {
        i += 1
        print("现在是" + "\(i)秒")
        if i == 10 {
            print("到10秒了")
            i = 0
        }
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return statusBarIsHidden
    }
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
//
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        return UIStatusBarAnimation.slide
//    }
//    
    
    var statusBarIsHidden = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = GradientView(frame: CGRect(x: 10, y: 100, width: 100, height: 30))
        v.backgroundColor = .red
        v.colors = [.red, .yellow, .blue, .brown]
        self.view.addSubview(v)
       
        
//        UIGraphicsBeginImageContextWithOptions(self.navigationController!.view.bounds.size, self.view.isOpaque, 0)
//        self.navigationController?.view.drawHierarchy(in: self.navigationController!.view.bounds, afterScreenUpdates: false)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        let imgv = UIImageView(frame: CGRect(x: 0, y: 150, width: 375 / 2, height: 667 / 2))
//        imgv.image = img
//        self.view.addSubview(imgv)
        
        UIView.animate(withDuration: 3) {
            v.colors = nil
            v.backgroundColor = .yellow
        }
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
             DispatchQueue.main.async {
//                self.statusBarIsHidden = true
//                v.backgroundColor = .yellow
            }
        }
        
//        UIGraphicsBeginImageContextWithOptions(self.navigationController!.view.bounds.size, true, 0)
//        self.navigationController?.view.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let img2 = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        let imgv2 = UIImageView(frame: CGRect(x: 375 / 2, y: 150, width: 375 / 2, height: 667 / 2))
//        imgv2.image = img2
//        self.view.addSubview(imgv2)
        
//        let v = ZYTriView(frame: CGRect(x: 118, y: 100, width: 230, height: 50), radius: 4, triLocation: CGPoint(x: 230 - 33, y: 50), triWidth: 10)
        
//        v.addTriangle(radius: 4, triLocation: CGPoint(x: 230 - 33, y: 50), triWidth: 10)
//        self.view.addSubview(v)
//        self.view.backgroundColor = UIColor.lightGray
    
//        dispalyliker = CADisplayLink.init(target: self, selector: #selector(run))
//        dispalyliker?.preferredFramesPerSecond = 1
//        dispalyliker?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
//        dispalyliker?.isPaused = false
        /*
        let v = UIView()
        v.frame = CGRect(x: 0, y: 26, width: 375, height: 240)
        v.backgroundColor = .red
        self.view.addSubview(v)
        
        
        let sharp = CAShapeLayer()
        
        let path = UIBezierPath()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: 240))
        path.addLine(to: CGPoint(x: 100, y: 240))
        path.addCurve(to: CGPoint(x: 375, y: 104), controlPoint1: CGPoint(x: 272, y: 262 - 26), controlPoint2: CGPoint(x: 375, y: 194-26))
        path.addLine(to: CGPoint(x: 375, y: 0))
        path.addLine(to: .zero)
        
        
        
        
//        path.move(to: CGPoint(x: 300, y: 300))
//        path.addLine(to: CGPoint(x: 300, y: 0))
//
//
//
////        path.move(to: CGPoint(x: 300, y: 300))
//        path.addLine(to: CGPoint(x: 300, y: 400))
////        path.move(to: CGPoint(x: 300, y: 400))
//        path.addLine(to: CGPoint(x: 200, y: 400))
        path.close()
        sharp.path = path.cgPath
//        v.layer.mask = sharp
*/
        
//        let v = LLBUIView()
//        v.gradientColors = [hex(from: 0xFF7041E1).cgColor, hex(from: 0xFF4762F6).cgColor]
//        v.frame = CGRect(x: 0, y: 100, width: 375, height: 50)
//        v.backgroundColor = .red
//        self.view.addSubview(v)
        
//        testLab.gradientColors = [hex(from: 0xFF7041E1).cgColor, hex(from: 0xFF4762F6).cgColor]
        
//        let l = LLBUILabel()
//        l.gradientColors = [hex(from: 0xFF7041E1).cgColor, hex(from: 0xFF4762F6).cgColor]
//        l.frame = CGRect(x: 10, y: 200, width: 355, height: 50)
//        self.view.addSubview(l)
//        l.font = UIFont.systemFont(ofSize: 18)
//        l.textColor = .red
//        l.text = "111111111"
//        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
//            DispatchQueue.main.async {
//                l.frame = CGRect(x: 10, y: 200, width: 200, height: 50)
//                l.textColor = .white
//                l.text = "2222222222"
//                l.layer.cornerRadius = 10
//                l.layer.masksToBounds = true
//            }
//        }
//
        
        
//        let b = LLBUIButton(type: .custom)
//        b.gradientColors = [hex(from: 0xFF7041E1).cgColor, hex(from: 0xFF4762F6).cgColor]
//        b.frame = CGRect(x: 10, y: 500, width: 355, height: 50)
//        self.view.addSubview(b)
//        b.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        b.setTitleColor(.red, for: .normal)
//        b.setTitle("111111", for: .normal)
//        b.backgroundColor = .red
//        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
//            DispatchQueue.main.async {
//                b.gradientColors = nil
//                b.frame = CGRect(x: 10, y: 500, width: 200, height: 50)
//                b.setTitleColor(.white, for: .normal)
//                b.setTitle("2222222", for: .normal)
//            }
//        }
//        
//        b.layer.cornerRadius = 10
//        b.layer.masksToBounds = true
//
//        b.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
 
 
        
        /*
        let berPath = UIBezierPath()
        berPath.addArc(withCenter: CGPoint(x: (375 - 100) / 2, y: 144 - 10), radius: 10, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        berPath.move(to: CGPoint(x: (375 - 100) / 2, y: 144))
        berPath.addLine(to: CGPoint(x: (375 - 100) / 2 + 10, y: 144))
        berPath.addLine(to: CGPoint(x: (375 - 100) / 2 + 10, y: 144 - 10))
        berPath.reversing()
//        berPath.close()
        
        let berPath2 = UIBezierPath()
        berPath2.move(to: CGPoint(x: (375 - 100) / 2 + 10, y: 144 - 10))
        berPath2.addLine(to: CGPoint(x: (375 - 100) / 2 + 10, y: 144))
        berPath2.addLine(to: CGPoint(x: (375 - 100) / 2 + 10 + 80, y: 144))
        berPath2.addLine(to: CGPoint(x: (375 - 100) / 2 + 10 + 80, y: 144 - 10))
        berPath2.addArc(withCenter: CGPoint(x:375 / 2, y: 144 - 10), radius: 40, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        
        let berPath3 = UIBezierPath()
        berPath3.addArc(withCenter: CGPoint(x: (375 + 100) / 2, y: 144 - 10), radius: 10, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi , clockwise: true)
        berPath3.move(to: CGPoint(x: (375 + 100) / 2 - 10, y: 144 - 10))
        berPath3.addLine(to: CGPoint(x: (375 + 100) / 2 - 10, y: 144))
        berPath3.addLine(to: CGPoint(x: (375 + 100) / 2, y: 144))
        berPath3.reversing()
        
        let berPath10 = UIBezierPath()
        berPath10.addArc(withCenter: CGPoint(x: (375 + 100) / 2, y: 144 - 10), radius: 10, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi , clockwise: true)
        berPath10.addArc(withCenter: CGPoint(x:375 / 2, y: 144 - 10), radius: 40, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        berPath10.addArc(withCenter: CGPoint(x: (375 - 100) / 2, y: 144 - 10), radius: 10, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        
        berPath.append(berPath2)
        berPath.append(berPath3)
        
        let shape = CAShapeLayer()
        shape.path = berPath10.cgPath
//        shape.strokeColor = UIColor.red.cgColor
        self.view.layer.addSublayer(shape)
//        bgImageView.layer.mask = shape
        
        */
        
        /*
        let r = 5
        let quene1 = DispatchQueue(label: "com.appcoda.queue1", attributes: .concurrent)
        let group = DispatchGroup()
        group.enter()
        let work1 = DispatchWorkItem.init {
            for i in 0 ..< r {
                sleep(1)
                print( "👻 " + "\(i)")
            }
            self.block = {
                print("1111")
                group.leave()
            }
            
        }
        let work2 = DispatchWorkItem.init {
            for i in 0 ..< r {
                sleep(1)
                print( "👺 " + "\(i)")
            }
        }
        
        quene1.async(execute: work1)
        
        quene1.async(group: group, execute: work2)
        
        quene1.async {
            for i in 0 ..< r*2 {
                sleep(2)
                print( "💩 " + "\(i)")
            }
        }
        
        quene1.async {
            for i in 0 ..< r*2 {
                sleep(1)
                print( "😈 " + "\(i)")
            }
        }

        
        for i in 0 ..< r {
            print( "👹 " + "\(i)")
        }
        
        group.notify(queue: DispatchQueue.global()) {
            print("notifynotifynotify")
        }
 */
      /*
        testLab.font = UIFont.systemFont(ofSize: 20)

        let str: String = "一1二2三3四4五5六6七7；‘。、【】，，，、。。【【】【，。，%&**（*）（）&￥#￥@￥%￥"
        let rect = testLab.frame

        testLab.text = str

        
        let attStr = NSMutableAttributedString.init(string: str)
        attStr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 20), range: NSRange(location: 0, length: str.count))
        
        let frameSetter = CTFramesetterCreateWithAttributedString(attStr)
        let path = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: CGFloat.greatestFiniteMagnitude))
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil);
        let lines = CTFrameGetLines(frame) as Array
    
        lines.forEach { (line) in
        
            let lineRef = line as! CTLine
            let lineRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineStr = String(str[str.index(str.startIndex, offsetBy: range.location)..<str.index(str.startIndex, offsetBy: range.location+range.length)])
            print(lineStr)
        }
        
        self.view.backgroundColor = .red
        
        
        let v = UIView()
        v.frame = self.view.bounds
        v.backgroundColor = UIColor.black
        v.alpha = 0.5
        self.view.addSubview(v)
        
//        let mask = CAShapeLayer()
//        let bpath = UIBezierPath.init(ovalIn: CGRect(x: 100, y: 100, width: 50, height: 50))
//        mask.path = bpath.cgPath
//        v.layer.mask = mask

        let p = UIBezierPath(rect:CGRect(x: 10, y: 20, width: 300, height: 300))
        
        p.append(UIBezierPath(ovalIn: CGRect(x: 50, y: 100, width: 150, height: 60)).reversing())
        let shape = CAShapeLayer()
        
        shape.path = p.cgPath
        
        v.layer.mask = shape
        */
        /*
        let t1 = testProClass()
        t1.stringDes = "proClass"
        var t2 = testproStruct()
        t2.stringDes = "proStruct"
        
        doSomething(pro: t1)
        doSomething(pro: t2)
        
        _ = lazyLab
        _ = Lab
        
        print("---------")
        
        _ = lazyLab
        _ = Lab
        */
        /*
        let t1 = TestHash()
        t1.name = "111"
        t1.age = 111
        t1.isSelect = true
        
        let t2 = TestHash()
        t2.name = "222"
        t2.age = 222
        t2.isSelect = false
 
        testSet.insert(t1)
        testSet.insert(t2)
        
        
        
//        t1.name = "1112"
//        t1.age = 111111
        t1.isSelect = false
        
        print(testSet.remove(t1))
        print(testSet)
 */
        /*
        var str1 = "qwertyuiop"
        let range = str1.startIndex ... str1.index(str1.startIndex, offsetBy: 2)
        str1.removeSubrange(range)
        print(str1)
        
        let greeting = "Hello, world!"
        let index = greeting.index(of: ",") ?? greeting.endIndex
        let beginning = greeting.prefix(upTo: index)
        let ending = greeting.suffix(from: greeting.index(greeting.startIndex, offsetBy: 1))
        print(beginning)
        print(ending)
        print(index.encodedOffset)
        
        let b1 = greeting[greeting.startIndex..<index]
        let e1 = greeting[index..<greeting.endIndex]
        print(b1)
        print(e1)
        
        print(beginning.description)
        
        
        let letters1: Set<Character> = []
        var letters2: [String:Int] = [:]
        var letters3 = [String]()
        
        letters3.sort(by: >)
        
        print(letters2.updateValue(3, forKey: "3"))

        
        if #available(iOS 10, *) {
            
        }
        
 */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getGradientImage(colors: [UIColor.red.cgColor, UIColor.yellow.cgColor]), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.isTranslucent = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getGradientImage(colors: [UIColor.red.cgColor, UIColor.yellow.cgColor]), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func doSomething(pro: TestProtocol) {
        print(pro.stringDes)
    }
    
    func testGen() {
        print(makeArray(repeating: "111", numberOfTimes: 4))
        print(makeArray(repeating: 222, numberOfTimes: 4))
        print(makeArray(repeating: [1], numberOfTimes: 4))
    }
    
    func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
        var result = [Item]()
        for _ in 0..<numberOfTimes {
            result.append(item)
        }
        return result
    }
    
    
    
    func txtFieldAnim() {
        self.view.addSubview(txtField)
        txtField.frame = CGRect(x: 50, y: 85, width: 200, height: 30)
        txtField.font = UIFont.systemFont(ofSize: 20)
        txtField.delegate = self
        
        
        txtLayer.string = "测试一哈能不能用"
        txtLayer.fontSize = 20
        txtLayer.foregroundColor = UIColor.red.cgColor
        txtLayer.contentsScale = UIScreen.main.scale
        
        txtField.layer.addSublayer(txtLayer)
        txtLayer.bounds = CGRect(x: 0, y: 0, width: 200, height: 30)
        txtLayer.position = CGPoint(x: 100, y: 15)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let anim1 = CABasicAnimation(keyPath: "fontSize")
        anim1.fromValue = 20
        anim1.toValue = 12
        
        let anim2 = CABasicAnimation(keyPath: "position")
        anim2.fromValue = CGPoint(x: 100, y: 15)
        anim2.toValue = CGPoint(x: 100, y: -5)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 0.25
        groupAnimation.beginTime = CACurrentMediaTime()
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [anim1, anim2]
        self.txtLayer.add(groupAnimation, forKey: nil)
        CATransaction.commit()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let anim1 = CABasicAnimation(keyPath: "fontSize")
        anim1.fromValue = 12
        anim1.toValue = 20
        
        let anim2 = CABasicAnimation(keyPath: "position")
        anim2.fromValue = CGPoint(x: 100, y: -5)
        anim2.toValue = CGPoint(x: 100, y: 15)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 0.25
        groupAnimation.beginTime = CACurrentMediaTime()
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [anim1, anim2]
        self.txtLayer.add(groupAnimation, forKey: nil)
        CATransaction.commit()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtField.endEditing(true)
        
    }
    
    func classAndStruct() {
        var structArr: [TestStructArr] = []
        for i in 0..<4 {
            var m = TestStructArr()
            m.name = "aaa" + "\(i)"
            structArr.append(m)
        }
        let a3 = changeStructArr(arr: structArr)
        structArr.forEach { (m) in
            print(m.name)
        }
        print(".....")
        a3.forEach { (m) in
            print(m.name)
        }
        print(structArr, a3)
        
        print("==============")
        
        var classArr: [TestClassArr] = []
        for i in 0..<4 {
            let m = TestClassArr()
            m.name = "bbb" + "\(i)"
            classArr.append(m)
        }
        let a4 = changeClassArr(arr: classArr)
        
        let m = TestClassArr()
        m.name = "9999"
        classArr.append(m)
        
        classArr.forEach { (m) in
            print(m.name)
        }
        print(".....")
        a4.forEach { (m) in
            print(m.name)
        }
        print(classArr.debugDescription)
        print(a4.debugDescription)
    }
    
    func changeStructArr(arr: [TestStructArr]) -> [TestStructArr] {
        var a2 = Array.init(arr)
        var m = TestStructArr()
        m.name = "qwer"
        a2.append(m)
        a2[0].name = "zxcv"
        return a2
    }
    
    func changeClassArr(arr: [TestClassArr]) -> [TestClassArr] {
        var a2 = arr
        arr[0].name = "1234"
        let m = TestClassArr()
        m.name = "5678"
        a2.append(m)
        return a2
        
    }
    
    @objc func btnClick() {
        print("asdfg")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


class ZYTriView: LLBUIView {
    
    var radius: CGFloat = 0
    var triLocation: CGPoint = .zero
    var triWidth: CGFloat = 0
    
    
    init(frame: CGRect, radius: CGFloat, triLocation: CGPoint, triWidth: CGFloat) {
        super.init(frame: frame)
        self.radius = radius
        self.triLocation = triLocation
        self.triWidth = triWidth
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

}


extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
    
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}
