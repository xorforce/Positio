//
//  ViewController.swift
//  Positio
//
//  Created by Bhagat Singh on 2/11/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var timer : Timer!
    
    var first : String = ""
    var second : String = ""
    
    var count : Int = 0
    
    var status : String = ""
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.image = UIImage(named: "Standing")
        topLabel.textColor = UIColor(red: 0.0/255.0, green: 230.0/255.0, blue: 118.0/255.0, alpha: 1.0)
        middleLabel.textColor = UIColor(red: 0.0/255.0, green: 230.0/255.0, blue: 118.0/255.0, alpha: 1.0)
        
        run()
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { (timer) in
            self.run()
            self.setupViews()
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerDidSelectNewDate(_ sender: UIDatePicker) {
        
        let selectedDate = sender.date
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.scheduleNotifications(at: selectedDate)
        
    }
    
    func setupViews(){
        imageView.image = UIImage(named: status)
    }
    
    func run(){
        print("count = \(count)")
        count = count + 1
        Alamofire.request("http://akshaybaweja.com/positio/index.php?os=ios&request=get", method: .get).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let ultra1 = dict["ultra1"] as? String{
                    self.first = ultra1
                }
                if let ultra2 = dict["ultra2"] as? String{
                    self.second = ultra2
                    
                }
            }
            
        }
        
        if first == "0" && second == "0"{
            status = "Standing"
            imageView.image = UIImage(named: status)
            }
        
        if first == "1" && second == "1"{
            status = "correct"
            imageView.image = UIImage(named: status)
        }
        
        if ((first == "1" && second == "0") || (first == "0" && second == "1")){
            status = "incorrect"
            imageView.image = UIImage(named: "incorrect")
        }
        
        
    }

}

