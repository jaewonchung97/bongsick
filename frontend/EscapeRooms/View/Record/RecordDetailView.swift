//
//  RecordDetailView.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/04.
//

import UIKit

protocol RecordDetailViewDelegate {
    func saveButtonTapped()
}

class RecordDetailView: UIView {
    
    private lazy var buttonWidth = self.frame.width / 2
    
    // MARK: - Properties
    
    var delegate: RecordDetailViewDelegate?
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .customBlack
        sv.indicatorStyle = .black
        return sv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customBlack
        return view
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "탈출 결과"
        return label
    }()
    
    let successButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("성공", for: .normal)
        return button
    }()
    
    let failButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("실패", for: .normal)
        return button
    }()

    
    let themeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "테마명    "
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .recordDetailLabelColor
        return label
    }()
    
    let themeTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .recordDetailLabelColor
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
//        tf.contentHorizontalAlignment = .leading
        tf.textAlignment = .center
        tf.placeholder = "테마를 선택해주세요."
        return tf
    }()
    
    let themePickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.backgroundColor = .clear
        return pv
    }()
    
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.backgroundColor = .customBlack
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        toolbar.tintColor = .recordDetailLabelColor
        toolbar.isTranslucent = true
        toolbar.isUserInteractionEnabled = true
        
        let doneButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(doneButtonTapped))
        let space = UIBarButtonItem(systemItem: .flexibleSpace)
        let cancelButton = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancelButtonTapped))
        toolbar.setItems([cancelButton, space, doneButton], animated: true)
        return toolbar
    }()
    
    lazy var themeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [themeLabel, themeTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "탈출 시도"
        label.textColor = .recordDetailLabelColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .recordDetailLabelColor
        picker.preferredDatePickerStyle = .automatic
        picker.date = Date()
        picker.tintColor = .black
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko_KR")
        picker.timeZone = .autoupdatingCurrent
        picker.contentHorizontalAlignment = .leading
        picker.layer.cornerRadius = 8
        picker.layer.masksToBounds = true
        return picker
    }()
    
    lazy var dateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [dateLabel, datePicker])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let escapeTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "걸린 시간"
        label.textColor = .recordDetailLabelColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let minuteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "분"
        label.textColor = .recordDetailLabelColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "초"
        label.textColor = .recordDetailLabelColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let minuteTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .recordDetailLabelColor
        tf.layer.cornerRadius = 8
        tf.textAlignment = .center
        tf.layer.masksToBounds = true
        tf.placeholder = "0"
        return tf
    }()
    
    let secondTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .recordDetailLabelColor
        tf.layer.cornerRadius = 8
        tf.textAlignment = .center
        tf.layer.masksToBounds = true
        tf.placeholder = "0"
        return tf
    }()
    
    lazy var escapeTimeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [escapeTimeLabel, minuteTextField, minuteLabel, secondTextField, secondLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "힌트 갯수"
        label.textColor = .recordDetailLabelColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let hintTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .recordDetailLabelColor
        tf.layer.cornerRadius = 8
        tf.textAlignment = .center
        tf.placeholder = "0"
        return tf
    }()
    
    let hintlimitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "개"
        label.textColor = .recordDetailLabelColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var hintStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [hintLabel, hintTextField, hintlimitLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "내용"
        label.textColor = .recordDetailLabelColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .recordDetailLabelColor
        tv.layer.borderWidth = 1.0
        tv.layer.borderColor = UIColor.black.cgColor
        tv.layer.cornerRadius = 8
        tv.layer.masksToBounds = true
//        tv.isScrollEnabled = true
        return tv
    }()
    
    lazy var textStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [textLabel, textView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customBlack
        view.alpha = 0.8
//        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.customGray.cgColor
        return view
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("기록하기", for: .normal)
        button.backgroundColor = .customOrange
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var mainStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [themeStackView, dateStackView, escapeTimeStackView, hintStackView, textStackView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fill
        sv.spacing = 20
        return sv
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configurePickerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    
    // MARK: - Setting

    func setupUI() {
        self.backgroundColor = .navy
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(saveButton)
    }
    
    func configureScrollView() {
//        let width = self.frame.width
//        scrollView.contentSize = CGSize(width: width, height: 1500)
    }
    
    func configurePickerView() {
        themeTextField.inputView = themePickerView
        themeTextField.inputAccessoryView = toolbar
    }
    
    func setConstraints() {
        
        let textViewWidth = self.frame.width - 40
        
        let height = self.datePicker.frame.height
        let width = self.datePicker.frame.width
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 750),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            
            saveButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            
            themeTextField.heightAnchor.constraint(equalToConstant: height),
            themeTextField.widthAnchor.constraint(equalToConstant: width),
            
            minuteTextField.heightAnchor.constraint(equalToConstant: height),
            minuteTextField.widthAnchor.constraint(equalToConstant: width / 3),
            
            secondTextField.heightAnchor.constraint(equalToConstant: height),
            secondTextField.widthAnchor.constraint(equalToConstant: width / 3),
            
            hintTextField.heightAnchor.constraint(equalToConstant: height),
            hintTextField.widthAnchor.constraint(equalToConstant: width / 3),
        
            textView.heightAnchor.constraint(equalToConstant: 200),
            textView.widthAnchor.constraint(equalToConstant: textViewWidth)
        ])
        
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor).priority = .defaultLow
    }
    
    // MARK: - Action
    
    @objc func doneButtonTapped() {
        themeTextField.resignFirstResponder()
    }
    
    @objc func cancelButtonTapped() {
        themeTextField.resignFirstResponder()
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        delegate?.saveButtonTapped()
    }

    
}
