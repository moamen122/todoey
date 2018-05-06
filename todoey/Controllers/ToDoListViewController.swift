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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        print(dataFilePath)
      
        loaditem()
//
//        if let  items   = Defaults.array(forKey: "todolistarray") as? [item]
//        {
//            itemArray = items
//        }
//
        

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
       
        saveitems()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func Addbutton(_ sender: UIBarButtonItem) {
        var textfiled = UITextField()
        let alert = UIAlertController(title: "add new todey item", message: "", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "add item", style: .default) { (action) in
        let newitem = item()
            newitem.title = textfiled.text!
            self.itemArray.append(newitem)
            
        self.saveitems()
            
        }
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "create new item "
            print(AlertTextField.text)
            textfiled = AlertTextField
            
        }
    
        alert.addAction(alertaction)
        present(alert,animated: true,completion: nil)
        
    
    
    
    }
    func saveitems() {
        let encoder = PropertyListEncoder()
        do {
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
    
        
    } catch {
        print("error")
        
        }
        self.tableView.reloadData()
    }
    
    func loaditem() {
        
        if  let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            do{
            itemArray = try  decoder.decode([item].self, from: data )
            }
            catch{
                
                print(error)
            }
    }
}
}
