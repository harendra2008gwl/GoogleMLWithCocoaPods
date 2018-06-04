//
//  ViewController.swift
//  GoogleMLWithCocoaPods
//
//  Created by Harendra Sharma on 02/06/18.
//  Copyright © 2018 Harendra Sharma. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

 
    @IBOutlet weak var objectImgView: UIImageView!
    
    @IBOutlet weak var ResultLbl: UILabel!
    
    var ImgIndex = 0 // Initial image index
    
    
    let Images = ["dog.jpg","fan.jpg","cat.jpg","elephant.jpg","apple.jpg", "ceilingfan.jpg", "chair.jpg"] // All pre-stored images
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func LookUp(_ sender: UIButton) {
   
        let vision = Vision.vision() // ML vision api instance this return object labels
        
        if ImgIndex >= Images.count { // avoid crashing if index goes to out of max count
            ImgIndex = 0
        }
        

        let imageName = Images[ImgIndex]
        ImgIndex += 1 // index for next image

        let img = UIImage(named: imageName)! // image from array
        self.objectImgView.image = img

        let labelDetectorObj = vision.labelDetector()
        let visionImageObj = VisionImage(image: img)

        labelDetectorObj.detect(in: visionImageObj) { (labels, error) in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            // This will check highest confidence label
            let predictionLabel = labels!.max { lhs, rhs in
                return lhs.confidence < rhs.confidence
            }

            for label in labels! {
                print("\(label.label) has confidence \(label.confidence)")
                self.ResultLbl.text = predictionLabel?.label
            }
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

