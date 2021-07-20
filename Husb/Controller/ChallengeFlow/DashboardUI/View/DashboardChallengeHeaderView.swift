//
//  DashboardChallengeHeaderView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/06/21.
//

import UIKit
import SnapKit

protocol DashboardChallengeHeaderViewDelegate {
    
}

class SectionHeaderView: UICollectionReusableView {
    
    static let identifier: String = String(describing: SectionHeaderView.self)
    static let kind: String = UICollectionView.elementKindSectionHeader
    
    // MARK: - SubViews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .jetBlack
        return label
    }()
    lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.seaBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Function
    private func setupUI() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.seeAllButton)
        self.seeAllButton.isHidden = false
        self.seeAllButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.lessThanOrEqualTo(75)
        }
        self.titleLabel.snp.remakeConstraints { make in
            make.trailing.equalTo(self.seeAllButton.snp.leading).offset(-15)
            make.top.leading.bottom.equalToSuperview()
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    // MARK: - Public Function
    func fill(title: String, seeAllButtonIsEnabled: Bool = false) {
        self.titleLabel.text = title
        if seeAllButtonIsEnabled {
            self.seeAllButton.isHidden = false
        } else {
            self.seeAllButton.isHidden = true
        }
    }
}
