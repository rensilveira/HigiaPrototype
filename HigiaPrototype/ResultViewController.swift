//
//  ResultViewController.swift
//  HigiaPrototype
//
//  Created by Renan Silveira on 30/03/2019.
//  Copyright © 2019 Renan Silveira. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class ResultViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var productView: UIView!
    @IBOutlet weak var productPhoto: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    // MARK: - Public properties
    
    var productID: String!
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        dismissAlert(delay: 5)
        
        print(productID)
    }
    
    // MARK: - Private functions
    
    private func dismissAlert(delay: Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(delay)) {
            self.dismiss(animated: true) { }
            print("Dismissed")
            self.performSegue(withIdentifier: "unwindToScanningWithUnwindSegue", sender: self)
        }
    }
    
    private func setupScreen() {
        productView.layer.cornerRadius = 10
        productView.layer.masksToBounds = true
        
        if let answer = productID, answer == "Passou" {
            descriptionText.text = "Yes"
        } else {
            descriptionText.text = "No"
        }
        // TODO: Set feedback image
    }
}

