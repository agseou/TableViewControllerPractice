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
    
    var list: [String] = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HeaderBox.backgroundColor = .systemGray6
        HeaderBox.layer.cornerRadius = 15
        addBtn.backgroundColor = .systemGray5
        addBtn.setTitleColor(.black, for: .normal)
        addBtn.layer.cornerRadius = 10
        addTextField.backgroundColor = .systemGray6

    }
    
    
    // tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell") as! ShoppingTableViewCell
        
        cell.ShoppingLabel.text = list[indexPath.row]
        cell.shoppingBox.backgroundColor = .systemGray6
        cell.shoppingBox.layer.cornerRadius = 15
        
        return cell
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    //button
    @IBAction func tapAddBtn(_ sender: UIButton) {
        
        guard let text = addTextField.text, !text.isEmpty else {return}
        
        list.append(text)
        addTextField.text = nil
        
        tableView.reloadData()
        
        view.endEditing(true)
    }
    
    //textfield return 누르면 keyboard 내려감
    @IBAction func tapreturnTextFiedl(_ sender: Any) {
        
    }
    
}
