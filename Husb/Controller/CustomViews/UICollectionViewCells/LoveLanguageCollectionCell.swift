//
//  LoveLanguageCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 14/06/21.
//

import UIKit

class LoveLanguageCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: LoveLanguageCollectionCell.self)
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pearlWhite
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    private func setupUI() {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleContainerView)
        self.imageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.titleContainerView.snp.top).offset(-20)
        }
        self.titleContainerView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(self.frame.height*0.65)
        }
        self.layer.cornerRadius = 15
        self.backgroundColor = .romanticPink
        self.layer.shadowOffset = .init(width: 0.5, height: 0.5)
        self.layer.shadowColor = UIColor.spaceGrey.cgColor
        self.layer.shadowOpacity = 0.5
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    func fill(loveLanguage: LoveLanguageDomain) {
        self.titleLabel.text = loveLanguage.title
        self.imageView.image = loveLanguage.posterImage
    }
}
