//
//  MyDetailViewController.swift
//  Project2
//
//  Created by Mac SWU on 2020/07/05.
//  Copyright © 2020 Mac SWU. All rights reserved.
//

import UIKit
import CoreData

class MyDetailViewController: UIViewController {
    
    @IBOutlet var textMovieTitle: UITextField!
    @IBOutlet var textMovieDate: UITextField!
    @IBOutlet var textMoviePlace: UITextField!
    @IBOutlet var textReviewTitle: UITextField!
    @IBOutlet var textContent: UITextView!
    @IBOutlet var saveDate: UILabel!
    
    var selectedData: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let movieData = selectedData else { return }
        
        textMovieTitle.text = movieData.value(forKey: "movieTitle") as? String
        textMovieDate.text! = String(movieData.value(forKey: "movieDateY") as! Int) + "년 "
        textMovieDate.text! += String(movieData.value(forKey: "movieDateM") as! Int) + "월 "
        textMovieDate.text! += String(movieData.value(forKey: "movieDateD") as! Int) + "일"
        textMoviePlace.text = movieData.value(forKey: "moviePlace") as? String
        textReviewTitle.text = movieData.value(forKey: "reviewTitle") as? String
        textContent.text = movieData.value(forKey: "reviewDescription") as? String
        
        let saveDate: Date? = movieData.value(forKey: "saveDate") as? Date
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd h:mm a"
        if let unwrapDate = saveDate{
            self.saveDate.text = formatter.string(from: unwrapDate as Date) + " 작성함"
        }
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
