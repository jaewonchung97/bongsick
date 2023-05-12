//
//  ThemeDetailView.swift
//  EscapeRooms
//
//  Created by playhong on 2023/02/23.
//

import UIKit
import MapKit

final class ThemeDetailView: UIView {

    // MARK: - Properties
    
    let likeButtonConfigure = UIImage.SymbolConfiguration(pointSize: 25)
    
    var imageURL: String? {
        didSet {
            guard let url = imageURL else { return }
            NetworkingManager.shared.loadImage(url, imageView: self.imageView)
        }
    }
    
    var theme: Theme? {
        didSet {
            setupThemeData()
        }
    }
    
    var likedTheme: LikedData? {
        didSet {
            setupLikedThemeData()
        }
    }
    
    var reservationURL: String?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = Setup.Color.backgroundColor
        // 스크롤 인디케이터(스크롤바 색) 스타일 변경
        scrollView.indicatorStyle = .black
        return scrollView
    }()

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Setup.Color.backgroundColor
        return view
    }()

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let firstLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customGray
        return view
    }()
    
    let secondLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customGray
        return view
    }()
    
    let thirdLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customGray
        return view
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.boldSystemFont(ofSize: 24)
       label.textColor = Setup.Color.textColor
       return label
   }()
   
   let companyLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.boldSystemFont(ofSize: 17)
       label.textColor = .gray
       return label
   }()
   
   let difficultyLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.systemFont(ofSize: 14)
       label.textColor = Setup.Color.textColor
       return label
   }()
   
   let playTimeLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.systemFont(ofSize: 14)
       label.textColor = Setup.Color.textColor
       return label
   }()
   
   let personnelLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.systemFont(ofSize: 14)
       label.textColor = Setup.Color.textColor
       return label
   }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [difficultyLabel, playTimeLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    let storyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "테마 소개"
        label.textColor = Setup.Color.textColor
        return label
    }()
    
    let storyTextView: UITextView = {
       let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = Setup.Color.backgroundColor
        tv.textColor = Setup.Color.textColor
        tv.sizeToFit()
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "가격"
        label.textColor = Setup.Color.textColor
        return label
    }()
    
    let priceSubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "1인 기준"
        label.textColor = Setup.Color.textColor
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = Setup.Color.textColor
        return label
    }()
    
    let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "위치 정보"
        label.textColor = Setup.Color.textColor
        return label
    }()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.overrideUserInterfaceStyle = .dark
        map.showsUserLocation = true
        return map
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "서울특별시 강남구 역삼동 824-25 대우디오빌플러스 지하 1층 111호"
        label.textColor = Setup.Color.textColor
        return label
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Setup.Color.backgroundColor
        return view
    }()
    
    let reservationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customOrange
        button.setTitle("예약하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(reservationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart", withConfiguration: likeButtonConfigure), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var bottomButtonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [likeButton, reservationButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 20
        return sv
    }()
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        print(#function)
        setConstraints()
        super.updateConstraints()
    }
    
    // MARK: - Setting
    
    func setupUI() {
        print("DEBUG: DetailView setupUI()")
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(personnelLabel)
        contentView.addSubview(storyLabel)
        contentView.addSubview(storyTextView)
        contentView.addSubview(priceTitleLabel)
        contentView.addSubview(priceSubLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationTitleLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(bottomView)
        bottomView.addSubview(bottomButtonStackView)
    }
    
    func setConstraints() {
        
        let bottomViewHeight: CGFloat = 100
        
        reservationButton.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
        likeButton.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 450),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            companyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            companyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            personnelLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            personnelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            storyLabel.topAnchor.constraint(equalTo: personnelLabel.bottomAnchor, constant: 30),
            storyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            storyTextView.topAnchor.constraint(equalTo: storyLabel.bottomAnchor, constant: 10),
            storyTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            storyTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceTitleLabel.topAnchor.constraint(equalTo: storyTextView.bottomAnchor, constant: 0),
            priceTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            priceSubLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 5),
            priceSubLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            priceLabel.topAnchor.constraint(equalTo: priceSubLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            locationTitleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            locationTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            mapView.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mapView.heightAnchor.constraint(equalToConstant: 200),
    
            locationLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottomViewHeight),
        
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: bottomViewHeight),
            
            bottomButtonStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            bottomButtonStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 30),
            bottomButtonStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
        ])
    }
    
    func setupThemeData() {
        imageURL = theme?.imgURL
        nameLabel.text = theme?.name
        companyLabel.text = theme?.companies[0]
        guard let playTime = theme?.playTime, let difficulty = theme?.difficulty else { return }
        difficultyLabel.text = String(difficulty)
        playTimeLabel.text = String(playTime)
        guard let personnel = theme?.personnelMin else { return }
        personnelLabel.text = String(personnel)
        storyTextView.text = theme?.story
        priceLabel.text = "25000원"
        reservationURL = theme?.reservationURL
    }
    
    func setupLikedThemeData() {
        imageURL = likedTheme?.imageURL
        nameLabel.text = likedTheme?.name
        companyLabel.text = likedTheme?.company
    }
    
    // MARK: - Action
    
    @objc func reservationButtonTapped() {
        print("예약하기 버튼을 누름.")
        guard let urlString = reservationURL else { return }
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
        print("예약하기 버튼을 누름.")
    }
    
    @objc func likeButtonTapped() {
        if likeButton.tag == 0 {
            likeButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: likeButtonConfigure), for: .normal)
            likeButton.tintColor = .systemPink
            likeButton.tag = 1
        } else {
            likeButton.setImage(UIImage(systemName: "heart", withConfiguration: likeButtonConfigure), for: .normal)
            likeButton.tintColor = .lightGray
            likeButton.tag = 0
        }
    }

}
