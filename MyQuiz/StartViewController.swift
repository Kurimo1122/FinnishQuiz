//
//  StartViewController.swift
//  MyQuiz
//
//  Created by Toshimitsu Kugimoto on 2016/12/17.
//  Copyright © 2016 Toshimitsu Kugimoto. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Prepare procedure before going into next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Read the Question sentence
        QuestionDataManager.sharedInstance.loadQuestion()
        
        // Call next View
        guard let nextViewController = segue.destination as? QuestionViewController else {
            // Terminate if cannot get the next view
            return
        }
        
        // Get Question 
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            return
        }
        
        // Set the question
        nextViewController.questionData = questionData
    }
    
    // function called when the view goes back to the title
    @IBAction func goToTitle(_ segue: UIStoryboardSegue){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
