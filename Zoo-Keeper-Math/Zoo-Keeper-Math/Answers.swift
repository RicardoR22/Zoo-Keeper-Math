//
//  Answers.swift
//  Zoo-Keeper-Math
//
//  Created by Ricardo Rodriguez on 11/27/18.
//  Copyright © 2018 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit

//Class for creating Answers
class Answer: SKSpriteNode {
    var answerValue: Int
    var answerLabel = SKLabelNode(text: "2")
    
    init(scene: SKScene, answer: Int) {
        let size = CGSize(width: 250, height: 150)
        self.answerValue = answer
        super.init(texture: nil, color: .gray, size: size)
        self.name = "answer"
        answerLabel.fontSize = 50
        answerLabel.zPosition = 10
        answerLabel.horizontalAlignmentMode = .center
        answerLabel.verticalAlignmentMode = .center
        answerLabel.fontName = "Optima-Bold"
        answerLabel.fontColor = .black
        answerLabel.text = String(self.answerValue)
        
        
        addChild(answerLabel)
        
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
}
