//
//  ShareDetailViewController.swift
//  Project2
//
//  Created by Mac SWU on 2020/07/05.
//  Copyright © 2020 Mac SWU. All rights reserved.
//

import UIKit

class ShareDetailViewController: UIViewController {
    
    var selectedData: MovieData?
    
    @IBOutlet var textMovieTitle: UITextField!
    @IBOutlet var textReviewTitle: UITextField!
    @IBOutlet var textContent: UITextView!
    @IBOutlet var userId: UILabel!
    @IBOutlet var saveDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let movieData = selectedData else { return }
        textMovieTitle.text = movieData.movieTitle
        textReviewTitle.text = movieData.reviewTitle
        textContent.text = movieData.reviewDescription
        userId.text = movieData.id + " 작성함"
        saveDate.text = movieData.saveDate
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
