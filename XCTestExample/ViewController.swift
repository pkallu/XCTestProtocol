//
//  ViewController.swift
//  XCTestExample
//
//  Created by Pragathi Kallu on 10/10/19.
//  Copyright © 2019 Pragathi Kallu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonShare: UIBarButtonItem!
    @IBOutlet weak var imageToShare: UIImageView!
    @IBOutlet weak var segmentedControlColor: UISegmentedControl!
    
    @IBAction func shareTapped(_ sender: Any) {
        if let image = imageToShare.image {
        var imageToShare = image
            if segmentedControlColor.selectedSegmentIndex == 1 {
                guard let currentCGImage = image.cgImage else { return }
                let currentCIImage = CIImage(cgImage: currentCGImage)

                let filter = CIFilter(name: "CIColorMonochrome")
                filter?.setValue(currentCIImage, forKey: "inputImage")

                           // set a gray value for the tint color
                filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")

                filter?.setValue(1.0, forKey: "inputIntensity")
                guard let outputImage = filter?.outputImage else { return }

                let context = CIContext()

                if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    imageToShare = processedImage
                }
            }
           
            let vc = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
            present(vc, animated: true)
        }
    }
    //MARK -- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

