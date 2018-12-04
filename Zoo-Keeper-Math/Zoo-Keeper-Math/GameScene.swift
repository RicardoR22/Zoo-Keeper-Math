//
//  GameScene.swift
//  Zoo-Keeper-Math
//
//  Created by Ricardo Rodriguez on 11/14/18.
//  Copyright © 2018 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var answer1 : Answer?
    var answer2 : Answer?
    var problemLabel = SKLabelNode(fontNamed: "Optima-Bold")
    var arg1 : Int?
    var arg2 : Int?
    var ans1 = 0
    var ans2 = 0
    var expectingInput = true

    

    
    override func didMove(to view: SKView) {
        gameLoop()
        
    }
    
    // The game loop. Responsible for keeping the game running
    func gameLoop() {
        createProblem()
        createResponses()
        createAnswers()
        expectingInput = true
    }
    
    
    // Function that handles creating the math problem
    func createProblem() {
        // generate 2 random integers
        arg1 = Int.random(in: 5...10)
        arg2 = Int.random(in: 5...10)
        
        if let arg1 = arg1{
            if let arg2 = arg2 {
                // Display the problem. Integer1 + Integer2
                problemLabel.text = ("\(arg1) + \(arg2)")
                
            }
        }
        
        // Set properties for the label displaying the problem
        if let view = self.view{
            problemLabel.fontSize = 100
            problemLabel.fontColor = .black
            problemLabel.position.x = view.bounds.width/2 + 300
            problemLabel.position.y = (view.bounds.height/2) + 400
            problemLabel.zPosition = 10
            
        }
        if problemLabel.parent == nil {
            addChild(problemLabel)
        }
    }
    
    // Function that handles creating the Answers
    func createAnswers() {
        // Created instances of Answer class
        if (answer1 == nil) && (answer2 == nil) {
            answer1 = Answer(scene: self, answer: ans1)
            answer2 = Answer(scene: self, answer: ans2)
        } else {
            answer1?.removeFromParent()
            answer2?.removeFromParent()
            answer1 = Answer(scene: self, answer: ans1)
            answer2 = Answer(scene: self, answer: ans2)
        }
        
        
        if let view = self.view {
            if let answer1 = answer1 {
                if let answer2 = answer2 {
                    // Set Answer properties
                    answer1.position.x = view.bounds.width/2 + 100
                    answer1.position.y = (view.bounds.height/2) + 200
                    answer1.zPosition = 10
                    answer2.position.x = view.bounds.width/2 + 500
                    answer2.position.y = (view.bounds.height/2) + 200
                    answer2.zPosition = 10

                }
            }
            if answer1?.parent == nil && answer2?.parent == nil {
                addChild(answer1!)
                addChild(answer2!)
            }
        }
    }
    
    // Function that handles creating the responses for the question
    func createResponses() {
        // Chooses a random cloud to hold the correct answer
        let correctAnswer = Int.random(in: 1...2)
        guard let arg1 = arg1 else {
            print("No Argument 1")
            return
        }
        guard let arg2 = arg2 else {
            print("No Argument 2")
            return
        }
        
        // Assigns the answer values to each Button
        if correctAnswer == 1 {
            // One gets the correct answer, the other get a random answer.
            ans1 = arg1 + arg2
            ans2 = Int.random(in: 5...10) + Int.random(in: 5...9)
            if ans1 == ans2 {
                repeat {
                    ans2 = Int.random(in: 5...10) + Int.random(in: 5...9)
                } while ans1 == ans2
            }
        } else {
            ans2 = arg1 + arg2
            ans1 = Int.random(in: 5...10) + Int.random(in: 5...9)
            if ans1 == ans2 {
                repeat {
                    ans1 = Int.random(in: 5...10) + Int.random(in: 5...9)
                } while ans1 == ans2
                
            }
        }
    }
    
    // Checks the users answer
    func checkAnswer(node: Answer)  {
        guard let arg1 = arg1 else {
            print("No Argument 1")
            return
        }
        guard let arg2 = arg2 else {
            print("No Argument 2")
            return
        }
        
        if node.answerValue == arg1 + arg2 {
            problemLabel.text = "Correct!"
            node.color = UIColor.buttonCorrect
//            score += 1
        } else {
            problemLabel.text = "Wrong"
            node.color = UIColor.buttonWrong
//            score = 0
            
        }
    }
    
    
    // Handles the detection of a touch on a cloud
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        var node = atPoint(location)
        if (node.name == "answer" || node.name == "answerLabel") && expectingInput == true {
            expectingInput = false
            if node.name == "answerLabel" {
                node = node.parent!
            }
            self.checkAnswer(node: node as! Answer)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.gameLoop()
            }
        }
    }
    
}
