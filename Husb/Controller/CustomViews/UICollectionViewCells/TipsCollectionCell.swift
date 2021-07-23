//
//  TipsCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/06/21.
//

import UIKit

class TipsCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: TipsCollectionCell.self)
    
    // MARK: - SubViews
    private lazy var containerView = TipsCollectionCell.makeLayerView()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .jetBlack
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
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
        self.backgroundColor = .clear
        
        let layer1 = TipsCollectionCell.makeLayerView()
        let layer2 = TipsCollectionCell.makeLayerView()
        
        self.contentView.addSubview(layer1)
        self.contentView.addSubview(layer2)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.descriptionLabel)
        self.containerView.addSubview(self.titleLabel)

        layer1.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        layer2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        self.containerView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(20)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }

        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    
    func fill(tips: TipsDomain) {
        self.titleLabel.text = tips.title
        self.descriptionLabel.text = tips.description
    }
    
}

extension TipsCollectionCell {
    
    static func makeLayerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .pearlWhite
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.seaBlue.cgColor
        return view
    }
    
}
