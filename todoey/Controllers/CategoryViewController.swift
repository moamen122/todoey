//
//  CategoryViewController.swift
//  todoey
//
//  Created by moamen alaa on 5/10/18.
//  Copyright © 2018 moamen. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    var CateogryArray = [Category]()
  
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
      
        loaditem()
        saveitems()
       
    }

 

    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textfiled = UITextField()
        let alert = UIAlertController(title: "add new todey category", message: "", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "add category", style: .default) { (action) in
            let newCateogry = Category(context: self.context)
            newCateogry.name = textfiled.text!
         
            self.CateogryArray.append(newCateogry)
            
            self.saveitems()
            
        }
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "create new category "
            print(AlertTextField.text)
            textfiled = AlertTextField
            
        }
        
        alert.addAction(alertaction)
        present(alert,animated: true,completion: nil)

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CateogryArray.count
        
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = CateogryArray[indexPath.row].name
        
       return cell
    }
 
    
    // Mark: tableview delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
       if  let indexpath = tableView.indexPathForSelectedRow
       {
        
        destinationVC.SelectedCategory = CateogryArray[indexpath.row]
        }
    }
    
    // Mark:
    func saveitems() {
        
        do {
            
            try context.save()
        } catch {
            print("error savig context \(error)")
            
        }
        self.tableView.reloadData()
    }
    
    // Mark : tableview datasource Methods
   
    func loaditem(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            CateogryArray =  try context.fetch(request)
        }
        catch{
            
            print("\(error)e error in fteching ")
            
        }
        tableView.reloadData()
    }
}
