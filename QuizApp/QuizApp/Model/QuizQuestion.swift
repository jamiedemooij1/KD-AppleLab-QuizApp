//
//  QuizQuestion.swift
//  QuizApp
//
//  Created by SD on 21/03/2022.
//

import Foundation

struct QuizQuestion: Codable {
    var category: QuizCategory
    var qaNumber: Int
    var question: String
    var answer: String
}

enum QuizCategory: String, Codable {
    case red
    case green
    case blue
    case yellow
}

