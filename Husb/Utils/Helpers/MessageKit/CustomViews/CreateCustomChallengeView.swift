//
//  CreateCustomChallengeView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 20/07/21.
//

import UIKit
import SwiftMessages
import KDCalendar


class CreateCustomChallengeView: MessageView {
    
    var confirmAction: ((ChallengeDomain) -> Void)?
    
    // MARK: - SubViews
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .jetBlack
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.text = "Create a challenge"
        return label
    }()
    lazy var challengeTitleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.attributedPlaceholder = NSAttributedString(string: "Challenge Title", attributes: [
            .foregroundColor: UIColor.spaceGrey,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        textField.delegate = self
        return textField
    }()
    lazy var dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textColor = .jetBlack
        label.text = "Due Date"
        return label
    }()
    lazy var calendarView: CalendarView = {
        let calendarView = CalendarView()
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.multipleSelectionEnable = false
        calendarView.style = .Default
        calendarView.direction = .horizontal
        calendarView.marksWeekends = false
        return calendarView
    }()
    lazy var roleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.attributedPlaceholder = NSAttributedString(string: "Role", attributes: [
            .foregroundColor: UIColor.spaceGrey,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        textField.delegate = self
        textField.inputView = self.rolePickerView
        return textField
    }()
    lazy var rolePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    lazy var loveLanguageTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.attributedPlaceholder = NSAttributedString(string: "Love Language", attributes: [
            .foregroundColor: UIColor.spaceGrey,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        textField.delegate = self
        textField.inputView = self.loveLanguagePickerView
        return textField
    }()
    lazy var loveLanguagePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.seaBlue.cgColor
        textView.layer.cornerRadius = 10
        textView.text = "Challenge descriptions..."
        textView.backgroundColor = .ghostWhite
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            CreateCustomChallengeView.makeInputContainerView(with: self.challengeTitleTextField),
            CreateCustomChallengeView.makeInputContainerView(with: self.roleTextField),
            CreateCustomChallengeView.makeInputContainerView(with: self.loveLanguageTextField)
        ])
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.jetBlack, for: .normal)
        button.backgroundColor = .seaBlue
        button.dropShadow()
        button.layer.cornerRadius = 15
        button.addTarget(
            self,
            action: #selector(self.onDoneButtonDidTap(_:)),
            for: .touchUpInside
        )
        button.isEnabled = false
        return button
    }()
    
    private var roles: [RoleDomain] = [
        RoleDomain.hubby,
        RoleDomain.wife,
        RoleDomain.couple
    ]
    private var loveLanguages: [LoveLanguageDomain] = LoveLanguageDomain.list
    
    private var challengeTitle: String? {
        didSet {
            if let challengeTitle = self.challengeTitle, !challengeTitle.isEmpty {
                self.challengeTitleIsValid = true
            } else {
                self.challengeTitleIsValid = false
            }
        }
    }
    private var selectedRole: RoleDomain? {
        didSet {
            if self.selectedRole != nil {
                self.selectedRoleIsValid = true
            } else {
                self.selectedRoleIsValid = false
            }
        }
    }
    private var selectedLoveLanguage: LoveLanguageDomain? {
        didSet {
            if self.selectedLoveLanguage != nil {
                self.selectedLoveLanguageIsValid = true
            } else {
                self.selectedLoveLanguageIsValid = false
            }
        }
    }
    private lazy var challengeDescription: String = self.descriptionTextView.text
    private var dueDate: Date? {
        didSet {
            if self.dueDate != nil {
                self.dueDateIsValid = true
            } else {
                self.dueDateIsValid = false
            }
        }
    }
    
    private var challengeTitleIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var selectedRoleIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var selectedLoveLanguageIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var dueDateIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.backgroundColor = .pearlWhite
        self.dropShadow()
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.addSubview(self.customTitleLabel)
        self.addSubview(self.inputStackView)
        self.addSubview(self.descriptionTextView)
        self.addSubview(self.dueDateLabel)
        self.addSubview(self.calendarView)
        self.addSubview(self.doneButton)
        
        self.customTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(25)
        }
        self.inputStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(self.customTitleLabel.snp.bottom).offset(20)
            make.bottom.equalTo(self.descriptionTextView.snp.top).offset(-25)
        }
        self.descriptionTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalTo(self.dueDateLabel.snp.top).offset(-20)
            make.height.equalTo(self.frame.width*0.3)
        }
        self.dueDateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(18)
            make.bottom.equalTo(self.calendarView.snp.top)
        }
        self.calendarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(self.frame.width * 0.75)
            make.bottom.equalTo(self.doneButton.snp.top).offset(-10)
        }
        self.doneButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(48)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    
    @objc
    private func onDoneButtonDidTap(_ sender: UIButton) {
        let customChallenge = ChallengeDomain(
            id: UUID().uuidString,
            title: self.challengeTitle ?? "",
            description: self.challengeDescription,
            loveLanguage: self.selectedLoveLanguage ?? .qualityTime,
            role: self.selectedRole ?? .couple,
            steps: [
                .init(
                    stepNumber: 1,
                    description: "Tap Checkmark button below to finish this challenge.",
                    isDone: false
                )
            ],
            isActive: true,
            funFact: .init(description: "Though being in a relationship comes with its downsides, it's worth suffering through those melancholy moments just to reap the many benefits that love has to offer.", url: "https://bestlifeonline.com/love-facts/"),
            isCompleted: false,
            dueDate: self.dueDate,
            addedDate: Date(),
            posterImage: .customChallenge,
            momentImage: nil
        )
        self.confirmAction?(customChallenge)
    }
    
    private func validateFormInput() {
        if self.dueDateIsValid && self.selectedRoleIsValid && self.challengeTitleIsValid && self.selectedLoveLanguageIsValid {
            self.doneButton.isEnabled = true
            self.doneButton.backgroundColor = .seaBlue
        } else {
            self.doneButton.isEnabled = false
            self.doneButton.backgroundColor = .spaceGrey
        }
    }
    
}


extension CreateCustomChallengeView {
    
    static func makeInputContainerView(with textField: UITextField) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let textFieldContainerView = UIView()
        textFieldContainerView.backgroundColor = .pearlWhite
        textFieldContainerView.dropShadow()
        textFieldContainerView.layer.cornerRadius = 6
        textFieldContainerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
        }
        
        view.addSubview(textFieldContainerView)
        textFieldContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.width*0.13)
        }
        
        return view
    }
    
}

extension CreateCustomChallengeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.roleTextField || textField == self.loveLanguageTextField {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.challengeTitleTextField {
            self.challengeTitle = textField.text
        }
    }
    
}

extension CreateCustomChallengeView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.rolePickerView {
            return self.roles.count
        } else if pickerView == self.loveLanguagePickerView {
            return self.loveLanguages.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.rolePickerView {
            return self.roles[row].title
        } else if pickerView == self.loveLanguagePickerView {
            return self.loveLanguages[row].title
        }
        return nil
    }
    
}

extension CreateCustomChallengeView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.rolePickerView {
            self.selectedRole = self.roles[row]
            self.roleTextField.text = self.roles[row].title
        } else if pickerView == self.loveLanguagePickerView {
            self.selectedLoveLanguage = self.loveLanguages[row]
            self.loveLanguageTextField.text = self.loveLanguages[row].title
        }
    }
    
}


extension CreateCustomChallengeView: UITextViewDelegate {
    
}

extension CreateCustomChallengeView: CalendarViewDataSource {
    
    func startDate() -> Date {
        return Date()
    }
    
    func endDate() -> Date {
        return self.calendarView.calendar.date(byAdding: .year, value: 2, to: Date()) ?? Date()
    }
    
    func headerString(_ date: Date) -> String? {
        return nil
    }
    
    
}


extension CreateCustomChallengeView: CalendarViewDelegate {
    
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        self.dueDate = date
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        self.dueDate = nil
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {
        
    }
    
    
}
