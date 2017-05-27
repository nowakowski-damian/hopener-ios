//
//  NotificationView.swift
//  Hopener
//
//  Created by Damian Nowakowski on 22/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import UIKit

class NotificationView: UIView {

    public static let nibName = "NotificationView"
    @IBOutlet weak var label: UILabel!
    
    func setMessage( _ message:String, inColor color:UIColor ) {
        label.text = message
        label.textColor = color
    }

}
