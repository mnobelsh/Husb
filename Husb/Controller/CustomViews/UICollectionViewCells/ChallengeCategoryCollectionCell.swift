//
//  ChallengeCategoryCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/06/21.
//

import UIKit

class ChallengeCategoryCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: ChallengeCategoryCollectionCell.self)
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9)
        label.textColor = .jetBlack
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(self.titleLabel)

        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
            make.width.greaterThanOrEqualTo(50)
            make.height.equalTo(16)
        }
        
        self.contentView.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.titleLabel.snp.trailing).inset(-4)
            make.bottom.equalTo(self.titleLabel.snp.bottom).inset(-4)
        }
        
        self.contentView.layer.cornerRadius = 2.5
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = CGFloat(ceil(Float(size.width)))
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
    func fill(role: RoleDomain) {
        self.titleLabel.text = role.title
        switch role.type {
        case .hubby:
            self.contentView.backgroundColor = .skyBlue
        case .wife:
            self.contentView.backgroundColor = .romanticPink
        default:
            self.contentView.backgroundColor = .funYellow
            break
        }
    }
    
    func fill(loveLanguage: LoveLanguageDomain) {
        self.titleLabel.text = loveLanguage.title
        self.contentView.backgroundColor = .funYellow
    }
    
    
    
}
