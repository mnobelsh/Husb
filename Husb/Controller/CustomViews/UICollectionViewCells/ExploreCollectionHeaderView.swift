//
//  ExploreCollectionHeaderView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 14/06/21.
//

import UIKit

protocol ExploreCollectionHeaderViewDelegate: AnyObject {
    
    func exploreCollectionSearchBarDidBeginEditing(
        _ searchBar: UISearchBar,
        cell: ExploreCollectionHeaderView
    )
    
}


class ExploreCollectionHeaderView: UICollectionViewCell {
    
    static let identifier: String = String(describing: ExploreCollectionHeaderView.self)
    
    weak var delegate: ExploreCollectionHeaderViewDelegate?
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        
        let mainText = NSMutableAttributedString(
            string: "Customise!\n",
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.jetBlack,
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26)
            ])
        let descriptionText = NSAttributedString(
            string: "\nClick here to create a challenge",
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.jetBlack,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .semibold)
            ]
        )
        mainText.append(descriptionText)
        
        label.attributedText = mainText
        return label
    }()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        searchBar.returnKeyType = .search
        searchBar.searchTextField.textColor = .jetBlack
        searchBar.placeholder = "Search with love"
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.backgroundColor = .pearlWhite
        searchBar.searchTextField.layer.shadowOffset = .init(width: 1.5, height: 1.5)
        searchBar.searchTextField.layer.shadowColor = UIColor.spaceGrey.cgColor
        searchBar.searchTextField.layer.shadowOpacity = 1
        searchBar.delegate = self
        return searchBar
    }()
    private lazy var mainContainerView: UIView = {
        let view = UIView()
        view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-25)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-(self.layer.frame.width/3))
        }
        view.backgroundColor = .funYellow
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        view.heroID = "HeaderContainerView"
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private Functions
private extension ExploreCollectionHeaderView {
    
    func setupUI() {
        self.contentView.addSubview(self.mainContainerView)
        self.contentView.addSubview(self.searchBar)
        self.mainContainerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        self.searchBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        self.backgroundColor = .clear
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
}

// MARK: - ExploreCollectionHeaderView+UISearchBarDelegate
extension ExploreCollectionHeaderView: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.delegate?.exploreCollectionSearchBarDidBeginEditing(searchBar, cell: self)
    }
    
}
