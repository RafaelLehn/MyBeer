//
//  FavoritsViewModel.swift
//  MyBeer
//
//  Created by Ana Luiza on 4/14/23.
//

import Foundation

protocol FavoritsViewModelDelegate: AnyObject {
    func showRemovedFavorits()
}

final class FavoritsViewModel {

    private let coordinator: MainCoordinator
    var favorites : [Beer] = []

    var coreData = DataBaseHelper()

    weak var delegate: FavoritsViewModelDelegate?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToDetail(beer: BeerModel) {
        coordinator.goToBeerDetail(beer: beer)
    }
    
    func deleteFavorite(beer: Beer) {
        coreData.delete(beer: beer)
        self.delegate?.showRemovedFavorits()
        
    }
    
    func fetchCoreData(){
        coreData.requestFavorites { (favoritesMoviesCoreData:Result<[Beer], Error>) in
            switch favoritesMoviesCoreData {
            case.success(let favoritesMoviesCoreData):
                self.favorites = favoritesMoviesCoreData
            case.failure(let error):
                print(error)
            }
        }
    }

}
