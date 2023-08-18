//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 정경우 on 2023/08/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

protocol CollectionViewAttributeProtocol {
    
    func configureCollectionView()
    func configureCollectionViewLayout()
    
}

class PosterViewController: UIViewController {
    
    @IBOutlet var posterCollectionView: UICollectionView!
    //구조체 안에 배열이 있기 때문에(results) [Recommandation] 에 [] 생략가능 //구조체 순서에 맞게 써야함
    var list: Recommandation = Recommandation(page: 0, totalResults: 0, totalPages: 0, results: [])
    var secondList: Recommandation = Recommandation(page: 0, totalResults: 0, totalPages: 0, results: [])
    var thirdList: Recommandation = Recommandation(page: 0, totalResults: 0, totalPages: 0, results: [])
    var fourthList: Recommandation = Recommandation(page: 0, totalResults: 0, totalPages: 0, results: [])
    
    var listArray: [Recommandation] { [list, secondList, thirdList, fourthList] }
    // lazy 타입 저장 차이점? 메모리
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        LottoManager.shared.callLotto { bonus, number in
        //            print("클로저로 꺼내온 값: \(bonus), \(number)")
        //        }
        
        configureCollectionView()
        configureCollectionViewLayout()
        
        let group = DispatchGroup()
        let id = [673, 674, 675, 675]
        for item in id {
            group.enter()
            callRecommandation(id: item) { data in
                //data 2차원배열로 append?
                if item == 673 {
                    self.list = data
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.posterCollectionView.reloadData()
        }
        
    }
    
    @IBAction func sendNotification(_ sender: UIButton) {
        
        //포그라운드에서 알림이 안뜨는게 디폴트
        
        //1.컨텐츠 2.언제 -> 알림 보내
        let content = UNMutableNotificationContent()
        content.title = "다마고치에게 \(Int.random(in: 1...10))방울 주세요"
        content.body = "아직 레벨3이에요"
        content.badge = 100
        
        //언제 부분 , timeInterval - 알림 주기
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: true)
        let request = UNNotificationRequest(identifier: "\(Data())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
        
        
    }
    //enter-leave, 비동기
    func dispatchGroupEnterLeave() {
        let group = DispatchGroup()
        
        group.enter() // +1
        callRecommandation(id: 976573) { data in
            self.list = data
            print("1111111111111111")
            group.leave() // -1
        }
        group.enter()
        callRecommandation(id: 565770) { data in
            self.secondList = data
            print("2222222222222222")
            group.leave()
        }
        group.enter()
        callRecommandation(id: 872585) { data in
            self.thirdList = data
            print("33333333333333333")
            group.leave()
        }
        group.enter()
        callRecommandation(id: 615656) { data in
            self.fourthList = data
            print("44444444444444444")
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("END")
            self.posterCollectionView.reloadData()
        }
    }
    // Notify + 비동기함수
    func dispatchGroupNotify() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.callRecommandation(id: 976573) { data in
                self.list = data
                print("1111111111111111")
            }
        }
        DispatchQueue.global().async(group: group) {
            self.callRecommandation(id: 565770) { data in
                self.secondList = data
                print("2222222222222222")
            }
        }
        DispatchQueue.global().async(group: group) {
            self.callRecommandation(id: 872585) { data in
                self.thirdList = data
                print("33333333333333333")
            }
        }
        DispatchQueue.global().async(group: group) {
            self.callRecommandation(id: 615656) { data in
                self.fourthList = data
                print("44444444444444444")
            }
        }
        
        group.notify(queue: .main) {
            print("END")
            self.posterCollectionView.reloadData()
        }
    }
    
    func callRecommandation(id: Int, completionHandler: @escaping (Recommandation) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(Key.TMDBKey)&language=ko-KR"
        
        AF.request(url).validate(statusCode: 200...500)
            .responseDecodable(of: Recommandation.self) { response in
                
                switch response.result {
                case.success(let value):
                    
                    completionHandler(value)
                    
                    //self.list = value
                    //self.posterCollectionView.reloadData()
                    
                case.failure(let error):
                    print(error)
                    
                }
            }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        super.viewDidAppear(animated)
        //        showAlert(title: "테스트 얼럿", message: "메세지", button: "배경색 변경") {
        //            print("저장 버튼 클릭")
        //            self.posterCollectionView.backgroundColor = .lightGray
        //        }
        //        print("AAA")
    }
    
    
}



extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 4
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return section == 0 ? list.results.count : section == 1 ? secondList.results.count : 9
        
        if section == 0 {
            return list.results.count
        } else if section == 1 {
            return secondList.results.count
        } else if section == 2 {
            return thirdList.results.count
        } else if section == 3 {
            return fourthList.results.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        
        
        if indexPath.section == 0 {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(list.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
            
        } else if indexPath.section == 1 {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(secondList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
            
        } else if indexPath.section == 2 {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(thirdList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
            
        } else if indexPath.section == 3{
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(fourthList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
            
        }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return cell
        //nil 제거법?
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView() }
            
            view.titleLable.text = "테스트 섹션"
            view.titleLable.font = UIFont(name: "CJU-Light", size: 20)
            return view
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    
}

extension PosterViewController: CollectionViewAttributeProtocol {
    
    func configureCollectionView() {
        //Protocol as Type
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        posterCollectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        posterCollectionView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectionView.collectionViewLayout = layout
    }
    
}

