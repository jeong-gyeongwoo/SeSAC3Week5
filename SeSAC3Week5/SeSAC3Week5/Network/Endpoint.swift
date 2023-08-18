//
//  Endpoint.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import Foundation
    //CaseIterable 모든 case를 배열로
enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    // test: 인스턴스 연산 프로퍼티 -> 값을 저장하고 있지는 않고, 값울 사용할 수있는 통로로서의 역할만 담당
    // 그래서 static 없어도 가능
//     var test: URL {
//        return URL(string: "https://naver.com")!
//    }
    
    // 끼리끼리 놀아야함, static을 빼면 인스턴스 연산 프로퍼티인데 타입 연산 프로퍼티를 써서 오류가 나는것
    static var photo: URL {
        return URL(string: baseURL + self.allCases.randomElement()!.rawValue)!
    }
    
    
    //Nasa.baseURL -> baseURL이 타입 프로퍼티임을 명시, 명시가 없으면 타입인지 인스턴스 프로퍼티 인지 몰라서 못씀
    var test2: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
   
    
}

