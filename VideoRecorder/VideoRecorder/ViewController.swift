//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Paul Solt on 10/2/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// TODO: get permission
		
		showCamera()
        requestPermission()
		
	}
	
	private func showCamera() {
		performSegue(withIdentifier: "ShowCamera", sender: self)
	}
    
    private func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { (isGranted) in
            guard isGranted else { return }
            preconditionFailure("UI: Tell")
            DispatchQueue.main.async {
                self.showCamera()
            }
        }
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            preconditionFailure("User did not give or deny permission. Not determined.")
        case .denied:
            preconditionFailure("User denied using the camera")
        case .authorized:
            showCamera()
            
        case .restricted:
            preconditionFailure("Unable to use camera because of restriction")
        default:
            preconditionFailure("Tell the user they can't use the app unless they give permission use the camera")
        }
    }
}
