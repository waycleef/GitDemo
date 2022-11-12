//
//  ResultViewController.swift
//  PersonalQuiz_HW8
//
//  Created by Алишер Маликов on 12.11.2022.
//

import UIKit

class ResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func doneButtenPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
        
    }
    
    deinit{
        print("ResultVC has been delocated")
    }
}
