//
//  Case3TableViewController.swift
//  TableViewControllerPractice
//
//  Created by 은서우 on 2024/01/05.
//

import UIKit

class Case3TableViewController: UITableViewController {
    
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var HeaderBox: UIView!
    @IBOutlet var addTextField: UITextField!
    
    struct shoppingList {
        var label: String
        var isBookmark: Bool = false
        var isChecked: Bool = false
    }
    
    var list: [shoppingList] = [shoppingList(label: "그립톡 구매하기", 
                                             isBookmark: true,
                                             isChecked: true),
                                shoppingList(label: "사이다 구매"),
                                shoppingList(label: "아이패드 케이스 최저가 알아보기",
                                             isBookmark: true),
                                shoppingList(label: "양말", 
                                             isBookmark: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
    
    
    // tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell") as! ShoppingTableViewCell
        
        cell.ShoppingLabel.text = list[indexPath.row].label
        cell.shoppingBox.backgroundColor = .systemGray6
        cell.shoppingBox.layer.cornerRadius = 15
        
        // 각 행의 체크박스와 북마크에 인덱스 부여
        cell.checkBox.tag = indexPath.row
        cell.bookmark.tag = indexPath.row
        //IBAction을 코드로 연결
        cell.checkBox.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
        cell.bookmark.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
        
        //체크박스
        list[indexPath.row].isChecked ?  cell.checkBox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal) :  cell.checkBox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        
        // 북마크
        list[indexPath.row].isBookmark ?  cell.bookmark.setImage(UIImage(systemName: "star.fill"), for: .normal) :  cell.bookmark.setImage(UIImage(systemName: "star"), for: .normal)
        
        
        return cell
    }
    
    @objc func tapBtn(_ sender: UIButton){
        
        
        if sender.currentImage == UIImage(systemName: "star.fill") || sender.currentImage == (UIImage(systemName: "star")) {
            print("\(sender.tag)번째 북마크를 눌렀습니다.")
            list[sender.tag].isBookmark.toggle()
        } else {
            print("\(sender.tag)번째 체크박스를 눌렀습니다.")
            list[sender.tag].isChecked.toggle()
        }
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    
    //button
    @IBAction func tapAddBtn(_ sender: UIButton) {
        
        guard let text = addTextField.text, !text.isEmpty else {return}
        
        list.append(shoppingList(label: text))
        addTextField.text = nil
        
        tableView.reloadData()
        
        view.endEditing(true)
    }
    
    //textfield return 누르면 keyboard 내려감
    @IBAction func tapreturnTextFiedl(_ sender: Any) {
        
    }
    
}
