//
//  CoreDataManager.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 19.01.2021..
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }

        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext

        return context
    }()
    
    //CREATE
    
    static func save(named name: String) {
        var cityEntities: [CityEntity]
        let fetchRequest = CityEntity.fetchRequest() as NSFetchRequest<CityEntity>
        let predicate = NSPredicate(format: "name = name", true)
        
        fetchRequest.predicate = predicate
        
        do{
            cityEntities = try context.fetch(fetchRequest)
            let cities = cityEntities.map({
                return $0.name
            })
            if cities.contains(name) {
                return
            } else {
                let newEntity = CityEntity(context: context)
                newEntity.name = name
                do {
                    try self.context.save()
                }
                catch {
                    fatalError("Error saving city")
                }
            }
            
        }
        catch {
            fatalError("Error searching db")
        }
    }
    
    //READ
    static func fetchCities() -> [String] {
        var savedCities: [CityEntity]
        let fetchRequest = CityEntity.fetchRequest() as NSFetchRequest<CityEntity>
        
        do{
            savedCities = try context.fetch(fetchRequest)
            let cityNames = savedCities.map { (city) -> String in
                return city.name!
            }
            return cityNames
        }
        catch {
            
        }
        return [String]()
    }
    
    //DELETE
    static func deleteCity(named name: String) {
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CityEntity")
        let predicate = NSPredicate(format: "name == %@", name)
        deleteRequest.predicate = predicate
        
        if let result = try? context.fetch(deleteRequest) {
            for object in result {
                context.delete(object as! NSManagedObject)
            }
        }
        
        do {
            try context.save()
        } catch {
            fatalError("Cannot delete city")
        }
    }
    
    static func deleteAllData() {
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: "CityEntity")
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do {
            try context.execute(DelAllReqVar)
            
        }
        catch { print(error) }
    }
}
