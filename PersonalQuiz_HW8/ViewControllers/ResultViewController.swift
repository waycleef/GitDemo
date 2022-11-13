//
//  ResultViewController.swift
//  PersonalQuiz_HW8
//
//  Created by Алишер Маликов on 12.11.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    // 1. Избавиться от кнопки возврата назад на экране результатов
    // 2. Передать массив с ответами на экран с результатами
    // 3. Определить наиболее часто встречающийся тип животного
    // 4. Отобразить результаты в соответствии с этим животным
    
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!
    // использовать функции высшего порядка map и sorted
    // отдельный метод для поиска результата
    var results: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        
        calculateResult()
        
    }
    
    

    @IBAction func doneButtenPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
        
    }
    

}

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
