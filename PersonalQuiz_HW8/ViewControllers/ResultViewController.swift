//
//  ResultViewController.swift
//  PersonalQuiz_HW8
//
//  Created by Алишер Маликов on 12.11.2022.
//

import UIKit

class ResultViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!

    //MARK: - Properties
    var results: [Answer]!

    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        
        calculateResult()
        
    }
    
    
    //MARK: - IBActions
    @IBAction func doneButtenPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
        
    }
    

}


//MARK: - Private Methods
extension ResultViewController {
    private func calculateResult() {
        var frequencyOfAnswer: [Animal: Int] = [:]
        let answerType = results.map{ $0.animal }
        
        for type in answerType {
            frequencyOfAnswer[type] = (frequencyOfAnswer[type] ?? 0) + 1
        }
        
        let frequentAnswerSorted = frequencyOfAnswer.sorted(by:
                                                        {(pair1, pair2) -> Bool in
                                                        return pair1.value < pair2.value
                                                        })
        
        let mostCommonAnswer = frequentAnswerSorted.first?.key
        
        resultAnswerLabel.text = "Вы - \(mostCommonAnswer?.rawValue ?? "?")"
        resultDefinitionLabel.text = mostCommonAnswer?.definition
        
    }
}
