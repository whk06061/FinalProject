//
//  shareTotalViewController.swift
//  Project2
//
//  Created by Mac SWU on 2020/07/05.
//  Copyright © 2020 Mac SWU. All rights reserved.
//

import UIKit

class shareTotalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var customTableView: UITableView!
    var fetchedArray: [MovieData] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customTableView.delegate = self
        customTableView.dataSource = self
        fetchedArray = []
        self.downloadDataFromServer()
    }
    
    func downloadDataFromServer()->Void{
        let urlString: String = "http://condi.swu.ac.kr/student/M07/project/movieTable.php"
        guard let requestURL = URL(string: urlString) else { return }
        let request = URLRequest(url: requestURL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { print("Error: calling POST"); return; }
            guard let receivedData = responseData else{
                print("Error: not receiving Data"); return;
            }
            let response = response as! HTTPURLResponse
            if !(200...299 ~= response.statusCode){print("HTTP response Error!"); return;}
            do{
                if let jsonData = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments) as? [[String: Any]]{
                    for i in 0...jsonData.count-1 {
                        var newData: MovieData = MovieData()
                        var jsonElement = jsonData[i]
                        newData.id = jsonElement["id"] as! String
                        newData.movieDateD = jsonElement["movieDateD"] as! String
                        newData.movieDateM = jsonElement["movieDateM"] as! String
                        newData.movieDateY = jsonElement["movieDateY"] as! String
                        newData.moviePlace = jsonElement["moviePlace"] as! String
                        newData.movieTitle = jsonElement["movieTitle"] as! String
                        newData.reviewDescription = jsonElement["reviewDescription"] as! String
                        newData.reviewTitle = jsonElement["reviewTitle"] as! String
                        newData.saveDate = jsonElement["saveDate"] as! String
                        self.fetchedArray.append(newData)
                    }
                    DispatchQueue.main.async { self.customTableView.reloadData() }
                }
            } catch { print("Error: Catch") }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shareMovie Cell", for: indexPath) as! shareTableViewCell
        
        let item = fetchedArray[indexPath.row]
        cell.labelTitle.text = item.movieTitle
        cell.labelReviewTitle.text = item.reviewTitle
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        cell.labelId.text = item.id
        cell.labelDate.text = item.saveDate

        return cell
    }
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toShareDetail"{
                   if let destination = segue.destination as? ShareDetailViewController{
                    if let selectedIndex = self.customTableView.indexPathsForSelectedRows?.first?.row {
                           let data = fetchedArray[selectedIndex]
                           destination.selectedData = data
                       }
                   }
               }
    }
    

}
