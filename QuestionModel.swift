//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Derik Linch on 10/11/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import GameKit

struct QuestionModel {
    var trivia: [[String: String]] = [
        ["Question": "This was the only US President to serve more than two consecutive terms.", "Option 1": "George Washington", "Option 2": "Franklin D. Roosevelt", "Option 3": "Woodrow Wilson", "Option 4": "Andrew Jackson", "Answer": "Option 2"],
        
        ["Question": "Which of the following countries has the most residents?", "Option 1": "Nigeria", "Option 2": "Russia", "Option 3": "Iran", "Option 4": "Vietnam", "Answer": "Option 1"],
        
        ["Question": "In what year was the United Nations founded?", "Option 1": "1918", "Option 2": "1919", "Option 3": "1945", "Option 4": "1954", "Answer": "Option 3"],
        
        ["Question": "The Titanic departed from the United Kingdom, where was it supposed to arrive?", "Option 1": "Paris", "Option 2": "Washington D.C.", "Option 3": "New York City", "Option 4": "Boston", "Answer": "Option 3"],
        
        ["Question": "Which nation produces the most oil?", "Option 1": "Iran", "Option 2": "Iraq", "Option 3": "Brazil", "Option 4": "Canada", "Answer": "Option 4"],
        
        ["Question": "Which country has most recently won consecutive World Cups in Soccer?", "Option 1": "Italy", "Option 2": "Brazil", "Option 3": "Argentina", "Option 4": "Spain", "Answer": "Option 2"],
        
        ["Question": "Which of the following rivers is longest?", "Option 1": "Yangtze", "Option 2": "Mississippi", "Option 3": "Congo", "Option 4": "Mekong", "Answer": "Option 2"],
        
        ["Question": "Which city is the oldest?", "Option 1": "Mexico City", "Option 2": "Cape Town", "Option 3": "San Juan", "Option 4": "Sydney", "Answer": "Option 1"],
        
        ["Question": "Which country was the first to allow women to vote in national elections?", "Option 1": "Poland", "Option 2": "United States", "Option 3": "Sweden", "Option 4": "Senegal", "Answer": "Option 1"],
        
        ["Question": "Which of these countries won the most medals in the 2012 Summer Games?", "Option 1": "France", "Option 2": "Germany", "Option 3": "Japan", "Option 4": "Great Britain", "Answer": "Option 4"]
    ]
    
    func getRandomQuestionIndex() -> Int {
        return GKRandomSource.sharedRandom().nextIntWithUpperBound(trivia.count)
    }
    
    mutating func popQuestion(index: Int) -> Void {
        trivia.removeAtIndex(index)
    }
}