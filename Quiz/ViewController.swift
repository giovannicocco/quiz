//
//  ViewController.swift
//  Quiz
//
//  Created by Giovanni Brunno Coco on 15/02/16.
//  Copyright © 2016 Giovanni Brunno Coco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer4: UIButton!
    
    @IBOutlet weak var viewFeedback: UIView!
    @IBOutlet weak var lbFeedback: UILabel!
    @IBOutlet weak var btnFeedback: UIButton!
    
    var questions : [Question]!
    var currentQuestion = 0
    var grade = 0.0
    var quizEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let q0answer0 = Answer(answer: "Arquipélogo", isCorrect: true)
        let q0answer1 = Answer(answer: "Não tem coletivo", isCorrect: false)
        let q0answer2 = Answer(answer: "Ilhas", isCorrect: false)
        let q0answer3 = Answer(answer: "Ilhéos", isCorrect: false)
        let question0 = Question(question: "Qual o coletivo de Ilha?", strImageFileName: "ilha", answers: [q0answer0, q0answer1, q0answer2, q0answer3])
        
        let q1answer0 = Answer(answer: "Canguri", isCorrect: false)
        let q1answer1 = Answer(answer: "Capivara", isCorrect: false)
        let q1answer2 = Answer(answer: "Coala", isCorrect: false)
        let q1answer3 = Answer(answer: "Tamanduá", isCorrect: true)
        let question1 = Question(question: "Qual desses animais se alimenta de cupins e formigas?", strImageFileName: "formiga", answers: [q1answer0, q1answer1, q1answer2, q1answer3])
        
        let q2answer0 = Answer(answer: "Alqueire", isCorrect: false)
        let q2answer1 = Answer(answer: "Are", isCorrect: false)
        let q2answer2 = Answer(answer: "Acre", isCorrect: false)
        let q2answer3 = Answer(answer: "Hectare", isCorrect: true)
        let question2 = Question(question: "Que nome recebe a unidade de área equivalente a 10.000 metros quadrados?", strImageFileName: "metros", answers: [q2answer0, q2answer1, q2answer2, q2answer3])
        
        let q3answer0 = Answer(answer: "Delatar", isCorrect: true)
        let q3answer1 = Answer(answer: "Sacudir", isCorrect: false)
        let q3answer2 = Answer(answer: "Erguer", isCorrect: false)
        let q3answer3 = Answer(answer: "Puxar", isCorrect: false)
        let question3 = Question(question: "Na gíria, dedar é o mesmo que:", strImageFileName: "finger", answers: [q3answer0, q3answer1, q3answer2, q3answer3])
        
        let q4answer0 = Answer(answer: "Sol", isCorrect: false)
        let q4answer1 = Answer(answer: "Lua", isCorrect: true)
        let q4answer2 = Answer(answer: "Marte", isCorrect: false)
        let q4answer3 = Answer(answer: "Terra", isCorrect: false)
        let question4 = Question(question: "Que corpo celeste exerce maior influência sobre as marés?", strImageFileName: "ocean", answers: [q4answer0, q4answer1, q4answer2, q4answer3])
        
        let q5answer0 = Answer(answer: "Meio-dia e meio", isCorrect: false)
        let q5answer1 = Answer(answer: "Meio-dia e meia", isCorrect: true)
        let q5answer2 = Answer(answer: "Meia-dia e meio", isCorrect: false)
        let q5answer3 = Answer(answer: "Meia-dia e meia", isCorrect: false)
        let question5 = Question(question: "12 horas e 30 minutos é o mesmo que:", strImageFileName: "clock", answers: [q5answer0, q5answer1, q5answer2, q5answer3])
        
        questions = [question0, question1, question2, question3, question4, question5]
        
        startQuiz()
    }
    
    func startQuiz() {
        questions.shuffle()
        for(var i=0;i<questions.count;i++){
            questions[i].answers.shuffle()
        }
        
        quizEnded = false
        grade = 0.0
        currentQuestion = 0
        
        showQuestion(0)
    }
    
    func showQuestion(questionid : Int) {
        btnAnswer1.enabled = true
        btnAnswer2.enabled = true
        btnAnswer3.enabled = true
        btnAnswer4.enabled = true

        
        lbQuestion.text = questions[questionid].strQuestion
        imgQuestion.image = questions[questionid].imgQuestion
        btnAnswer1.setTitle(questions[questionid].answers[0].strAnswer, forState: UIControlState.Normal)
        btnAnswer2.setTitle(questions[questionid].answers[1].strAnswer, forState: UIControlState.Normal)
        btnAnswer3.setTitle(questions[questionid].answers[2].strAnswer, forState: UIControlState.Normal)
        btnAnswer4.setTitle(questions[questionid].answers[3].strAnswer, forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseAnswer1(sender: AnyObject) {
        selectAnswer(0)
    }
    
    @IBAction func chooseAnswer2(sender: AnyObject) {
        selectAnswer(1)
    }
    
    @IBAction func chooseAnswer3(sender: AnyObject) {
        selectAnswer(2)
    }
    
    @IBAction func chooseAnswer4(sender: AnyObject) {
        selectAnswer(3)
    }
    
    func selectAnswer(answerid : Int){
        btnAnswer1.enabled = false
        btnAnswer2.enabled = false
        btnAnswer3.enabled = false
        btnAnswer4.enabled = false
        
        viewFeedback.hidden = false
        
        let answer : Answer = questions[currentQuestion].answers[answerid]
        
        if(answer.isCorrect == true){
            grade = grade + 1.0
            lbFeedback.text = answer.strAnswer + "\n\nResposta correta!"
        }else{
            lbFeedback.text = answer.strAnswer + "\n\nResposta incorreta!"
        }
        
        if(currentQuestion < questions.count-1){
            btnFeedback.setTitle("Próxima", forState: UIControlState.Normal)
        }else{
            btnFeedback.setTitle("Ver nota", forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func btnFeedbackAction(sender: AnyObject) {
        viewFeedback.hidden = true
        
        if(quizEnded){
            startQuiz()
        }else{
            nextQuestion()
        }
    }
    
    func nextQuestion(){
        currentQuestion++
        
        if(currentQuestion < questions.count){
            showQuestion(currentQuestion)
        }else{
            endQuiz()
        }
    }
    
    func endQuiz(){
        grade = grade / Double(questions.count) * 100.0
        quizEnded = true
        viewFeedback.hidden = false
        lbFeedback.text = "Sua nota: \(grade)"
        btnFeedback.setTitle("Refazer", forState: UIControlState.Normal)
    }

}

