//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by 정경우 on 2023/08/16.
//

import UIKit
import Alamofire

//열거형은 컴파일타임! 컴파일 시 오류 타입을 알 수 있음
enum VaildationError: Int, Error {
    //몇 번 에러인지 명시 가능
    case emptyString = 404
    case isNotInt = 401
    case isNotDate = 500
}





class CodableViewController: UIViewController {
    @IBOutlet var tempLable: UILabel!
    @IBOutlet var humidityLable: UILabel!
    
    
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var dateTextField: UITextField!
    
    var resultText = "Apple"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeahterManager.shared.callReqestCodable { data in
            self.tempLable.text = "\(data.main.temp)"
        } fail: {
            print("show Alert")
        }

        
        
        // 기능분리후 데이터를 통으로 가져와서 데이터 보여주기
        WeahterManager.shared.callReqestJSON { json in
            let temp = json["main"]["temp"].doubleValue - 273.15
            let humidity = json["main"]["humidity"].intValue
            
            self.humidityLable.text = "\(humidity)"
            self.tempLable.text = "\(temp)"
        }
        // 기능분리후 데이터만 가져와서 보여주기
        WeahterManager.shared.callReqestString { temp, humidity in
            self.humidityLable.text = humidity
            self.tempLable.text = temp
        }
        
         // fetchLottoData()
        //fetchTranslateData(source: "ko", target: "en", text: "안녕")
           
    }
    
        func fetchLottoData() {
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
            // 요청은 순서대로나 응답은 순서가 없다
            DispatchQueue.global().async {
                AF.request(url, method: .get).validate()
                    .responseData { response in
                        guard let value = response.value else { return }
                        print("responseData:", value)
    
                        DispatchQueue.main.async {
                            //레이블에 숫자 출력 - UI
    
                        }
    
    
    
                    }
            }
    
    
    
            AF.request(url, method: .get).validate()
                .responseString { response in
                    guard let value = response.value else { return }
                    print("responseString:", value)
                }
    
            AF.request(url, method: .get).validate()
                .response { response in
                    guard let value = response.value else { return }
                    print("response:", value)
                }
    
            AF.request(url, method: .get).validate()
                .responseDecodable(of: Lotto.self) { response in
                    guard let value = response.value else { return }
                    print("responseDecodable:", value)
                    print(value.bnusNo, value.drwtNo3)
                    // self.label = value.bnusNo 이런식으로 활용
                }
    
        }
    
    //    func fetchTranslateData(source: String, target: String, text: String) {
    //
    //        print("fetchTranslateData", source, target, text)
    //
    //        let url = "https://openapi.naver.com/v1/papago/n2mt"
    //        let header: HTTPHeaders = [
    //            "X-Naver-Client-Id": Key.clientID,
    //            "X-Naver-Client-Secret": Key.clientSecret
    //        ]
    //        let parameters: Parameters = [
    //            "source": source,
    //            "target": target,
    //            "text": text
    //        ]
    //
    //        AF.request(url, method: .post, parameters: parameters, headers: header)
    //            .validate(statusCode: 200...500)
    //            .responseDecodable(of: Translation.self) { response in
    //
    //                guard let value = response.value else { return }
    //                print(value.message.result.translatedText)
    //                // 응답값으로 한번 더 요청해 응답값 받기 (영어번역 -> 한글로)
    //
    //                self.resultText = value.message.result.translatedText
    //
    //                print("확인", self.resultText )
    //
    //                self.fetchTranslate(source: "en", target: "ko", text: self.resultText)
    //
    //
    //            }
    //
    //    }
    //
    //
    //    func fetchTranslate(source: String, target: String, text: String) {
    //
    //        print("fetchTranslateData", source, target, text)
    //
    //        let url = "https://openapi.naver.com/v1/papago/n2mt"
    //        let header: HTTPHeaders = [
    //            "X-Naver-Client-Id": Key.clientID,
    //            "X-Naver-Client-Secret": Key.clientSecret
    //        ]
    //        let parameters: Parameters = [
    //            "source": source,
    //            "target": target,
    //            "text": text
    //        ]
    //
    //        AF.request(url, method: .post, parameters: parameters, headers: header)
    //            .validate(statusCode: 200...500)
    //            .responseDecodable(of: Translation.self) { response in
    //
    //                guard let value = response.value else { return }
    //                print(value.message.result.translatedText)
    //
    //                self.resultText = value.message.result.translatedText
    //
    //                print("최종확인", self.resultText )
    //
    //            }
    //
    //    }
    //
    
    func vaildDateUserInputError(text: String) throws -> Bool {
        
        // 빈 칸일 때 , !(text.isEmpty) == (text.isEmpty == false)
        guard !(text.isEmpty) else {
            print("빈 값")
            throw VaildationError.emptyString
        }
    
        // 숫자 여부 -> 더 간결하게?
        guard Int(text) != nil else {
            print("숫자 아님")
            throw VaildationError.isNotInt
        }
        
        //날짜 형식으로 변환 되는지
        guard checkDateFormat(text: text) else {
            print("잘못된 날짜 형식")
            throw VaildationError.isNotDate
        }
        
        return true
        
    }
    
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        guard let text = dateTextField.text else { return }
  
        do {
            let result = try vaildDateUserInputError(text: text)
            
        } catch {
            print("ERROR")
            //스위치문을 통해 에러별 분기처리 가능
        }
        
//        if vaildDateUserInput(text: text) {
//            print("검색 가능, 네트워크 요청 가능")
//        } else {
//            print("검색 불가")
//        }
    }
    
    
    func vaildDateUserInput(text: String) -> Bool {
        
        // 빈 칸일 때 , !(text.isEmpty) == (text.isEmpty == false)
        guard !(text.isEmpty) else {
            print("빈 값")
            return false
        }
    
        // 숫자 여부 -> 더 간결하게?
        guard Int(text) != nil else {
            print("숫자 아님")
            return false
        }
        
        //날짜 형식으로 변환 되는지
        guard checkDateFormat(text: text) else {
            print("잘못된 날짜 형식")
            return false
        }
        
        return true
        
    }

    func checkDateFormat(text: String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        let result = format.date(from: text)
        
        return result == nil ? false : true
    }
    
    
    
    
    
    
}

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

struct Translation: Codable {
    let message: Message
}
// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: Result
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}
// MARK: - Result
struct Result: Codable {
    let engineType, tarLangType, translatedText, srcLangType: String
}
