//
//  eventListVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/3/31.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class eventListVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "eventLIst")
        cell.textLabel?.text = events[indexPath.row].title!
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // the sender should be the event object, need to fix this - Congwei Ni
        let event = events[indexPath.row]
        performSegue(withIdentifier: "listToDetail", sender: event)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let itemToRemove = events[indexPath.row]
        context?.delete(itemToRemove)
        events.remove(at: indexPath.row)
        myTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        saveCoreData()
        myTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Go to DetailViewController and send the report in the selected cell.
        if segue.identifier == "listToDetail"{
            let destVC = segue.destination as! createEventVC
            destVC.event = sender as? Event
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readCoreData()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
