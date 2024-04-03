//
//  Case3TableViewController.swift
//  TableViewControllerPractice
//
//  Created by 은서우 on 2024/01/05.
//

import UIKit
import RxSwift
import RxCocoa


struct shoppingList {
    var label: String
    var isBookmark: Bool = false
    var isChecked: Bool = false
}

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var HeaderBox: UIView!
    @IBOutlet var addTextField: UITextField!
    
    var list: [shoppingList] = [shoppingList(label: "그립톡 구매하기",
                                             isBookmark: true,
                                             isChecked: true),
                                shoppingList(label: "사이다 구매"),
                                shoppingList(label: "아이패드 케이스 최저가 알아보기",
                                             isBookmark: true),
                                shoppingList(label: "양말",
                                             isBookmark: true)
    ]
    
    lazy var items = BehaviorSubject(value: list)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        configureView()
        configureBind()
    }
    
    func configureView() {
        
        // UI 꾸미기
        HeaderBox.backgroundColor = .systemGray6
        HeaderBox.layer.cornerRadius = 15
        addBtn.backgroundColor = .systemGray5
        addBtn.setTitleColor(.black, for: .normal)
        addBtn.layer.cornerRadius = 10
        addTextField.backgroundColor = .systemGray6
        
        // 모든 행 높이 설정
        tableView.rowHeight = 53
    }
    
    func configureBind() {
        
        //        addTextField.rx.text
        //            .orEmpty
        //            .debounce(.milliseconds(5000), scheduler: MainScheduler.instance)
        //            .distinctUntilChanged()
        //            .subscribe(with: self) { owner, value in
        //                print("====\(value)====")
        //                owner.list.append(shoppingList(label: value))
        //                owner.items.onNext(owner.list)
        //            }
        //            .disposed(by: disposeBag)
        
        // 기존에 연결되어있는 IBOUTLETACTION을 끊어야 작동함!
        // 끊지않으면 unrecognized selector sent to instance... 이런 오류 발생
        addBtn.rx.tap
            .bind(with: self) { owner, _ in
                print("Add Button Tapped")
                guard let text = owner.addTextField.text, !text.isEmpty else { return }
                // 리스트에 새 항목 추가
                owner.list.append(shoppingList(label: text))
                owner.items.onNext(owner.list)
                owner.addTextField.text = nil
                print("Added Item: \(text)")
            }
            .disposed(by: disposeBag)
        
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "ShoppingTableViewCell", cellType: ShoppingTableViewCell.self)) { (row, element, cell) in
                
                cell.configure(item: element)
                cell.shoppingBox.backgroundColor = .systemGray6
                cell.shoppingBox.layer.cornerRadius = 15
                cell.configure(item: element)
                
                //IBAction -> RX로
                cell.checkBox.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.list[row].isChecked.toggle()
                        owner.items.onNext(owner.list)
                        cell.configure(item: element)
                    }
                    .disposed(by: cell.disposeBag)
                cell.bookmark.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.list[row].isBookmark.toggle()
                        owner.items.onNext(owner.list)
                        cell.configure(item: element)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        // 셀 밀어서 삭제
        tableView.rx.itemDeleted
            .bind(with: self) { owner, idx in
                owner.list.remove(at: idx.row)
                owner.items.onNext(owner.list)
            }
            .disposed(by: disposeBag)
    }
    
    
    // textfield return 누르면 keyboard 내려감
    @IBAction func tapreturnTextField(_ sender: Any) { }
    
}

