//
//  ThirdViewController.swift
//  Vision_project
//
//  Created by Жансая Шакуали on 13.06.2023.
//

import UIKit
import Vision
import CoreML

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    var recognizedText = ""
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        recognizeTextOnImage(image)
        detailsLabel.text = recognizedText
        
        // Do any additional setup after loading the view.
    }
    
    func recognizeTextOnImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else {
            print("Failed to convert UIImage to CGImage")
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest { (request, error) in
            if let error = error {
                print("Text recognition error: \(error.localizedDescription)")
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("Failed to get text recognition")
                return
            }
            
            
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                self.recognizedText += topCandidate.string + "\n"
            }
            
            print("Recognized text:\n\(self.recognizedText)")
            
            
        }
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Text recognition request failed: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func reshootButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
