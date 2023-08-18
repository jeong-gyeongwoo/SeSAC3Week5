//
//  Extenstion+Alert.swift
//  SeSAC3Week5
//
//  Created by 정경우 on 2023/08/17.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, button: String, completionHandler: @escaping () -> () ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //  option키를 눌러 handler 보이게 하고 (enter) 클로저 생성
        let button = UIAlertAction(title: button, style: .default) { action in
            print("클릭했어요", action.title)
            
            completionHandler()
            
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(button)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
        
    }
}
