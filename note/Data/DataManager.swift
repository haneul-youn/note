//
//  DataManager.swift
//  note
//
//  Created by SKY YOUN on 2022/07/14.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
        private init() {
            //single tone
        }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var memoList = [Memo]()
    
    //데이터에서 데이터베이스를 읽어오는 것을 fetch 라고 한다.
    func fetchMemo() {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key:"insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        //날짜를 기준으로 내림차순으로 저장됨
        
        
        //do catch 를 이용하여 호춣해야함 안하면 에러 발생
        
        do{
            
            memoList = try mainContext.fetch(request) //memoList에 저장하기.
        } catch {
            print(error)
        }
    }
    
    
    //MARK: - Core Data Stack
    lazy var persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "memo")
        container.loadPersistentStores(completionHandler: {(storeDescription, error ) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(error), \(nserror.userInfo)")
            }
        }
    }
}
