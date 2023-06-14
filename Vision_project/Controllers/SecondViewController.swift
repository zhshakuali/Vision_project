//
//  SecondViewController.swift
//  Vision_project
//
//  Created by Жансая Шакуали on 09.06.2023.
//

import UIKit
import VisionKit
import AVFoundation

class SecondViewController: UIViewController {
    
    var photo: UIImage?
    
    @IBOutlet weak var takenPasportPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takenPasportPhoto.image = photo
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func reshootPhotoButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToThirdVC" {
            if let destinationVC = segue.destination as? ThirdViewController{
                destinationVC.image = photo!
            }
            
        }
    }
    
    @IBAction func usePhotoButton(_ sender: Any) {
        performSegue(withIdentifier: "GoToThirdVC", sender: self)
    }
}

