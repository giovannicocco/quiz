//
//  QuizModel.swift
//  Quiz
//
//  Created by Giovanni Brunno Coco on 15/02/16.
//  Copyright © 2016 Giovanni Brunno Coco. All rights reserved.
//

import Foundation
import UIKit

class Question {
    var strQuestion : String!
    var imgQuestion : UIImage!
    var answers : [Answer]!
    
    init (question : String, strImageFileName : String, answers : [Answer]){
        self.strQuestion = question
        self.imgQuestion = UIImage(named: strImageFileName)
        self.answers = answers
    }
}

class Answer {
    var strAnswer : String!
    var isCorrect : Bool!
    
    init (answer : String, isCorrect : Bool) {
        self.strAnswer = answer
        self.isCorrect = isCorrect
    }
}