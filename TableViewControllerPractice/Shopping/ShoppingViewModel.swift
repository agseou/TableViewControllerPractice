//
//  ShoppingViewModel.swift
//  TableViewControllerPractice
//
//  Created by eunseou on 4/1/24.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingViewModel {
    
    let item = PublishSubject<shoppingList>()
    
    let disposeBag = DisposeBag()
    
    init() {
        
    }
    
}
