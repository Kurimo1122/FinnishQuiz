//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by Toshimitsu Kugimoto on 2016/12/17.
//  Copyright © 2016 Toshimitsu Kugimoto. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {
    
    var questionData: QuestionData!
    
    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var incorrectImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubview(toFront: correctImageView)
        self.view.bringSubview(toFront: incorrectImageView)

        // Do any additional setup after loading the view.
        
        // Set Initialized Data
        questionNoLabel.text = "Q.\(questionData.questionNo)"
        questionTextView.text = questionData.question
        answer1Button.setTitle(questionData.answer1, for: UIControlState.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControlState.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControlState.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControlState.normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 1
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 2
        goNextQuestionWithAnimation()
    }
    
    
    
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 3
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 4
        goNextQuestionWithAnimation()
    }
    
    
    
    // Got next question with animation
    func goNextQuestionWithAnimation() {
        // if question is correct or not
        if questionData.isCorrect() {
            // go to next quesiton view with animation
            goNextQuestionWithCorrectAnimation()
        } else {
            goNextQuestionWithIncorrectAnimation()
        }
    }
    
    func goNextQuestionWithCorrectAnimation(){
        // Play allert sound
        AudioServicesPlayAlertSound(1025)
        
        // Animation
        UIView.animate(withDuration: 2.0, animations: {
            // Change alpha value from 0 to 1.0
            self.correctImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion() // got next question after animation is completed
        }
    }
    
    func goNextQuestionWithIncorrectAnimation(){
        // Play allert sound
        AudioServicesPlayAlertSound(1006)
        
        // Animation
        UIView.animate(withDuration: 2.0, animations: {
            // Change alpha value from 0 to 1.0
            self.incorrectImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion() // got next question after animation is completed
        }
    }
    
    func goNextQuestion() {
        // get question data
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
            // go to result view if the question does not exist any more
            // Generate ViewController by using the value defined in Identifier in Storyboard
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                // procedure of goint into next view without using Segue in Storyboard
                present(resultViewController, animated: true, completion: nil)
            }
            return
        }
        
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController {
            nextQuestionViewController.questionData = nextQuestion
            present(nextQuestionViewController, animated: true, completion: nil)
        }
    }
}
