//
//  BeerDetailViewModel.swift
//  MyBeer
//
//  Created by Ana Luiza on 4/14/23.
//


final class BeerDetailViewModel {

    private let coordinator: MainCoordinator
    var beer: BeerModel
    
    init(coordinator: MainCoordinator, beer: BeerModel) {
        self.coordinator = coordinator
        self.beer = beer
    }
}


