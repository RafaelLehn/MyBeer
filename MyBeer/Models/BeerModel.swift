//
//  BeerModel.swift
//  MyBeer
//
//  Created by Ana Luiza on 4/12/23.
//

struct BeerModel: Codable {
    let id: Int
    let name, tagline, firstBrewed, description: String?
    let imageURL: String?
//    let abv: Double
//    let ibu, targetFg, targetOg, ebc: Int
//    let srm: Int
//    let ph, attenuationLevel: Double
//    let volume, boilVolume: BoilVolume
//    let method: Method
//    let ingredients: Ingredients
//    let foodPairing: [String]
//    let brewersTips, contributedBy: String
    
    init(id: Int, name: String, tagline: String, firstBrewed: String, description: String, imageURL: String, abv: Double, ibu: Int, targetFg: Int, targetOg: Int, ebc: Int, srm: Int, ph: Double, attenuationLevel: Double, volume: BoilVolume, boilVolume: BoilVolume, method: Method, ingredients: Ingredients, foodPairing: [String], brewersTips: String, contributedBy: String) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.firstBrewed = firstBrewed
        self.description = description
        self.imageURL = imageURL
//        self.abv = abv
//        self.ibu = ibu
//        self.targetFg = targetFg
//        self.targetOg = targetOg
//        self.ebc = ebc
//        self.srm = srm
//        self.ph = ph
//        self.attenuationLevel = attenuationLevel
//        self.volume = volume
//        self.boilVolume = boilVolume
//        self.method = method
//        self.ingredients = ingredients
//        self.foodPairing = foodPairing
//        self.brewersTips = brewersTips
//        self.contributedBy = contributedBy
    }

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
//        case abv, ibu
//        case targetFg = "target_fg"
//        case targetOg = "target_og"
//        case ebc, srm, ph
//        case attenuationLevel = "attenuation_level"
//        case volume
//        case boilVolume = "boil_volume"
//        case method, ingredients
//        case foodPairing = "food_pairing"
//        case brewersTips = "brewers_tips"
//        case contributedBy = "contributed_by"
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let value: Double
    let unit: String
}

// MARK: - Ingredients
struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String
}

// MARK: - Hop
struct Hop: Codable {
    let name: String
    let amount: BoilVolume
    let add, attribute: String
}

// MARK: - Malt
struct Malt: Codable {
    let name: String
    let amount: BoilVolume
}

// MARK: - Method
struct Method: Codable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation
    }
}

// MARK: - Fermentation
struct Fermentation: Codable {
    let temp: BoilVolume
}

// MARK: - MashTemp
struct MashTemp: Codable {
    let temp: BoilVolume
    let duration: Int
}


struct BeerToCoreData : Codable {
    var name: String
    var imageURL : String
    var description : String
    var id : Int
}
