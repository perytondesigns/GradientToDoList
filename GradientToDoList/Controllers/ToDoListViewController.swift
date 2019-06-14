//
//  ViewController.swift
//  GradientToDoList
//
//  Created by Kimberly Motyka on 6/11/19.
//  Copyright © 2019 PerytonDesigns. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //below is getting commented out after making the ITEM Model, new code below
    //var itemArray = ["Finish Tutorial?", "Prep for Forrest", "Yoga"]
    //so now the itemArray is equal to the class Item that contains a title and boolean for each indexPath/item in array
    var itemArray = [Item]()
    
    //Now we're getting into our background storage of data so it doesn't disappear when the app is terminated
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //she copied the below lines of code several times (newItem2, newItem3, etc), but that can't be right because its still hard coded.
        let newItem = Item()
        newItem.title = "Finish Tutorial?"
        itemArray.append(newItem)
        //we're connecting the "saved" data of what items they entered and making sure it loads on viewDidLoad
      
        //using user defaults to pull out an array of items (trying to) 
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }//ends view did load
    
    //First required func for tableView (tells us how many rows it should have)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemArray.count //returns 3 at the moment
    }
    
    //Second required func for tableView (tells us what cell to use for said view)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //item we're currently trying to set up for the cell (she mentioned the itemArray[indexPath.row] is repeated a lot, this should clean that up some
        let masterItem = itemArray[indexPath.row]
        //set textLabel (this is in every cell), it's text property to = our item array (at current row of current index path)
        //at current row of current index path <-idkwtf. i think its just referring to the row that it's trying to populate,
        //ie it probably tries to populate row 1 first, then row 2, then row 3, etc.
        //UPDATE: Since we changed the itemArray to contain OBJECTS (ie the Item Model) rather than strings as previously done, we have to be more specific and add on the .title
        //UPDATE 3: Since adding above 'masterItem' we can shorten up the below code
        cell.textLabel?.text = masterItem.title
        
        //We added the if/else statement after changing the itemArray into Objects via the new DATA model, OH! Because now we have that boolean that directly relates to whether something is DONE or not (ie the .done, if its done it should have a checkmark
        //Also because of this we can delete our previous code that assigned/unassigned check marks.
        //UPDATE 3: Same as above
//Ternary operator ==> value = condition ? valueIfTrue : valueIfFalse
        //MY GUESS: true = masterItem.done ? .checkmark : .none (i was pretty close!)
        //actual answer: (condition is what's between the IF statement)
        //set the cells accessory type depending on whether the item.done is true, if it is add a checkmark, if not no checkmark
        cell.accessoryType = masterItem.done ? .checkmark : .none
        /*so now this code is obsolete beause of the above line
        if masterItem.done == true {cell.accessoryType = .checkmark} else {cell.accessoryType = .none}   */
        
        //this needs to be here (you can tell from above in the method it says to return -> "UITableViewCell" which is what we're doing.
        return cell
    }
    
    //this method gets called when the tableview is loaded up, at that time, none of our items are in the "done" status, unless we added it to our hard coding above (she added 3 ex I added 1, I actually set mine to false but I just updated it to see if it would have a checkmark. (it does)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //AFTER ADDING DATA MODEL: 1. Set the property of the selected Item
        /*Used an if-else statement, which she said was the LONG way?
        if itemArray[indexPath.row].done == false {itemArray[indexPath.row].done = true} else { itemArray[indexPath.row].done = false} */
        
        //Here's the shorter version: Sets the .DONE property to the opposite of what it currently is
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        //Firstly, she asked "how do we get the above delegate method to trigger again once we've changed the items "doen" property, (update view! - i guessed it right
        //below: Forces tableView to reLoad it's DATAsource methods again so it reloads the data that's mean to be inside
        tableView.reloadData()
        
        
        
        //UPDATE: After creating DATA Model (with bool "done") we wrote code (see above under cellForRowAt) that allows us to delete all of the following:
        /*we want to add a check mark when row is selected and deselect when its selected again, if there is no check mark, add a check mark,
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            //else if there is a check mark, remove the check mark.
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } */
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
            //UPDATE: Now that we have the ITEM MODEL and made the items in the itemArray objects rather than strings, we need to make changes, old code:
            //self.itemArray.append(textField.text!)
            //new code:
            //1. This is establishing a container that is of type Item() (the class which contains a title and a boolean)
            let newItem = Item()
            //2. This is setting the new item's title to equal the textField's text
            newItem.title = textField.text!
            //3. This is appending said newItem to the ItemArray
            self.itemArray.append(newItem)
            
            
            
            //we're going to save our item array to our user defaults (the SELFs are because we are in an closure)
             ///this is not enough, but this does save the data to the plist (note the key)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
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

