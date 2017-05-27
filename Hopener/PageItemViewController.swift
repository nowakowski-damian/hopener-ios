//
//  PageItemViewController.swift
//  Hopener
//
//  Created by Damian Nowakowski on 08/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import UIKit

class PageItemViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var imageName:String?
    var labelName:String?
    var gradientColors:[UIColor]?
    var cornersToRound:UIRectCorner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: imageName!)?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.black
        label.text = labelName

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let corners = cornersToRound {
            self.view.roundCorners(corners, radius: 20)
        }
        if let gradients = gradientColors {
            self.view.applyGradient(colorStart: gradients[0], colorCenter: gradients[1], colorEnd: gradients[2])
        }
    }

    
}
