//
//  ViewController.swift
//  todoey
//
//  Created by moamen alaa on 5/1/18.
//  Copyright © 2018 moamen. All rights reserved.
//

import UIKit


class ToDoListViewController: UITableViewController{
var itemArray = [item]()
    let Defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
//
//       if let  item = Defaults.array(forKey: "todolistarray") as? [String]
//       {
//        itemArray = item
//        }
        let NewItem = item()
        NewItem.title = "find mike"
        itemArray.append(NewItem)
        let NewItem1 = item()
        NewItem1.title = "buy egos"
        itemArray.append(NewItem1)
        let NewItem2 = item()
        NewItem2.title = "destroy"
        itemArray.append(NewItem2)
    
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todolistcell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark: .none
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(itemArray[indexPath.row])\(indexPath.row).")
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       
        
       tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func Addbutton(_ sender: UIBarButtonItem) {
        var textfiled = UITextField()
        let alert = UIAlertController(title: "add new todey item", message: "", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "add item", style: .default) { (action) in
        let newitem = item()
            newitem.title = textfiled.text!
            self.itemArray.append(newitem)
             self.Defaults.set(self.itemArray, forKey: "todolistarray")
            self.tableView.reloadData()
           
            
        }
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "create new item "
            print(AlertTextField.text)
            textfiled = AlertTextField
            
        }
    
        alert.addAction(alertaction)
        present(alert,animated: true,completion: nil)
        
    
    
    
    }}

