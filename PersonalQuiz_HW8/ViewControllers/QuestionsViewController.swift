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
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
            
        }
    }
    
    
    //MARK: = Private properties
    private let questions = Questions.getQuestions()
    private var questionIndex = 0
    private var answersChosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }

    //MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.results = answersChosen
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    //MARK: - IBActions
    @IBAction func singleAnswerButtonPresse(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)
        
        goToNextQuestion()
    }
    
    @IBAction func multipleAnswerButtenPressed() {
        for (multipleswitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleswitch.isOn {
                answersChosen.append(answer)
            }
        }
        goToNextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        
        goToNextQuestion()
    }
    
    
}

//MARK: - Navigation
extension QuestionsViewController {
    private func goToNextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}


//MARK: - Private Methods
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
        
        // Show stacks corresponding to question type
        showCurrentAnswer(for: currentQuestion.responseType)
        
    }
    
    private func showCurrentAnswer(for type: ResponseType) {
        switch type {
        case .single: showSingleStack(with: currentAnswers)
        case .multiple: showMultipleStack(with: currentAnswers)
        case .range: showRangedStach(with: currentAnswers)
        }
    }
    
    private func showSingleStack(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    private func showMultipleStack(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    private func showRangedStach(with answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.first?.title
    }
}

