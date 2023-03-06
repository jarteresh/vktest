//
//  AllGroupsTableVC.swift
//  Vk client
//
//  Created by Ярослав on 03.02.2023.
//

import UIKit
import SDWebImageSwiftUI

class AllGroupsTableVC: UITableViewController {
    
    var displayedGroups: [Group]?
    
    let service = Service()
    
    private let reuseIdentifier = "AllGroupsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AllGroupsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        Service().getGroupsBySearch(forName: "Apple") { data in
            self.displayedGroups = Array(data.groups)
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AllGroupsTableViewCell
        
        guard let groups = displayedGroups else {return cell}
        let group = groups[indexPath.row]
        
        cell.avatar.imageView.sd_setImage(with: URL(string: group.avatar))
        cell.name.text = group.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        service.saveAddedGroup(group: displayedGroups![indexPath.row].name)
        self.navigationController?.popViewController(animated: true)
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "followGroup",
//              let followedGroupsTableVC = segue.destination as? FollowedGroupsTableVC,
//              let indexPath = sender as? IndexPath
//        else {return}
//        let group = displayedGroups[indexPath.row]
//        if !followedGroupsTableVC.followedGroups.contains(group) {
//            followedGroupsTableVC.followedGroups.append(group)
//            followedGroupsTableVC.tableView.reloadData()
//        }
//
//        let index = groupsList.firstIndex(of: group) ?? 0
//        groupsList[index].isSubscribed = true
//        updateDisplayedGroups()
//        tableView.reloadData()
//    }
}
