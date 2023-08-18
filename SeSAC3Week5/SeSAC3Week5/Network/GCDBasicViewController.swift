//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //serialSync()
        //serialAsync()
        //globalSync()
        //globalAsync()
        // globalAsyncTwo()
        dispatchGroup()
    }
    
    func dispatchGroup() {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in  1...100 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in  101...200 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in  201...300 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in  301...400 {
                print(i, terminator: " ")
            }
        }
        // 신호를 어디서 받을 건지 - main
        group.notify(queue: .main) {
            print("END")
        }
        
        
        
        
    }
    
    
    func globalAsyncTwo() {
        
        print("Start")
        
        for i in 1...100 {
            DispatchQueue.global().async {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...150 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
        
        
    }
    
    
    
    
    
    
    
    func globalAsync() {
        print("Start")
        
        DispatchQueue.global().async {
            for i in 1...10 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 11...20 {
            sleep(1)
            print(i, terminator: " ")
        }
        print("End")
    }
    
    func globalSync() {
        print("Start")
        
        DispatchQueue.global().sync { //주로 네트워크 통신
            for i in 1...10 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 11...20 {
            sleep(1)
            print(i, terminator: " ")
        }
        print("End")
    }
    
    
    func serialAsync() {
        print("Start")
        
        DispatchQueue.main.async {
            for i in 1...10 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 11...20 {
            sleep(1)
            print(i, terminator: " ")
        }
        print("End")
    }
    
    
    
    
    
    
    
    func serialSync() {
        print("Start")
        
        for i in 1...10 {
            sleep(1)
            print(i, terminator: " ")
        }
        //        // 무한 대기 상태, 데드락(deadlock,교착 상태)
        //        DispatchQueue.main.sync {
        //            for i in 11...20 {
        //                sleep(1)
        //                print(i, terminator: " ")
        //            }
        print("End")
    }
    
    
    
    
}

