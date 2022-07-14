//
//  UIViewController+Alert.swift
//  note
//
//  Created by 윤하늘 on 2022/07/12.
//

import UIKit

extension UIViewController {
    func alert(title: String = "알림", message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ///preferredStyle -> actionSheet, alert
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction) ///생성 버튼을 alertController 에 추가하기
        
        present(alert, animated: true, completion: nil)
    }
}
