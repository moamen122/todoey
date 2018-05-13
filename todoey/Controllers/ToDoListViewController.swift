//
//  ViewController.swift
//  todoey
//
//  Created by moamen alaa on 5/1/18.
//  Copyright © 2018 moamen. All rights reserved.
//

import UIKit
import CoreData


class ToDoListViewController: UITableViewController
{
    var itemArray = [Item]()
    let Defaults = UserDefaults.standard
    var SelectedCategory: Category? {
        
        didSet {
            loaditem()
            
            
        }
    }
  
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
      print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
        

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
        
//        context.delete(itemArray[indexPath.row])
//       itemArray.remove(at: indexPath.row)
        saveitems()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func Addbutton(_ sender: UIBarButtonItem) {
        var textfiled = UITextField()
        let alert = UIAlertController(title: "add new todey item", message: "", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "add item", style: .default) { (action) in
        let newitem = Item(context: self.context)
            newitem.title = textfiled.text!
            newitem.done = false
            newitem.parentCategory = self.SelectedCategory
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
      
        do {
       
        try context.save()
    } catch {
        print("error savig context \(error)")
        
        }
        self.tableView.reloadData()
    }
    
    func loaditem(with request : NSFetchRequest<Item> = Item.fetchRequest(),predicate: NSPredicate? = nil) {
        
        let Categorypredicate = NSPredicate(format: "parentCategory.name MATCHES %@", SelectedCategory!.name!)
        if let addionalpredicate = predicate {
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[ Categorypredicate, addionalpredicate])
        }
        else {
            
            request.predicate = Categorypredicate
        }
        
        do {
           itemArray =  try context.fetch(request)
        }
        catch{
            
            print("\(error)e error in fteching ")
            
        }
        tableView.reloadData()
    }
    
   
}
extension ToDoListViewController : UISearchBarDelegate
{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       let predicate =  NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text! )
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loaditem(with: request,predicate: predicate)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {


            loaditem()
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }

        }
    }
}
