//
//  ViewController.swift
//  Hopener
//
//  Created by Damian Nowakowski on 07/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    public static let stroyboardId = "mainControlViewController"

    @IBOutlet var openButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var uuid:String?
    var currentDevice = Request.Device.fence
    var notificationView:NotificationView!
    var isNotificationAnimating = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeButtons();
        if let controller = self.childViewControllers.first as? PagerViewController {
            controller.pageDelegate = self
        }
        prepareNotificationView()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func prepareNotificationView() {
        let nib = UINib(nibName: NotificationView.nibName, bundle: nil)
        notificationView = nib.instantiate(withOwner: self, options: nil).first as! NotificationView
//        notificationView?.bounds = view.bounds
        let parentSize = view.frame.size
        notificationView.frame.size.width = parentSize.width
        notificationView.frame.size.height = parentSize.height/6
        notificationView.frame.origin = CGPoint(x: 0, y: -notificationView.frame.size.height)
        view.addSubview(notificationView)
    }
    
    private func showNotification(_ message:String, inColor color:UIColor) {
        notificationView.setMessage(message, inColor: color)
        guard !isNotificationAnimating else {
            return
        }
        isNotificationAnimating = true
        UIView.animate(withDuration: 0.5, animations: {
            self.notificationView.frame.origin.y = 0
        }, completion: { finished in
            UIView.animate(withDuration: 1.5, delay: 1, animations: {
                self.notificationView.frame.origin.y = -self.notificationView.frame.size.height
            }, completion: { finished in
                self.isNotificationAnimating = false
            })
        })
    }
    
    @IBAction func onOpen(_ sender: UIButton) {
        makeRequest(activity: .open)
    }
    
    @IBAction func onPause(_ sender: UIButton) {
        makeRequest(activity: .pause)
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        makeRequest(activity: .close)
    }
    
    private func customizeButtons() {
        openButton.layer.cornerRadius = 10
        openButton.applyGradient(colorStart: UIColor.rgb(56,142,60), colorCenter: UIColor.rgb(46,125,50), colorEnd: UIColor.rgb(27,94,32), type: .vertical, cornerRadius: 10 )
        pauseButton.layer.cornerRadius = 10
        pauseButton.applyGradient(colorStart: UIColor.rgb(175,180,43), colorCenter: UIColor.rgb(158,157,36), colorEnd: UIColor.rgb(130,119,23), type: .vertical, cornerRadius: 10   )
        closeButton.layer.cornerRadius = 10
        closeButton.applyGradient(colorStart: UIColor.rgb(230,74,25), colorCenter: UIColor.rgb(216,67,21), colorEnd: UIColor.rgb(191,54,12), type: .vertical, cornerRadius: 10   )
    }
    
    private func makeRequest(activity: Request.Activity) {
        let request = Request(uuid: uuid!, device: currentDevice, activity: activity)
        NetworkManager.shared.makeRequest(request: request, callback: { (code, response) in
            
            if let response = response.message {
                let color:UIColor
                switch code {
                    case 200...299:
                        color = UIColor.rgb(46,125,50)
                    default:
                        color = UIColor.rgb(183, 28, 28)
                }
                self.showNotification(response, inColor: color)
            }
        })
    }
}

extension ViewController:PageViewControllerDelegate {
    func onPageChanged(index:Int) {
        if index==1 {
            self.currentDevice = .garage
        }
        else {
            self.currentDevice = .fence
        }
        
    }
}



