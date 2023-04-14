//
//  HomeViewModel.swift
//  MyBeer
//
//  Created by Ana Luiza on 4/12/23.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func presentBeers()
}

final class HomeViewModel {

    private let coordinator: MainCoordinator
    var beers: [BeerModel] = []
    var favorites : [Beer] = []
    private let network: ServiceRequestProtocol
    
    var coreData = DataBaseHelper()

    weak var delegate: HomeViewModelDelegate?
    
    init(coordinator: MainCoordinator, network: ServiceRequestProtocol) {
        self.coordinator = coordinator
        self.network = network
    }

    public func getBeers(id: Int) {
        network.makeRequest(id: id) { result in
            switch result {
            case .success(let beers):
                guard let beers = beers else {
                    print("No users were returned.")
                    return
                }
                self.beers.append(contentsOf: beers)
                self.delegate?.presentBeers()
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    public func goToDetail(beer: BeerModel) {
        coordinator.goToBeerDetail(beer: beer)
    }

    func buttonHeartTappedAt(beerIndex: Int){
       let toFavorite = beers[beerIndex]
        guard let favoriteName = toFavorite.name else {
            return
        }
        if checkFavorite(beerName: favoriteName){
            let favMovie = favorites.filter { item in item.name.contains(favoriteName) }
            deleteFavorite(beer: favMovie[0])
            fetchCoreData()

        } else {
            saveFavorite(beer: toFavorite)
            fetchCoreData()
        }
    }
    

    func checkFavorite(beerName: String) -> Bool{return favorites.contains(where: {$0.name == beerName})}

    func deleteFavorite(beer: Beer) { coreData.delete(beer: beer) }

    func saveFavorite(beer: BeerModel){
        
        guard let beerName = beer.name else { return }
        guard let beerImageUrl = beer.imageURL else { return }
        guard let beerDescription = beer.description else { return }
        

        let favoriteBeer: BeerToCoreData = BeerToCoreData(

            name: beerName, imageURL: beerImageUrl, description: beerDescription, id: beer.id
        )

        coreData.save(beerToSave: favoriteBeer)
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
