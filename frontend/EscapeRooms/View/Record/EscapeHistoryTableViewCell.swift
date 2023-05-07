//
//  RecordTVCell.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/24.
//

import UIKit

class EscapeHistoryTableViewCell: UITableViewCell {

    static let identifier = "EscapeHistoryTableViewCell"
    
    // MARK: - Properties
    
    var recordData: RecordData? {
        didSet {
            configureCell()
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let themeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "강남목욕탕.jpeg")
        iv.layer.cornerRadius = 25
//        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let themeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let escapeTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       
        let sv = UIStackView(arrangedSubviews: [dateLabel, themeImageView, themeNameLabel, escapeTimeLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 20
        return sv
        
    }()

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setting
    
    func setupUI() {
        self.backgroundColor = .customBlack
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 8
        self.addSubview(stackView)
    }
    
    func setConstraints() {
        
        themeNameLabel.setContentHuggingPriority(.init(249), for: .vertical)
        themeNameLabel.setContentHuggingPriority(.init(249), for: .horizontal)
        
        let imageViewConstraints = [
            themeImageView.heightAnchor.constraint(equalToConstant: 50),
            themeImageView.widthAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
//        let dateLabelConstraints = [
//            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
//            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
//        ]
//        NSLayoutConstraint.activate(dateLabelConstraints)
        
        
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    func configureCell() {
        let date = recordData?.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let convertDate = dateFormatter.string(from: date!)
        dateLabel.text = convertDate
        themeNameLabel.text = recordData?.theme
        let minute = recordData?.minute ?? "0"
        let second = recordData?.second ?? "0"
        let escapeTime = "\(minute)분 \(second)초"
        if escapeTime == "분 초" {
            escapeTimeLabel.text = "실패"
            escapeTimeLabel.textColor = .red
        } else {
            escapeTimeLabel.text = escapeTime
            escapeTimeLabel.textColor = .systemBlue
        }
        print("DEBUG: EscapeHistory TableView Cell Configure")
    }
    
    // MARK: - Action

}
