//
//  ViewController.swift
//  PersonalQuiz_HW8
//
//  Created by Алишер Маликов on 11.11.2022.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider!
    
    
    //MARK: = Private properties
    private let questions = Questions.getQuestions()
    private var questionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    //MARK: - IBActions
    @IBAction func singleAnswerButtonPresse(_ sender: UIButton) {
    }
    
    @IBAction func multipleAnswerButtenPressed() {
    }
    
    @IBAction func rangedAnswerButtonPressed() {
    }
    
    
}

extension QuestionsViewController {
    private func updateUI() {
        // Hide stacks
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        // Get Current question
        let currentQuestion = questions[questionIndex]
        
        // Set current question for question label
        questionLabel.text = currentQuestion.tittle
        
        // Calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // Set progress for questionProgressView
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // Set navigation title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
    }
}

