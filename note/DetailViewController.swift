//
//  DetailViewController.swift
//  note
//
//  Created by SKY YOUN on 2022/07/12.
//

import UIKit

class DetailViewController: UIViewController {
    //이전에 입력한 메모 저장
    var memo: Memo? //이전에 입력한 메모 저장. 뷰 컨트롤러가 초기화되는 시점에는 값이 없기때문에 옵셔널로 선언
    
    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
            

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
}

extension DetailViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath )
            cell.textLabel?.text = memo?.content
            
            return cell
    
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath )
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            return cell
            
        default:
            fatalError()
        }
    }
}
