//
//  ViewController.swift
//  todoey
//
//  Created by moamen alaa on 5/1/18.
//  Copyright © 2018 moamen. All rights reserved.
//

import UIKit


class ToDoListViewController: UITableViewController{
let itemArray = ["find mike", "buy eggos", "destroy" ]
    override func viewDidLoad() {
        super.viewDidLoad()
     tableView.delegate = self
        tableView.delegate = self
        
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todolistcell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(itemArray[indexPath.row])\(indexPath.row).")
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

