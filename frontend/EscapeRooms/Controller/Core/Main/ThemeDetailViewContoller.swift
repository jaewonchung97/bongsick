//
//  ThemeDetailViewContoller().swift
//  EscapeRooms
//
//  Created by playhong on 2023/02/23.
//

import UIKit
import MapKit
import CoreLocation

final class ThemeDetailViewContoller: UIViewController {

    // MARK: - Properties
    
    private let detailView = ThemeDetailView()
    
    let locationManager = CLLocationManager()
    
    // 지도에 표시 할 좌표 설정
    let coordinate = CLLocationCoordinate2D(latitude: 37.4974033, longitude: 127.0310522)
    
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
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        locationInfomation()
        addMapPin()
    }
    
    // MARK: - Setting
    
    func setupThemeData() {
            title = theme?.name
            detailView.theme = theme
    }
    
    func setupLikedThemeData() {
        title = likedTheme?.name
        detailView.likedTheme = likedTheme
    }
    
    func configureDelegate() {
        detailView.mapView.delegate = self
    }
    
    func locationInfomation() {
        // 좌표 지정 및 확대
        detailView.mapView.setRegion(MKCoordinateRegion(center: coordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: false)
    }
    
    func addMapPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = theme?.companies[0]
        pin.subtitle = "서울시 강남구 역삼동 824-25 대우디오빌플러스 지하 1층 111호" 
        detailView.mapView.addAnnotation(pin)
    }
}

// MARK: - Extension

extension ThemeDetailViewContoller: MKMapViewDelegate {
    
}

extension ThemeDetailViewContoller: CLLocationManagerDelegate {
}

extension ThemeDetailView: UIWebViewDelegate {
    
}
