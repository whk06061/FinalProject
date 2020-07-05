//
//  TotalViewController.swift
//  Project2
//
//  Created by Mac SWU on 2020/07/04.
//  Copyright © 2020 Mac SWU. All rights reserved.
//

import UIKit
import CoreData

class TotalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var customTableView: UITableView!
     var movieArray:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customTableView.delegate = self
        customTableView.dataSource = self
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movies")
        
        do{
            movieArray = try context.fetch(fetchRequest)
        } catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        self.customTableView.reloadData()
    }
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie Cell", for: indexPath) as! MovieTableViewCell
        
        let movie = movieArray[indexPath.row]
        let saveDate: Date? = movie.value(forKey: "saveDate") as? Date
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd h:mm a"
        if let unwrapDate = saveDate{
            cell.labelDate.text = formatter.string(from: unwrapDate as Date)
        }
        cell.labelTitle.text = movie.value(forKey: "movieTitle") as? String
        cell.labelReviewTitle.text = movie.value(forKey: "reviewTitle") as? String
        cell.labelPlace.text = movie.value(forKey: "moviePlace") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Core Data 내의 해당 자료 삭제
            let context = getContext()
            context.delete(movieArray[indexPath.row])
            do{
                try context.save()
                print("deleted!")
            } catch let error as NSError{
                print("Could not delete \(error), \(error.userInfo)")
            }
            //배열에서 해당 자료 삭제
            movieArray.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toMyDetail"{
            if let destination = segue.destination as? MyDetailViewController{
                    if let selectedIndex = self.customTableView.indexPathsForSelectedRows?.first?.row {
                        let data = movieArray[selectedIndex]
                        destination.selectedData = data
                    }
                }
            }
    }
}
