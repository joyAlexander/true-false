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
    var answerOption1: String = ""
    var answerOption2: String = ""
    var answerOption3: String = ""
    var answerOption4: String = ""
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // created new constraints that I will use to change the layout of the buttons when there is only 3 answer options
    
    @IBOutlet weak var option1CenterYconstraint: NSLayoutConstraint!
    @IBOutlet weak var option2CenterYconstraint: NSLayoutConstraint!
    @IBOutlet weak var option3CenterYconstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
        loadCorrectSound()
        loadWrongSound()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    /* function displayQuestion: 
     - it will choose a random question 
     - the question field will display the question 
     - each button will display an option in white and will have rounded borders
     - assigning the correctAnswer to a variable for later
     - if there are only 3 options I want the fourth option to be hidden and the layout of the three other option to change to fill the screen nicely
     - the timer runs as soon as the question is displayed
     - I also set the playAgainButton to rounded corners so that those properties are all in the same place.
     
     
 
 */

    
   func displayQuestion() {
    
        let triviaQuestion = randomQuestion()
        changeButtonColor(color: UIColor.white)
    
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
    
    if triviaQuestion.option4 != nil {
        option4Button.isHidden = false
       option1CenterYconstraint.isActive = false
        option2CenterYconstraint.isActive = false
        option3CenterYconstraint.isActive = false
    } else {
       option1CenterYconstraint.isActive = true
        option2CenterYconstraint.isActive = true
        option3CenterYconstraint.isActive = true
        option4Button.isHidden = true
      
    }
    
        playAgainButton.layer.cornerRadius = 10
        runTimer()
    }
    
/* function checkAnswer:
     - I want to remove the question from questionAsked
     - If the title of the button is the same than the correct answer, I want to add it to my correctQuestions, I want the answerField to show Correct, I want a sound, I want all other options to be grayed out and the correct one to remain white.
     - else if it wrong I want the questionField to display to show incorrect, a sound, the correct answer should appear white and the wrong ones grayed out
     - I also want to stop the timer
 
 */
    
    @IBAction func checkAnswer(_ sender: UIButton) {
  
     questionsAsked += 1
     let allButtons = [option1Button, option2Button, option3Button, option4Button]

        
        if (sender.titleLabel!.text == correctAnswer) {
            correctQuestions += 1
            answerField.isHidden = false
            answerField.text = "Correct!"
            AudioServicesPlaySystemSound(correctSound)
            changeButtonColor(color: UIColor.gray)
            sender.setTitleColor(UIColor.white, for: .normal)
        
            
        } else {
            answerField.isHidden = false
            answerField.text = "Sorry, that's not it!"
            AudioServicesPlaySystemSound(wrongSound)
            changeButtonColor(color: UIColor.gray)
            
            for button in allButtons {
                if button?.titleLabel!.text == correctAnswer {
                    button?.setTitleColor(UIColor.white, for: .normal)
                }
            }
        
           
        }
        
        timer.invalidate()
        seconds = 16
        loadNextRoundWithDelay(seconds: 2)
        timerLabel.text = ""
    }
    
    /* What I want changeButtonColor function to do: allows to change colors of the wrong and correct answers as viewed in the checkAnswer function
 
 */
    
    func changeButtonColor(color: UIColor) {
        option1Button.setTitleColor(color, for: .normal)
        option2Button.setTitleColor(color, for: .normal)
        option3Button.setTitleColor(color, for: .normal)
        option4Button.setTitleColor(color, for: .normal)
    }
    
/* function nextRound: checks how many questions were asked, if all the questions were asked display the score otherwise display the next question
 
 */
   
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            
        } else {
           
            // Continue game
            displayQuestion()
        }
    }
    
    
/* function play again: reloading the array, we should only see the playAgain button
 
 */
    
    @IBAction func playAgain() {
        
        allQuestions = originalQuestions
        
        option1Button.isHidden = false
        option2Button.isHidden = false
        option3Button.isHidden = false
        option4Button.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    
/*
function displayScore: all buttons should be hidden, the questionField should display a different message depending on how many questions were answered correctly.
 
 */
    
    func displayScore() {
        // Hide the answer buttons
        option1Button.isHidden = true
        option2Button.isHidden = true
        option3Button.isHidden = true
        option4Button.isHidden = true
        answerField.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        if correctQuestions <= 3 {
          questionField.text = "\(correctQuestions) out of \(questionsPerRound)! \n Will do better next time!"
    } else if correctQuestions > 3 {
          questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
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
    
    
    /*
 functions loadCorrectSound and loadWrongSound: using the sounds in the sounds folder it will load and gets played for a correctAnswer or wrongAnswer
 */
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
     
     function runTimer: loads the timer
 
 */
 
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
/*
function updateTimer: makes sure to update timer once the time is up, display it to the questionField and move on to the next question.
 
*/
    
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



