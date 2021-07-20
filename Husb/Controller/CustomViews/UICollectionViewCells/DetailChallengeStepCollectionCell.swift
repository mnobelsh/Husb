//
//  DetailChallengeStepCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import UIKit

protocol DetailChallengeStepCollectionCellDelegate: AnyObject {
    
    func detailChallengeStepCollectionCell(
        _ cell: DetailChallengeStepCollectionCell,
        didTap checkMarkButton : UIButton,
        withStep step: ChallengeStepDomain
    )
    
}

class DetailChallengeStepCollectionCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailChallengeStepCollectionCell.self)
    
    private var challengeStep: ChallengeStepDomain! {
        didSet {
            self.stepDescriptionLabel.text = self.challengeStep.description
        }
    }
    
    weak var delegate: DetailChallengeStepCollectionCellDelegate?
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 2
        label.text = "Step 1"
        label.textColor = .jetBlack
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    private lazy var stepDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "Description"
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    private lazy var checkMarkButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor.spaceGrey.cgColor
        button.backgroundColor = .pearlWhite
        button.layer.cornerRadius = 6
        button.snp.makeConstraints { make in
            make.width.height.equalTo(35)
        }
        button.contentEdgeInsets = .init(top: 1, left: 1, bottom: 1, right: 1)
        button.addTarget(self, action: #selector(self.onCheckMarkButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    func fill(with step: ChallengeStepDomain, isEnabled: Bool) {
        self.challengeStep = step
        self.titleLabel.text = "Step \(step.stepNumber)"
        self.checkMarkButton.isEnabled = isEnabled
        step.isDone ? self.checkMarkButton.setImage(.checkMarkIcon.withTintColor(.jetBlack, renderingMode: .alwaysOriginal), for: .normal) : self.checkMarkButton.setImage(UIImage(), for: .normal)
        self.backgroundColor = isEnabled ? .skyBlue : .spaceGrey
    }
    
}

// MARK: - Private Functions
private extension DetailChallengeStepCollectionCell {
    
    func setupUI() {
        self.backgroundColor = .skyBlue
        self.layer.cornerRadius = 15
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.stepDescriptionLabel)
        self.contentView.addSubview(self.checkMarkButton)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }
        self.checkMarkButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
        self.stepDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(3)
            make.bottom.equalTo(self.checkMarkButton.snp.top).offset(-10)
        }

        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
}

// MARK: - @objc Function
extension DetailChallengeStepCollectionCell {
    
    @objc
    private func onCheckMarkButtonDidTap(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        self.delegate?.detailChallengeStepCollectionCell(self, didTap: sender, withStep: self.challengeStep)
    }
    
}
