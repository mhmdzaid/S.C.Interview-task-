//
//  Storage.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation
import CoreData

class Storage: RepositoryDataSource {
    let entity = "UserEntity"
    static let shared = Storage()
    var mapper: Mapper = UsersMapper()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UsersApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func fetchObjects() ->  [UserEntity] {
        let request = NSFetchRequest<UserEntity>(entityName: entity)
        do {
            let result = try context.fetch(request)
            return result
        } catch let error {
            print("------------\(error.localizedDescription)----------------")
        }
        return []
    }
    
    func fetchUsers() -> [UserViewModel] {
        let result = fetchObjects()
        return mapper.mapUsers(result)
    }
    
    func save(_ user: UserViewModel) {
        let userEntity = NSEntityDescription.insertNewObject(forEntityName: entity, into: context) as? UserEntity
        userEntity?.id = user.id
        userEntity?.name = user.name
        userEntity?.email = user.email
        userEntity?.phone = user.phone
        userEntity?.photo = user.picUrlString ?? ""
        userEntity?.address = user.address
        userEntity?.gender = user.gender
        do {
            try context.save()
        } catch {
            print("Could not save")
        }
    }
    
    
    func delete(_ user: UserViewModel) {
        guard let user = fetchObjects().first(where: {$0.id == user.id}) else {
            return
        }
        context.delete(user)
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
