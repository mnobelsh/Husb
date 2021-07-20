//
//  ScanQRCodeMessageView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 15/07/21.
//

import UIKit
import SwiftMessages
import AVFoundation

class ScanQRCodeMessageView: MessageView {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var scanQRCodeAction: ((_ userId: String) -> Void)? = nil
    
    lazy var qrCodeScannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 90, height: UIScreen.main.bounds.height - (UIScreen.main.bounds.width*0.8))
        view.clipsToBounds = true
        return view
    }()
    
    lazy var qrCodeImageViewContainerView: UIView = {
        let view = UIView()
        let backgroundImageView = UIImageView(image: .qrBackground)
        backgroundImageView.contentMode = .scaleAspectFit
        
        view.addSubview(backgroundImageView)
        view.addSubview(self.qrCodeScannerView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.qrCodeScannerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.width*0.4)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.bottom.equalToSuperview().offset(-UIScreen.main.bounds.width*0.4)
        }
        
        return view
        
    }()
    
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Scan your partner's QR code to make a connection."
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textColor = .jetBlack
        return label
    }()
    
    deinit {
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func found(code: String) {
        print("[DEBUGS]", code)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupQRCodeScanner()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .pearlWhite
        self.layer.cornerRadius = 15
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.addSubview(self.customTitleLabel)
        self.addSubview(self.qrCodeImageViewContainerView)
        
        self.customTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(60)
        }
        self.qrCodeImageViewContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.customTitleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-50)
        }
    }
    
    private func setupQRCodeScanner() {
        self.captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (self.captureSession.canAddInput(videoInput)) {
            self.captureSession.addInput(videoInput)
        } else {
            self.captureSession = nil
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()
        if (self.captureSession.canAddOutput(metadataOutput)) {
            self.captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            self.captureSession = nil
            return
        }

        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.previewLayer.frame = self.qrCodeScannerView.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
        self.qrCodeScannerView.layer.addSublayer(self.previewLayer)
        
        if (self.captureSession?.isRunning == false) {
            self.captureSession.startRunning()
        }
    }
}


extension ScanQRCodeMessageView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let userId = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.scanQRCodeAction?(userId)
        }
    }
    
}
