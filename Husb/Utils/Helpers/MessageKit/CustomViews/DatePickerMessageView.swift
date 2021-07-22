//
//  DatePickerMessageView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 08/07/21.
//

import SwiftMessages
import UIKit
import KDCalendar

class DatePickerMessageView: MessageView {
    
    private var selectedDate: Date?
    var doneButtonHandler: ((Date?) -> Void)?
    
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 1
        label.text = "Set the D-Day!"
        label.textColor = .jetBlack
        return label
    }()
    lazy var currentSelectedDateLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .spaceGrey
        label.numberOfLines = 1
        label.text = "Please Select Date"
        return label
    }()
    lazy var currentSelectedDateContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        view.layer.cornerRadius = 8
        view.dropShadow(withColor: .spaceGrey, opacity: 0.5, offset: .init(width: 2, height: 2))
        view.addSubview(self.currentSelectedDateLabel)
        self.currentSelectedDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        return view
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
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.jetBlack, for: .normal)
        button.backgroundColor = .seaBlue
        button.dropShadow(
            withColor: .darkGray,
            opacity: 0.5,
            offset: .init(width: 1.5, height: 1.5)
        )
        button.layer.cornerRadius = 15
        button.addTarget(
            self,
            action: #selector(self.onDoneButtonDidTap(_:)),
            for: .touchUpInside
        )
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .pearlWhite
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        self.addSubview(self.customTitleLabel)
        self.addSubview(self.currentSelectedDateContainerView)
        self.addSubview(self.calendarView)
        self.addSubview(self.doneButton)
        self.customTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(25)
        }
        self.currentSelectedDateContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalTo(self.customTitleLabel.snp.bottom).offset(15)
            make.height.equalTo(25)
        }
        self.calendarView.snp.makeConstraints { make in
            make.top.equalTo(self.currentSelectedDateContainerView.snp.bottom).offset(15)
            make.bottom.equalTo(self.doneButton.snp.top).offset(-15)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
        }
        self.doneButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(45)
        }
    }

}

extension DatePickerMessageView {
    
    @objc
    func onDoneButtonDidTap(_ sender: UIButton) {
        self.doneButtonHandler?(self.selectedDate)
    }
    
}

extension DatePickerMessageView: CalendarViewDataSource {
    
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

extension DatePickerMessageView: CalendarViewDelegate {
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        self.selectedDate = date
        self.currentSelectedDateLabel.textColor = .jetBlack
        self.currentSelectedDateLabel.text = date.getString(withFormat: "dd MMMM yyyy")
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        self.selectedDate = nil
        self.currentSelectedDateLabel.textColor = .spaceGrey
        self.currentSelectedDateLabel.text = "Please Select Date"
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {
        
    }
    
    
}
