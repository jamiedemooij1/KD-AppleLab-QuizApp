//
//  ViewController.swift
//  WGZ
//
//  Created by SD on 04/04/2022.
//

import UIKit
enum Mode{
    case red
    case yellow
    case green
    case blue
    case orange
}

enum State{
    case question
    case answer
    case score
}

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var checkAnswer: UIButton!
    @IBOutlet weak var nextQuestion: UIButton!
    @IBOutlet weak var redQuestions: UIButton!
    @IBOutlet weak var yellowQuestions: UIButton!
    @IBOutlet weak var greenQuestions: UIButton!
    @IBOutlet weak var blueQuestions: UIButton!
    @IBOutlet weak var orangeQuestions: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    
    var quizQuestions: [QuizQuestion] = []
    var categoryQuestions: [QuizQuestion] = []
    var answerIsCorrect = false
    var correctAnswers = 0
    var correctAnswer = ""
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupQuiz()
    }

    @IBAction func red(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .red }
        redQuestions.isHidden = false
        blueQuestions.isHidden = true
        yellowQuestions.isHidden = true
        orangeQuestions.isHidden = true
        greenQuestions.isHidden = true
        let question = categoryQuestions[currentQuestionIndex]
        questionLabel.text = question.question
        correctAnswer = question.answer
        
    }
    
    @IBAction func yellow(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .yellow }
        redQuestions.isHidden = true
        blueQuestions.isHidden = true
        yellowQuestions.isHidden = false
        orangeQuestions.isHidden = true
        greenQuestions.isHidden = true
        let question = categoryQuestions[currentQuestionIndex]
        questionLabel.text = question.question
        correctAnswer = question.answer
        
    }
    
    @IBAction func green(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .green }
        redQuestions.isHidden = true
        blueQuestions.isHidden = true
        yellowQuestions.isHidden = true
        orangeQuestions.isHidden = true
        greenQuestions.isHidden = false
        let question = categoryQuestions[currentQuestionIndex]
        questionLabel.text = question.question
        correctAnswer = question.answer
        
    }
    
    @IBAction func blue(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .blue }
        redQuestions.isHidden = true
        blueQuestions.isHidden = false
        yellowQuestions.isHidden = true
        orangeQuestions.isHidden = true
        greenQuestions.isHidden = true
        let question = categoryQuestions[currentQuestionIndex]
        questionLabel.text = question.question
        correctAnswer = question.answer
        
    }
    
    @IBAction func orange(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .orange }
        redQuestions.isHidden = true
        blueQuestions.isHidden = true
        yellowQuestions.isHidden = true
        orangeQuestions.isHidden = false
        greenQuestions.isHidden = true
        let question = categoryQuestions[currentQuestionIndex]
        questionLabel.text = question.question
        correctAnswer = question.answer
        
    }
    
    @IBAction func checkAnswer(_ sender: Any) {
        let textFieldContents = textField.text!
        if (textFieldContents.lowercased() == correctAnswer){
            correctAnswers += 1
            questionLabel.text = "Correct!"
            textField.isEnabled = false
            textField.text = ""
        } else {
            questionLabel.text = "Incorrect! The correct answer was \(correctAnswer)"
           textField.isEnabled = false
            textField.text = ""
        }
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        currentQuestionIndex += 1
        questionLabel.text = ""
        textField.isEnabled = true
        let question = categoryQuestions[currentQuestionIndex]
        questionLabel.text = question.question
        correctAnswer = question.answer
    }
    
    func setupQuiz() {
        getLocalQuizData()
        
        //print("The quiz questions are: \(quizQuestions)")
    }
    
    func getLocalQuizData() {
        // Call readLocalFile function with the name of the local file (localQuizData)
        if let localData = self.readLocalFile(forName: "localQuizData") {
            // File exists, now parse 'localData' with the parse function
            self.parse(jsonData: localData)
        }
    }

    // Read local file

    private func readLocalFile(forName name: String) -> Data? {
        do {
            // Check if file exists in application bundle, then try to convert it to a string, if that works return that
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error) // Something went wrong, show an alert
        }
        
        return nil
    }

    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([QuizQuestion].self,
                                                       from: jsonData)
            /*
            print("Question: ", decodedData[0].question)
            print("Answer: ", decodedData[0].answer)
            print("===================================")
            */
            
            self.quizQuestions = decodedData
        } catch {
            print("decode error")
        }
    }
}

