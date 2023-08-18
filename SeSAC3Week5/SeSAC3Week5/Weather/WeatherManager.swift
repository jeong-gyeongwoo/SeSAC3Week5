//
//  WeatherManager.swift
//  SeSAC3Week5
//
//  Created by 정경우 on 2023/08/17.
//

import Foundation
import SwiftyJSON
import Alamofire

class WeahterManager {
    
    static let shared = WeahterManager()
    
    //Codable
    func callReqestCodable(success: @escaping (WeatherData) -> Void, fail: @escaping () -> Void ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.WeatherKey)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: WeatherData.self) { response in
            
            switch response.result {
            case.success(let value):
                //completionHandler
                success(value)
            
            case.failure(let error):
                print(error)
                //failure()
            }
            
        }
    }
    
    //JSON
    func callReqestJSON(completionHandler: @escaping (JSON) -> Void ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=fba6c31414337e08cd1c788fc40addf7"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                completionHandler(json )
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //특정 데이터만
    func callReqestString(completionHandler: @escaping (String,String) -> Void ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=fba6c31414337e08cd1c788fc40addf7"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
                
                completionHandler("\(temp)도 입니다",  "\(humidity)% 입니다")
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
