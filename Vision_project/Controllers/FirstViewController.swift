//
//  ViewController.swift
//  Vision_project
//
//  Created by Жансая Шакуали on 08.06.2023.
//

import UIKit
import VisionKit
import AVFoundation


class FirstViewController: UIViewController {
    
    
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput?
    var capturedPhoto: UIImage?
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        buttonView.layer.cornerRadius = buttonView.frame.height / 2
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.clipsToBounds = true
        setupCamera()
    }
    
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        guard let captureSession = captureSession else {
            print("Failed to create capture session")
            return
        }
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Failed to access the camera")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
            photoOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddOutput(photoOutput!) {
                captureSession.addOutput(photoOutput!)
            }
        } catch {
            print("Error setting up camera input: \(error.localizedDescription)")
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = cameraView.layer.bounds
        cameraView.layer.addSublayer(previewLayer!)
        DispatchQueue.global(qos: .background).async{
            captureSession.startRunning()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondView" {
            if let destinationVC = segue.destination as? SecondViewController {
                destinationVC.photo = capturedPhoto
            }
        }
    }
    
    @IBAction func tappedPhoto(_ sender: UIButton) {
        guard let photoOutput = photoOutput else {
            print("Failed to capture photo, no photo output")
            return
            
        }
        let photoSettings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
}

extension FirstViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) {
            capturedPhoto = image
            performSegue(withIdentifier: "goToSecondView", sender: self)
        }
    }
}

