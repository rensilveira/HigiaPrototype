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

// MARK: - Enums

enum Category: String {
    case yes = "Yes"
    case no = "No"
    case nothing = "Nothing"
}

enum Sound: String {
    case yes = "loreum1"
    case no = "loreum2"
}

class ResultViewController: UIViewController, AVAudioPlayerDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet var productView: UIView!
    @IBOutlet weak var feedbackImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    // MARK: - Public properties
    
    var productID: String!
    
    // MARK: - Private properties
    
    var audioPlayer : AVAudioPlayer?

    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        dismissAlert(delay: 1)
        
        print(productID)
    }
    
    // MARK: - Private functions
    
    private func dismissAlert(delay: Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(delay)) {
            self.dismiss(animated: true)
            self.performSegue(withIdentifier: "unwindToScanningWithUnwindSegue", sender: self)
        }
    }
    
    private func setupScreen() {
        productView.layer.cornerRadius = 10
        productView.layer.masksToBounds = true
        
        guard let answer = productID else { return }
        
        if answer == Category.yes.rawValue {
            feedbackImage.image = UIImage(named: "Yes.pdf")
            playSound(fileName: Category.yes.rawValue)
        } else if answer == Category.no.rawValue {
            feedbackImage.image = UIImage(named: "No.pdf")
            playSound(fileName: Category.yes.rawValue)
        }
    }
    
    private func playSound(fileName: String) {
        if let pathResource = Bundle.main.path(forResource: "Yes", ofType: "mp3") {
            let finishedStepSound = NSURL(fileURLWithPath: pathResource)
            audioPlayer = AVAudioPlayer()
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: finishedStepSound as URL)
                if audioPlayer!.prepareToPlay() {
                    audioPlayer!.delegate = self
                    if audioPlayer!.play() {
                    } else {
                        print("Sound file could not be played")
                    }
                } else {
                    print("preparation failure")
                }
            } catch {
                print("Sound file could not be found")
            }
        } else {
            print("path not found")
        }
    }
}

