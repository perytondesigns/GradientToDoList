//
//  ViewController.swift
//  GradientToDoList
//
//  Created by Kimberly Motyka on 6/11/19.
//  Copyright © 2019 PerytonDesigns. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    var itemArray = ["Finish Tutorial?", "Prep for Forrest", "Yoga"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }//ends view did load
    
    //First required func for tableView (tells us how many rows it should have)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemArray.count //returns 3 at the moment
    }
    
    //Second required func for tableView (tells us what cell to use for said view)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //set textLabel (this is in every cell), it's text property to = our item array (at current row of current index path)
        //at current row of current index path <-idkwtf. i think its just referring to the row that it's trying to populate,
        //ie it probably tries to populate row 1 first, then row 2, then row 3, etc.
        cell.textLabel?.text = itemArray[indexPath.row]
        
        //this needs to be here (you can tell from above in the method it says to return -> "UITableViewCell" which is what we're doing.
        return cell
    }
    
    //we want to check and uncheck the to do list
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //we want to add a check mark when row is selected and deselect when its selected again
        //if there is no check mark, add a check mark,
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            //else if there is a check mark, remove the check mark.
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //currently you click the cell and it stays gray until you click elsewhere, to make the gray flash and go away:
        tableView.deselectRow(at: indexPath, animated: true)
        
    } //ends "didSelectRowAt"
    
    
    //MARK - Add new Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    //we're setting this variable because it has a wider scope (IE the entirety of the addButtonPressed) and we need a place
        //to place the text that USER enters into the alertTextfield
    var textField = UITextField()
        
    //have UIAlert Popup show up when pressed
    let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
    //Have button on UIAlert that APPENDS said item to their to do list
        //this is the completion block that gets handled once the "add it" button has been pressed
        let action = UIAlertAction(title: "Add it!", style: .default) { (action) in
            
            //what will happen once the user clicks the Add Item button on our UIAlert
            self.itemArray.append(textField.text!)
            
            //even though the above code appends the item to the list, it still doesn't appear (visually for user), inorder to do
            //this, we need to:
            self.tableView.reloadData()

        }
        
        //have textfield inside UIAlert that user can add new items too
        //this adds a text field to the alert
        alert.addTextField { (alertTextField) in
            //placeholder is the grayed out text that appears in the text field
            alertTextField.placeholder = "Type new item here"
            
            //this line has to do with scope. We can't access the alertTextField except in this closure so that why we made
            //the additional variable and are connecting it to the alertTextField (extending the scope)
            textField = alertTextField
            
        }
        
        
        //this adds the action (add it button) to the alert
        alert.addAction(action)
        
        //Now to show our alert
        present(alert, animated: true, completion: nil)
        
    } //ends addButtonPressed IBAction
    


}

