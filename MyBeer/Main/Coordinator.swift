//
//  Coordinator.swift
//  MyBeer
//
//  Created by Rafael on 4/12/23.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    func start()
    func goToHome()
    func goToBeerDetail(beer: BeerModel)
//    func goToActorDetail(show: ActorsModel)
//    func goToEpisodeDetail(episode: EpisodeModel)
}
