//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by Toshimitsu Kugimoto on 2016/12/17.
//  Copyright © 2016 Toshimitsu Kugimoto. All rights reserved.
//

import Foundation

class QuestionData{
    
    // Question sentense
    var question: String
    
    // Answer Options
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    
    // Correct Answer number
    var correctAnswerNumber: Int

    // Answer number the user chose
    var userChoiceAnswerNumber: Int?
    
    // Question Number
    var questionNo: Int = 0
    
    
    // Initializer
    init(questionSourceDataArray: [String]){
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    
    // If the answer user chose is correct or not
    func isCorrect() -> Bool {
        // Judge if the answer is correct or not
        if correctAnswerNumber == userChoiceAnswerNumber{
            // Correct
            return true
        } else {
            // Incorrect
            return false
        }
    }
}


class QuestionDataManager{
    // Singleton Object
    static let sharedInstance = QuestionDataManager()
    
    // Manage the question
    var questionDataArray = [QuestionData]()
    
    // Question Index
    var nowQuestionIndex: Int = 0
    
    // Initializer
    private init() {
        // state as private to make sure this is a singleton
    }
    
    // Load Question
    func loadQuestion(){
        // Delete the question sentence if it is there already
        questionDataArray.removeAll()
        
        // Initialize the question index
        nowQuestionIndex = 0
        
        // Get the csv file path
        guard let csvFilePath = Bundle.main.path(forResource: "question",
                                                 ofType: "csv") else {
                                                    print("csv file does not exist!")
                                                    return
        }
        
        // Read the csv file
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            
            // read the csv data one by one
            csvStringData.enumerateLines(invoking: { (line, stop) in
                // Separate the line by comma
                let questionSourceDataArray = line.components(separatedBy: ",")
                
                // Generate the object which gets the question data
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                
                // Add the question to the array
                self.questionDataArray.append(questionData)
                
                // Set question number
                questionData.questionNo = self.questionDataArray.count
            })
        } catch let error {
            print("cannnot read the csv file :\(error)")
            return
        }
    }
    
    // Get next question
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
}
