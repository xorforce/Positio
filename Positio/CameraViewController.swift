//
//  CameraViewController.swift
//  Positio
//
//  Created by Bhagat Singh on 2/11/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import UIKit
import AVFoundation


class CameraViewController: UIViewController {

    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var session : AVCaptureSession?
    var stillImageOutput : AVCapturePhotoOutput?
    var videoPreviewPlayer : AVCaptureVideoPreviewLayer?
    var error : NSError?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var input : AVCaptureDeviceInput!
        do{
            input = try AVCaptureDeviceInput(device: backCamera)
        }catch let error1 as NSError{
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session!.canAddInput(input){
            session!.addInput(input)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTakePhoto(_ sender: Any) {
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
