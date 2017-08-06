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
    let option4: String?
    let correctAnswer: String
}

// as per the instructions, generating a random number so that questions are asked randomly

let question1 = triviaQuestion(
    question: "What does the carat of a diamond refer to?",
    option1: "size",
    option2: "weight",
    option3: "color",
    option4: "clarity",
    correctAnswer: "weight")

let question2 = triviaQuestion(
    question: "What is the ideal diamond color?",
    option1: "yellow",
    option2: "white",
    option3: "clear",
    option4: nil,
    correctAnswer: "clear")

let question3 = triviaQuestion(
    question: "Which metal is the most precious?",
    option1: "Platinum",
    option2: "Silver",
    option3: "10k Gold",
    option4: "14k Gold",
    correctAnswer: "Platinum")

let question4 = triviaQuestion(
    question: "What is a popular diamond alternative?",
    option1: "Cubic Zirconia",
    option2: "Swarosvky crystals",
    option3: "Rhinestones",
    option4: nil,
    correctAnswer: "Cubic Zirconia"
)

let question5 = triviaQuestion(
    question: "What is the symbolism behind a 3 stone engagement ring?",
    option1: "bride, groom, future children",
    option2: "past, present, future",
    option3: "nothing",
    option4: nil,
    correctAnswer: "past, present, future")

let question6 = triviaQuestion(
    question: "What is the classic engagement ring style you can't go wrong with?",
    option1: "cushion cut on rose gold",
    option2: "simple gold band",
    option3: "round solitaire on a gold band",
    option4: "oval diamond with princess cut side stones",
    correctAnswer: "round solitaire on a gold band"
)



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
 
 



