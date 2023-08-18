//
//  LottoManager.swift
//  SeSAC3Week5
//
//  Created by 정경우 on 2023/08/17.
//

import Foundation
import Alamofire

//싱글톤, Alamofire는 여기서만 작성하면 된다
class LottoManager {
    
    static let shared = LottoManager()
    // private init() { }
    
    func callLotto(completionHandler: @escaping (Int,Int) -> Void) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
        //통신 /응답
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else { return }
                print("responseDecodable:", value)
                // print(value.bnusNo, value.drwtNo3) -> 내용전달로 변경
                //LottoManager.shared.callLotto()로 호출
                completionHandler(value.bnusNo, value.drwtNo3)
                //  LottoManager.shared.callLotto { bonus, number in
                // print("클로저로 꺼내온 값: \(bonus), \(number)")
            }
                
            }
        
}
    
    
