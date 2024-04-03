//
//  ShoppingTableViewCell.swift
//  TableViewControllerPractice
//
//  Created by 은서우 on 2024/01/08.
//

import UIKit
import RxSwift

class ShoppingTableViewCell: UITableViewCell {
    
    @IBOutlet var checkBox: UIButton!
    @IBOutlet var ShoppingLabel: UILabel!
    @IBOutlet var bookmark: UIButton!
    @IBOutlet var shoppingBox: UIView!
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 셀 재사용 시, DisposeBag 초기화
        disposeBag = DisposeBag()
    }
    
    func configure(item: shoppingList) {
        ShoppingLabel.text = item.label
        checkBox.setImage(UIImage(systemName: item.isChecked ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
        bookmark.setImage(UIImage(systemName: item.isBookmark ? "star.fill" : "star"), for: .normal)
    }
    
}
