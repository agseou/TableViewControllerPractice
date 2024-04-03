//
//  Case2TableViewController.swift
//  TableViewControllerPractice
//
//  Created by 은서우 on 2024/01/05.
//

import UIKit

class SettingTableViewController: UITableViewController {

    let settingList: [[String]] = [["공지사항", "실험실", "버전 정보"],
                                   ["개인/보안", "알림", "채팅"],
                                   ["고객센터"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell")!
        
        if indexPath.section == 0 {
            cell.textLabel?.text = settingList[0][indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = settingList[1][indexPath.row]
        } else {
            cell.textLabel?.text = settingList[2][indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "전체 설정"
        } else if section == 0 {
            return "개인 설정"
        } else {
            return "기타"
        }
    }

}
