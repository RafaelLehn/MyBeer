//
//  DataBaseHelper.swift
//  MyBeer
//
//  Created by Ana Luiza on 4/14/23.
//

import Foundation
import UIKit
import CoreData

class DataBaseHelper {

    
    private let controller: NSFetchedResultsController<Beer>
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {fatalError()}
        let request = Beer.fetchRequest()
        let managedContext = appDelegate.persistentContainer.viewContext
        controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func requestFavorites(completion: @escaping ((Result<[Beer], Error>) -> Void)) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError()}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Beer")

        controller.managedObjectContext.performAndWait {
   
            do {
                try self.controller.performFetch()
                let savedMovies = try managedContext.fetch(fetchRequest) as? [Beer]
                completion(.success(savedMovies ?? []))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func save(beerToSave: BeerToCoreData) {
        controller.managedObjectContext.performAndWait {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Beer",in: managedContext)!
            let beer = Beer(entity: entity, insertInto: managedContext)
                 
            beer.name = beerToSave.name
            beer.imageUrl = beerToSave.imageURL
            beer.summary = beerToSave.description
            beer.id = beerToSave.id
            
            self.controller.managedObjectContext.insert(beer)
            try? self.controller.managedObjectContext.save()
        }
    }
    
    func delete(beer: Beer) {
        
        controller.managedObjectContext.performAndWait {
            self.controller.managedObjectContext.delete(beer)
            try? self.controller.managedObjectContext.save()
        }
    }
    
}


@objc(Beer)
public class Beer: NSManagedObject {
    

}


extension Beer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beer> {
       
        let request = NSFetchRequest<Beer>(entityName:"Beer")
        request.sortDescriptors = []
        return request
        
    }

    @NSManaged public var name: String
    @NSManaged public var summary: String
    @NSManaged public var imageUrl: String
    @NSManaged public var id: Int

}

extension Beer : Identifiable {

}
