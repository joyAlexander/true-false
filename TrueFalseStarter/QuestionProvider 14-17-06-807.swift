//
//  QuestionProvider.swift
//  TrueFalseStarter
//
//  Created by Joy Ferguson on 6/21/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameKit


// creating a struct to have a blueprint of the values I need for one question : the question, possible answers and correct answer.
struct triviaQuestion {
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let correctAnswer: String
    
}



// as per the instructions, generating a random number so that questions are asked randomly

let question1 = triviaQuestion(
    question: "How old is Sunday?",
    option1: "6 month",
    option2: "1",
    option3: "2",
    option4: "3",
    correctAnswer: "3")

let question2 = triviaQuestion(
    question: "Where did I get Sunday?",
    option1: "Penn",
    option2: "NY",
    option3: "Paris",
    option4: "LA",
    correctAnswer: "Penn")

let question3 = triviaQuestion(
    question: "What is my dog's name?",
    option1: "Waffle",
    option2: "Ginger",
    option3: "Sunday",
    option4: "Ghost",
    correctAnswer: "Sunday")

let question4 = triviaQuestion(
    question: "Where does Sunday go to the park?",
    option1: "Tompkins Park",
    option2: "McCarren Park",
    option3: "Central Park",
    option4: "",
    correctAnswer: "Central Park"
)

let question5 = triviaQuestion(
    question: "Who gives treats to Sunday?",
    option1: "Joy",
    option2: "Alix",
    option3: "Eric",
    option4: "",
    correctAnswer: "Alix")



// putting all the questions in an array that I will use to generate a random number.

let originalQuestions: [triviaQuestion] = [question1, question2, question3, question4, question5]


var allQuestions = originalQuestions


// function for questions to appear randomly

func randomQuestion() -> (triviaQuestion) {
    let randomInt = GKRandomSource.sharedRandom().nextInt(upperBound: allQuestions.count)
    
    
    //1. Assign chosen question to new variable. var chosenQ = allQuestions[randomInt]
    let chosenQ = allQuestions[randomInt]
    
    //2. Remove the question at that particular point in the array.
   allQuestions.remove(at: randomInt)
    
  
    
//    return allQuestions[3] //New variable name.
    return chosenQ
}
 
 



