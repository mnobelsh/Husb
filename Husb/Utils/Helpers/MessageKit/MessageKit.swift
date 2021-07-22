//
//  MessageKit.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 08/07/21.
//

import SwiftMessages
import UIKit

class MessageKit {
    
    static let loadingViewMessageId = "LoadingViewMessageId"
    
    static func showLoadingView() {
        let view = LoadingMessageView(frame: UIScreen.main.bounds)
        view.id = MessageKit.loadingViewMessageId
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.presentationContext = .window(windowLevel: .statusBar)
        config.duration = .forever
        config.dimMode = .gray(interactive: false)
        config.interactiveHide = false
        config.preferredStatusBarStyle = .lightContent

        SwiftMessages.show(config: config, view: view)
    }
    
    static func hideLoadingView() {
        SwiftMessages.hide(id: MessageKit.loadingViewMessageId)
    }
    
    static func showQRCodeView(
        withId id: String = UUID().uuidString,
        userId: String
    ) {
        let view = QRCodeMessageView(frame: UIScreen.main.bounds)
        view.setUserId(userId)
        view.id = id
        view.userId = userId
        view.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height*0.9)
        }
        
        var config = SwiftMessages.defaultConfig
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        config.presentationContext = .window(windowLevel: .normal)
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)
    }
    
    static func showScanQRCodeView(
        withId id: String = UUID().uuidString,
        userId: String,
        scanQRCodeAction: @escaping(_ userId: String) -> Void
    ) {
        let view =  ScanQRCodeMessageView(frame: UIScreen.main.bounds)
        view.id = id
        view.scanQRCodeAction = scanQRCodeAction
        view.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height*0.9)
        }
        
        var config = SwiftMessages.defaultConfig
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        config.presentationContext = .window(windowLevel: .normal)
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)
    }
    
    static func showDatePickerView(
        withId id: String = UUID().uuidString,
        confirmAction: ((Date?) -> Void)? = nil,
        dismissAction: (()->Void)? = nil
    ) {
        let view = DatePickerMessageView(frame: UIScreen.main.bounds)
        view.id = id
        view.doneButtonHandler = confirmAction
        view.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height*0.6)
        }
        
        var config = SwiftMessages.defaultConfig
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        config.presentationContext = .window(windowLevel: .normal)
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)
    }
    
    static func showCompletedChallengeMessage(
        withId id: String = UUID().uuidString,
        confirmAction: (()->Void)? = nil,
        dismissAction: (()->Void)? = nil
    ) {
        let view = CompletedChallengeMessageView(frame: UIScreen.main.bounds)
        view.id = id
        view.skipButtonHandler = dismissAction
        view.choosePhotoButtonHandler = confirmAction
        view.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(220)
        }
        view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        var config = SwiftMessages.defaultConfig
        config.dimMode = .gray(interactive: true)
        config.duration = .forever
        config.interactiveHide = false
        config.presentationContext = .window(windowLevel: .normal)
        config.presentationStyle = .center
        SwiftMessages.show(config: config, view: view)
    }
    
    static func showMoodPickerView(
        withId id: String = UUID().uuidString,
        confirmAction: ((MoodDomain)->Void)? = nil
    ) {
        let view = MoodPickerView(frame: UIScreen.main.bounds)
        view.id = id
        view.confirmAction = confirmAction
        view.snp.makeConstraints { make in
            make.height.equalTo(180)
        }
        view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        var config = SwiftMessages.defaultConfig
        config.dimMode = .gray(interactive: true)
        config.duration = .forever
        config.interactiveHide = true
        config.presentationContext = .window(windowLevel: .normal)
        config.presentationStyle = .center
        SwiftMessages.show(config: config, view: view)
    }
    
    static func showSelectTodayFeelingView() {
        
    }
    
    static func showImageViewer(
        withId id: String = UUID().uuidString,
        image: UIImage?,
        imageTitle: String = ""
    ) {
        let view = ImageViewerMessageView(frame: UIScreen.main.bounds)
        view.fill(image: image, imageTitle: imageTitle)
        view.id = id
        view.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        var config = SwiftMessages.defaultConfig
        config.dimMode = .gray(interactive: true)
        config.duration = .forever
        config.interactiveHide = false
        config.presentationContext = .window(windowLevel: .normal)
        config.presentationStyle = .center
        SwiftMessages.show(config: config, view: view)
    }
    
    static func showConnectWithWifeAlert(
        withId id: String = UUID().uuidString,
        duration: SwiftMessages.Duration,
        confirmAction: (() -> Void)? = nil
    ) {
        let view = ConnectWithPartnerMessageView()
        view.confirmAction = confirmAction
        view.id = id
        view.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(150)
        }
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.duration = duration
        config.presentationContext = .automatic
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        SwiftMessages.show(config: config, view: view)
    }
    
    static func showCreateCustomChallengeView(
        withId id: String = UUID().uuidString,
        confirmAction: ((_ challenge: ChallengeDomain) -> Void)? = nil
    ) {
        let view =  CreateCustomChallengeView(frame: UIScreen.main.bounds)
        view.id = id
        view.confirmAction = confirmAction
        view.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height*0.9)
        }
        var config = SwiftMessages.defaultConfig
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        config.presentationContext = .window(windowLevel: .normal)
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)
    }
    
    enum AlertType {
        case success
        case failure
    }
    
    static func showAlertMessageView(
        withId id: String = UUID().uuidString,
        title: String,
        type: AlertType
    ) {
        let view = AlertMessageView()
        view.id = id
        view.fill(title: title, type: type)
        view.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.duration = .seconds(seconds: 5)
        config.presentationContext = .window(windowLevel: .normal)
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        SwiftMessages.show(config: config, view: view)
    }
    
    
    static func hide(id: String) {
        SwiftMessages.hide(id: id)
    }
    
    
}
