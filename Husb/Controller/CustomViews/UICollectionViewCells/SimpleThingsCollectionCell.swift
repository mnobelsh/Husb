//
//  SimpleThingsCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/06/21.
//

import UIKit

protocol SimpleThingsCollectionCellDelegate: AnyObject {
    
    func simpleThingsCollectionCell(_ cell: SimpleThingsCollectionCell, didTap checkMarkButton: UIButton)
    
}

class SimpleThingsCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: SimpleThingsCollectionCell.self)
    
    weak var delegate: SimpleThingsCollectionCellDelegate?
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        return label
    }()
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.jetBlack.cgColor
        button.backgroundColor = .pearlWhite
        button.layer.cornerRadius = 6
        button.snp.makeConstraints { make in
            make.width.height.equalTo(35)
        }
        button.contentEdgeInsets = .init(top: 1, left: 1, bottom: 1, right: 1)
        button.addTarget(
            self,
            action: #selector(self.onCheckMarkButtonDidTap(_:)),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with challenge: ChallengeDomain) {
        self.titleLabel.text = challenge.title
        self.imageView.image = challenge.posterImage
    }
    
    
}

// MARK: - Private Functions
private extension SimpleThingsCollectionCell {
    
    private func setupUI() {
        self.backgroundColor = .skyBlue
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.checkBoxButton)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
        self.checkBoxButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self.layer.cornerRadius = 10
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
}

// MARK: - @objc Functions
extension SimpleThingsCollectionCell {
    
    @objc
    private func onCheckMarkButtonDidTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? sender.setImage(.checkMarkIcon.withTintColor(.jetBlack, renderingMode: .alwaysOriginal), for: .normal) : sender.setImage(UIImage(), for: .normal)
        self.delegate?.simpleThingsCollectionCell(self, didTap: sender)
    }
    
}
