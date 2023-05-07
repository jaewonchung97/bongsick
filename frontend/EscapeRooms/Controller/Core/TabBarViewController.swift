//
//  TabBarController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/22.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    let vc1 = MainViewController()
    let vc2 = LikesViewController()
    let vc3 = RecordViewController()
    let vc4 = MyInformationViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    func configureTabBar() {
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        vc4.navigationItem.largeTitleDisplayMode = .always
        
        vc1.title = "테마"
        vc2.title = "찜"
        vc3.title = ""
        vc4.title = "내정보"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.customBlack
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        nav1.navigationBar.standardAppearance = appearance
        nav1.navigationBar.compactAppearance = appearance
        nav1.navigationBar.scrollEdgeAppearance = appearance
        
        nav2.navigationBar.standardAppearance = appearance
        nav2.navigationBar.compactAppearance = appearance
        nav2.navigationBar.scrollEdgeAppearance = appearance
        
        nav3.navigationBar.standardAppearance = appearance
        nav3.navigationBar.compactAppearance = appearance
        nav3.navigationBar.scrollEdgeAppearance = appearance
        
        nav4.navigationBar.standardAppearance = appearance
        nav4.navigationBar.compactAppearance = appearance
        nav4.navigationBar.scrollEdgeAppearance = appearance
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = false
        nav4.navigationBar.prefersLargeTitles = true
        
        nav1.title = "테마"
        nav2.title = "찜"
        nav3.title = "기록"
        nav4.title = "내 정보"
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
        modalPresentationStyle = .fullScreen
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        tabBar.alpha = 0.95
        tabBar.tintColor = .customOrange
        
        guard let items = self.tabBar.items else { return }
        items[0].image = UIImage(systemName: "square.grid.2x2")
        items[1].image = UIImage(systemName: "heart")
        items[2].image = UIImage(systemName: "list.bullet.clipboard")
        items[3].image = UIImage(systemName: "person")
    }
    

}
