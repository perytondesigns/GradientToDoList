//
//  ViewController.swift
//  GradientToDoList
//
//  Created by Kimberly Motyka on 6/11/19.
//  Copyright © 2019 PerytonDesigns. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    let itemArray = ["Finish Tutorial?", "Prep for Forrest", "Yoga"]

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
        
    }
    
    


}

