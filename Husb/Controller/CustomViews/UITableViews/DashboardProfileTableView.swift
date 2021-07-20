//
//  DashboardProfileTableView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 11/07/21.
//

import UIKit

class DashboardProfileTableView: UITableView {
    
    enum Items: Int, CaseIterable {
        case profileInfo = 0
        case notificationsSetting = 1
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(
            ProfileInfoTableCell.self,
            forCellReuseIdentifier: ProfileInfoTableCell.identifier
        )
        self.backgroundColor = .ghostWhite
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        self.allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
