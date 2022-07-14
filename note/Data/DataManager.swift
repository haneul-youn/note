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
    
    //테이블뷰에 표시되어있는 데이터가 저장되어있음
    var memoList = [Memo]()
    //배열이 저장되어있지 않기 떄문에 새로운 코드가 업데이트되지 않음
    
    
    
    
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
    
    func addNewMemo(_ memo : String?) {
        let newMemo = Memo(context: mainContext) //새로운 memo 생성, 여기서 Memo는 data에서 만들어준것이기 때문에 새로운 생성자로 context : 를 전달해야함
        newMemo.content = memo
        newMemo.insertDate = Date()
        
        // 여기서 생성된 메모를 memoList배열에 바로 저장하기 -> 불필요한 작업이 생략됨
        memoList.insert(newMemo, at: 0)  
        //insert 메소드를 사용함으로써 배열 가장 앞부분에 로드 됨
        //append는 후에 생성되는 메모들이 저장되는 형식
        
        //context를 저장하는 메소드
        saveContext()
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
