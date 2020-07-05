//
//  myinsertViewController.swift
//  Project2
//
//  Created by Mac SWU on 2020/07/04.
//  Copyright © 2020 Mac SWU. All rights reserved.
//

import UIKit
import CoreData

class myinsertViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return yearArray.count
        } else if component == 1 {
            return monthArray.count
        } else {
            return dayArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(yearArray[row]) + "년"
        } else if component == 1 {
            return String(monthArray[row]) + "월"
        } else {
            return String(dayArray[row]) + "일"
        }
    }
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func saveReview(_ sender: UIBarButtonItem) {
        
        let year: Int = yearArray[self.pickerDate.selectedRow(inComponent: 0)]
        let month: Int = monthArray[self.pickerDate.selectedRow(inComponent: 1)]
        let day: Int = dayArray[self.pickerDate.selectedRow(inComponent: 2)]
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Movies", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
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
        
        object.setValue(movieTitle, forKey: "movieTitle")
        object.setValue(textPlace.text, forKey: "moviePlace")
        object.setValue(reviewTitle, forKey: "reviewTitle")
        object.setValue(reviewDescription, forKey: "reviewDescription")
        object.setValue(year, forKey: "movieDateY")
        object.setValue(month, forKey: "movieDateM")
        object.setValue(day, forKey: "movieDateD")
        object.setValue(Date(), forKey: "saveDate")
        
        do{
            try context.save()
            print("saved!")
        } catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        self.navigationController?.popViewController(animated: true)
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
