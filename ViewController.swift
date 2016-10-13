//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    var questionsPerRound = 0
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    let gray = UIColor(red: 169/255.0, green: 169/255.0, blue: 169/255.0, alpha: 1.0) //gray color
    let white = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) //white color

    
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 1
    var incorrectSound: SystemSoundID = 2
    var trivia = QuestionModel()
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var outcomeText: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        outcomeText.textAlignment = .Center;
        loadGameStartSound()
        loadQuestionCorrectSound()
        loadQuestionWrongSound()
        questionsPerRound = trivia.trivia.count
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        indexOfSelectedQuestion = trivia.getRandomQuestionIndex()
        let questionDictionary = trivia.trivia[indexOfSelectedQuestion]
        questionField.text = questionDictionary["Question"]
        option1.setTitle(questionDictionary["Option 1"], forState: .Normal)
        option2.setTitle(questionDictionary["Option 2"], forState: .Normal)
        option3.setTitle(questionDictionary["Option 3"], forState: .Normal)
        option4.setTitle(questionDictionary["Option 4"], forState: .Normal)
        playAgainButton.hidden = true
        outcomeText.hidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        option1.hidden = true
        option2.hidden = true
        option3.hidden = true
        option4.hidden = true
        outcomeText.hidden = true
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = trivia.trivia[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict["Answer"]
        
        switch sender {
        case option1:
            option2.setTitleColor(gray, forState: .Normal)
            option3.setTitleColor(gray, forState: .Normal)
            option4.setTitleColor(gray, forState: .Normal)
            if correctAnswer == "Option 1" {
                playCorrectSound()
                correctQuestions += 1
                outcomeText.text = "Correct!"
                outcomeText.textColor = UIColor.greenColor()
            } else {
                playIncorrectSound()
                outcomeText.text = "Sorry, wrong answer!"
                outcomeText.textColor = UIColor.orangeColor()
            }
        case option2:
            option1.setTitleColor(gray, forState: .Normal)
            option3.setTitleColor(gray, forState: .Normal)
            option4.setTitleColor(gray, forState: .Normal)
            if correctAnswer == "Option 2" {
                playCorrectSound()
                correctQuestions += 1
                outcomeText.text = "Correct!"
                outcomeText.textColor = UIColor.greenColor()
            } else {
                playIncorrectSound()
                outcomeText.text = "Sorry, wrong answer!"
                outcomeText.textColor = UIColor.orangeColor()
            }
        case option3:
            option1.setTitleColor(gray, forState: .Normal)
            option2.setTitleColor(gray, forState: .Normal)
            option4.setTitleColor(gray, forState: .Normal)
            if correctAnswer == "Option 3" {
                playCorrectSound()
                correctQuestions += 1
                outcomeText.text = "Correct!"
                outcomeText.textColor = UIColor.greenColor()
            } else {
                playIncorrectSound()
                outcomeText.text = "Sorry, wrong answer!"
                outcomeText.textColor = UIColor.orangeColor()
            }
        default:
            option1.setTitleColor(gray, forState: .Normal)
            option2.setTitleColor(gray, forState: .Normal)
            option3.setTitleColor(gray, forState: .Normal)
            if correctAnswer == "Option 4" {
                playCorrectSound()
                correctQuestions += 1
                outcomeText.text = "Correct!"
                outcomeText.textColor = UIColor.greenColor()
            } else {
                playIncorrectSound()
                outcomeText.text = "Sorry, wrong answer!"
                outcomeText.textColor = UIColor.orangeColor()
            }
        }
        outcomeText.hidden = false
        trivia.popQuestion(indexOfSelectedQuestion)
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            outcomeText.hidden = true
            option1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            option2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            option3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            option4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        option1.hidden = false
        option2.hidden = false
        option3.hidden = false
        option4.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        trivia = QuestionModel()
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func loadQuestionCorrectSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("ting", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &correctSound)
    }
    
    func loadQuestionWrongSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("buzzer", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &incorrectSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    func playIncorrectSound() {
        AudioServicesPlaySystemSound(incorrectSound)
    }
}

