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

    let questionsPerRound = allQuestions.count
    var questionsAsked = 0
    var correctQuestions = 0
    var correctAnswer: String = ""
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    var seconds = 16
    var timer = Timer()
    
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // loadGameStartSound()
        // Start game
       // playGameStartSound()
        displayQuestion()
     //   loadCorrectSound()
     //   loadWrongSound()
       
    }
    
   /* override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 */

    
   func displayQuestion() {
    
       let triviaQuestion = randomQuestion()
        questionField.text = triviaQuestion.question
        correctAnswer = triviaQuestion.correctAnswer
    
        playAgainButton.isHidden = true
        answerField.isHidden = true
    
        option1Button.setTitle(triviaQuestion.option1, for: .normal)
        option2Button.setTitle(triviaQuestion.option2, for: .normal)
        option3Button.setTitle(triviaQuestion.option3, for: .normal)
        option4Button.setTitle(triviaQuestion.option4, for: .normal)
    
        option1Button.layer.cornerRadius = 10
        option2Button.layer.cornerRadius = 10
        option3Button.layer.cornerRadius = 10
        option4Button.layer.cornerRadius = 10
        playAgainButton.layer.cornerRadius = 10
    
    runTimer()

    
   
   
   
    }
    

    //Should be named like 'questionsButtonsTapped'
    //#1
    
    @IBAction func checkAnswer(_ sender: UIButton) {
  
     questionsAsked += 1
     
        if (sender.titleLabel!.text == correctAnswer) {
            correctQuestions += 1
            answerField.isHidden = false
            answerField.text = "Correct!"
            AudioServicesPlaySystemSound(correctSound)
        
            // sound
            
        } else {
            answerField.isHidden = false
            answerField.text = "Sorry, that's not it!"
            AudioServicesPlaySystemSound(wrongSound)
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            
        } else {
           
            // Continue game
            displayQuestion()
        }
    }
    
    //#2 When should this get called.
    @IBAction func playAgain() {
        //TO DO: Reload array
        //1. make immutable version DONE
        //2. each new round, assign values to mutable from clean immutable array.
        //The purpose of this is to put questions back in the array.
        allQuestions = originalQuestions
        
        // Show the answer buttons

       
        option1Button.isHidden = false
        option2Button.isHidden = false
        option3Button.isHidden = false
        option4Button.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    
    func displayScore() {
        // Hide the answer buttons
        option1Button.isHidden = true
        option2Button.isHidden = true
        option3Button.isHidden = true
        option4Button.isHidden = true
        answerField.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
  
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
 
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func loadCorrectSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "CorrectAnswer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctSound)

    }
    
    func loadWrongSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "WrongAnswer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongSound)
    
    }
 /*
    func time (time: Timer) {
        if seconds <= 0 {
            timer.invalidate()
            questionField.text = " TIME IS UP!"
            loadWrongSound()
            
        } else {
        seconds -= 1
        }
    }
*/
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        
        if seconds <= 0 {
            timer.invalidate()
            questionField.text = " TIME IS UP!"
            loadWrongSound()
            questionsAsked += 1
            seconds = 16
            loadNextRoundWithDelay(seconds: 2)
            timerLabel.text = ""
        } else {
        
        seconds -= 1
        timerLabel.text = "\(seconds)"
        }

    }
    

}



