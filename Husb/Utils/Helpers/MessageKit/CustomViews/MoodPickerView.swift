//
//  MoodPickerView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 20/07/21.
//

import UIKit
import SwiftMessages


class MoodPickerView: MessageView {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pearlWhite
        view.layer.cornerRadius = 15
        view.addSubview(self.customTitleLabel)
        view.addSubview(self.moodCollectionView)
        
        self.customTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(20)
        }
        
        self.moodCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.customTitleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
        return view
    }()
    lazy var moodCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            MoodCollectionCell.self,
            forCellWithReuseIdentifier: MoodCollectionCell.identifier
        )
        return collectionView
    }()
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "How are you feeling today?"
        label.textColor = .jetBlack
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .center
        return label
    }()
    var moods: [MoodDomain] = [
        MoodDomain.angry,
        MoodDomain.sad,
        MoodDomain.worried,
        MoodDomain.tired,
        MoodDomain.excited,
        MoodDomain.happy
    ]
    var confirmAction: ((_ selectedMood: MoodDomain) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
}

extension MoodPickerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodCollectionCell.identifier, for: indexPath) as? MoodCollectionCell else { return UICollectionViewCell() }
        cell.fill(with: self.moods[indexPath.row])
        return cell
    }
    
}

extension MoodPickerView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMood = self.moods[indexPath.row]
        self.confirmAction?(selectedMood)
    }
    
}

extension MoodPickerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = CGFloat((collectionView.frame.width - 30))/CGFloat(self.moods.count)
        let height: CGFloat = collectionView.frame.height-15
        return CGSize(width: width, height: height)
    }
    
}
