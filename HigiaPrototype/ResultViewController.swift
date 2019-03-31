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
import AVFoundation

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

class ResultViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var productView: UIView!
    @IBOutlet weak var feedbackImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    // MARK: - Public properties
    
    var productID: String!
    
    // MARK: - Private properties
    
    var player: AVAudioPlayer?
    
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
            playSound(fileName: Sound.yes.rawValue)
        } else if answer == Category.no.rawValue {
            feedbackImage.image = UIImage(named: "No.pdf")
            playSound(fileName: Sound.no.rawValue)
        }
    }
    
    private func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

