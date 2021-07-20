//
//  SectionHeaderView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/06/21.
//

import UIKit
import SnapKit


protocol SectionHeaderViewDelegate: AnyObject {

    func sectionHeaderViewDidTapSeeAll(_ button: UIButton, view: SectionHeaderView, at indexPath: IndexPath?)
}

class SectionHeaderView: UICollectionReusableView {
    
    static let identifier: String = String(describing: SectionHeaderView.self)
    static let kind: String = UICollectionView.elementKindSectionHeader
    
    weak var delegate: SectionHeaderViewDelegate?
    var indexPath: IndexPath?
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .jetBlack
        return label
    }()
    private lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.seaBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(
            self,
            action: #selector(self.onSeeAllButtonDidTap(_:)),
            for: .touchUpInside
        )
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
    func fill(title: String, seeAllButtonIsEnabled: Bool = false, at indexPath: IndexPath? = nil) {
        self.titleLabel.text = title
        if seeAllButtonIsEnabled {
            self.seeAllButton.isHidden = false
        } else {
            self.seeAllButton.isHidden = true
        }
        self.indexPath = indexPath
    }
}


// MARK: - @objc Functions
private extension SectionHeaderView {
    
    @objc
    func onSeeAllButtonDidTap(_ sender: UIButton) {
        self.delegate?.sectionHeaderViewDidTapSeeAll(sender, view: self, at: self.indexPath)
    }
    
}
