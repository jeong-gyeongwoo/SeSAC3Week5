//
//  PPPosterCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 정경우 on 2023/08/16.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    @IBOutlet var posterImageView: UIImageView!
    override func awakeFromNib() {
        //정적인 디자인들
        super.awakeFromNib()
        // Initialization code
    }

    //앱을 재사용 할 떄 보통 사용 반복되는 셀의 정보를 막기 위해서
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
    }
    
    
    
    
    
    
}
