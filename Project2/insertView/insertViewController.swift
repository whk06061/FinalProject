//
//  insertViewController.swift
//  Project2
//
//  Created by Mac SWU on 2020/07/05.
//  Copyright © 2020 Mac SWU. All rights reserved.
//

import UIKit

class insertViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var textMovieTitle: UITextField!
    @IBOutlet var pickerDate: UIPickerView!
    @IBOutlet var textPlace: UITextField!
    @IBOutlet var textReviewTitle: UITextField!
    @IBOutlet var textDescription: UITextView!
    
    
    let yearArray = Array(2000...2030)
    let monthArray = Array(1...12)
    let dayArray = Array(1...31)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let id = appDelegate.ID{
            self.title = id + " 으로 글 작성"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return yearArray.count
        } else if component == 1{
            return monthArray.count
        } else {
            return dayArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return String(yearArray[row]) + "년"
        } else if component == 1{
            return String(monthArray[row]) + "월"
        } else {
            return String(dayArray[row]) + "일"
        }
    }

    @IBAction func saveReview(_ sender: UIBarButtonItem) {
        
        let year: String = String(yearArray[self.pickerDate.selectedRow(inComponent: 0)])
        let month: String = String(monthArray[self.pickerDate.selectedRow(inComponent: 1)])
        let day: String = String(dayArray[self.pickerDate.selectedRow(inComponent: 2)])
        let movieTitle = textMovieTitle.text!
        let reviewTitle = textReviewTitle.text!
        let reviewDescription = textDescription.text!
        
        if (movieTitle == "" || reviewTitle == "" || reviewDescription == "") {
        let alert = UIAlertController(title: "제목 및 내용을 입력하세요",
        message: "Save Failed!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
        return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd h:mm a"
        let saveDate = formatter.string(from: Date())
        
        let urlString: String = "http://condi.swu.ac.kr/student/M07/project/insertMovie.php"
        guard let requestURL = URL(string: urlString) else{
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let userID = appDelegate.ID else { return }
        let restString: String = "id=" +
        userID + "&movieDateD=" + day + "&movieDateM=" + month + "&movieDateY=" + year + "&saveDate=" + saveDate + "&moviePlace=" + textPlace.text! + "&movieTitle=" + movieTitle + "&reviewDescription=" + reviewDescription + "&reviewTitle=" + reviewTitle
        
        request.httpBody = restString.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request){
            (responseData, response, responseError) in guard responseError == nil else{
                print("Error: calling POST")
                return
            }
            //예외(responseError)는 발생하지 않았지만 responseData가 nil값일 때
            guard let receiveData = responseData else{
                print("Error: not receiving Data")
                return
            }
            //receiveData는 "Insert Done!"임
            if let utf8Data = String(data: receiveData, encoding: .utf8){
                DispatchQueue.main.async {
                    print(utf8Data)
                }
            }
        }
        task.resume()
        
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
     
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
