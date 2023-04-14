//
//  MainCoordinator.swift
//  MyBeer
//
//  Created by Rafael on 4/12/23.
//

import Foundation

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    
    func start() {
        let viewModel = LoginViewModel(coordinator: self)
        let vc = LoginViewController(viewModel: viewModel)
        navigationController.navigationBar.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        navigationController.pushViewController(vc, animated: true)
    }

    func goToHome() {
        let network = ServiceRequest()
        let homeViewModel = HomeViewModel(coordinator: self, network: network)
        let favoritsViewModel = FavoritsViewModel(coordinator: self)
//        let actorsViewModel = ActorsViewModel(coordinator: self, network: network)
        let vc = DashboardTabBarController(homeViewModel: homeViewModel, favoritsViewModel: favoritsViewModel)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: true)
    }

    func goToBeerDetail(beer: BeerModel) {
        let viewModel = BeerDetailViewModel(coordinator: self, beer: beer)
        let vc = BeerDetailViewController(viewModel: viewModel)
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
//
//    func goToEpisodeDetail(episode: EpisodeModel) {
//        let viewModel = EpisodeViewModel(coordinator: self, episode: episode)
//        let vc = EpisodeViewController(viewModel: viewModel)
//        navigationController.navigationBar.isHidden = false
//        navigationController.pushViewController(vc, animated: true)
//    }
//
//    func goToActorDetail(show: ActorsModel) {
//        let network = NetworkRequests()
//        let viewModel = ActorsDetailViewModel(coordinator: self, actor: show, network: network)
//        let vc = ActorsDetailViewController(viewModel: viewModel)
//        navigationController.navigationBar.isHidden = false
//        navigationController.pushViewController(vc, animated: true)
//    }
    
    
}

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    private let homeViewModel: HomeViewModel
    private let favoritsViewModel: FavoritsViewModel
//    private let actorsViewModel: ActorsViewModel
    
    init(homeViewModel: HomeViewModel, favoritsViewModel: FavoritsViewModel) {
        self.homeViewModel = homeViewModel
        self.favoritsViewModel = favoritsViewModel
//        self.actorsViewModel = actorsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        self.tabBar.barTintColor = .black
        navigationController?.navigationBar.isHidden = true
        let item1 = HomeViewController(viewModel: homeViewModel)
        let icon1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        item1.tabBarItem = icon1

        
        let item2 = FavoritsViewController(viewModel: favoritsViewModel)
        let icon2 = UITabBarItem(title: "Favorits", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        item2.tabBarItem = icon2
        
        
        let controllers = [item1, item2]
        self.viewControllers = controllers
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true;
    }
}
