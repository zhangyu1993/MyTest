//
//  ViewController.swift
//  TestProtocol
//
//  Created by zhangyu on 2018/7/19.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

protocol RandomNumberGenerator {
    func random() -> Double
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, gen: RandomNumberGenerator) {
        self.sides = sides
        self.generator = gen
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

class SnakesAndLadders: DiceGame {
    let dice: Dice = Dice(sides: 6, gen: LinearCongruentialGenerator())
    let finalSquare = 25
    var square = 0
    var board: [Int]
    weak var delegate: DiceGameDelegate?
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare :
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

// MARK: ----- 👇

@objc protocol TextRepresentable {
    var textualDescription: String { get }
    var requiredText: String { get }
    @objc optional func optionalFunc()
}

extension TextRepresentable {
    var extText: String { return "" }
    func extensionFunc() { }
}

extension Dice: TextRepresentable {
    var requiredText: String {
        return ""
    }
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
//    func optionalFunc() {
//
//    }
//    func extensionFunc() {
//
//    }
}

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var id: Int = 0
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let d6 = Dice(sides: 6, gen: LinearCongruentialGenerator())
        
//        for _ in 1...5 {
//            print("Random dice roll is \(d6.roll())")
//        }
        
//        let tracker = DiceGameTracker()
//        let game = SnakesAndLadders()
//        game.delegate = tracker
//        game.play()
//
//        let birthdayPerson = Person(name: "Malcolm", age: 21)
//        wishHappyBirthday(to: birthdayPerson)
        
//        func beginConcert(in location:Location & Named) {
//            print("Hello, \(location.name)!")
//        }
//
//        let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
//        beginConcert(in: seattle)
        
    }
    
    func wishHappyBirthday(to celebrator: Named & Aged) {
        print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

