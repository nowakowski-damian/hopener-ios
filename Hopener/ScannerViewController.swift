//
//  ScannerViewController.swift
//  Hopener
//
//  Created by Damian Nowakowski on 17/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController {
    
    public static let stroyboardId = "scannerViewController"

    @IBOutlet weak var containerView: UIView!
    
    let containerBorderWidth:CGFloat = 5
    let qrBorderWidth:CGFloat = 2
    var qrCodeFrameView:UIView?
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.borderWidth = containerBorderWidth
        containerView.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        prepareQrcodeReaderView()
        prepareQrcodeBorder()
    }
    
    private func prepareQrcodeBorder() {
        self.qrCodeFrameView = UIView()
        self.qrCodeFrameView?.layer.borderColor = UIColor.green.cgColor
        self.qrCodeFrameView?.layer.borderWidth = qrBorderWidth
        self.view.addSubview(qrCodeFrameView!)
        self.view.bringSubview(toFront: qrCodeFrameView!)
    }
    
    private func prepareQrcodeReaderView() {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            let input = try AVCaptureDeviceInput.init(device: captureDevice)
            self.captureSession = AVCaptureSession()
            self.captureSession?.addInput(input)
        }
        catch {
            return
        }
        let output = AVCaptureMetadataOutput()
        captureSession?.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        let origin = CGPoint(x: containerBorderWidth, y: containerBorderWidth)
        let size = CGSize(width: containerView.frame.size.width-2*containerBorderWidth, height: containerView.frame.size.height-2*containerBorderWidth)
        videoPreviewLayer?.frame = CGRect(origin: origin, size: size)
        containerView.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ScannerViewController : AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects != nil && !metadataObjects.isEmpty {
            
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if metadataObj.type == AVMetadataObjectTypeQRCode {
                
                let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj ) as! AVMetadataMachineReadableCodeObject
                let origin = CGPoint(x: containerView.frame.origin.x + barCodeObject.bounds.origin.x + self.containerBorderWidth, y: containerView.frame.origin.y + barCodeObject.bounds.origin.y + self.containerBorderWidth)
                let size = CGSize(width: barCodeObject.bounds.size.width, height: barCodeObject.bounds.size.height)
                qrCodeFrameView?.frame = CGRect(origin: origin, size: size)
                
                if metadataObj.stringValue != nil, let uuid = metadataObj.stringValue {
                    
                    captureSession?.stopRunning()
                    DataManager.shared.saveUuid(uuid)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewController.stroyboardId ) as! ViewController
                    vc.uuid = uuid
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        else {
            qrCodeFrameView?.frame = CGRect.zero
        }
    }
    
}
