//
//  createViewController.swift
//  Project2
//
//  Created by Mac SWU on 2020/07/05.
//  Copyright © 2020 Mac SWU. All rights reserved.
//

import UIKit

class createViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textID: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var textName: UITextField!
    @IBOutlet var labelStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textID{
            textField.resignFirstResponder()
            self.textPassword.becomeFirstResponder()
        } else if textField == self.textPassword{
            textField.resignFirstResponder()
            self.textName.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func buttonSave() {
        //필요한 세 가지 자료가 모두 입력 되었는지 확인
        if textID.text == ""{
            labelStatus.text = "ID를 입력하세요"
            return
        }
        if textPassword.text == ""{
            labelStatus.text = "Password를 입력하세요"
            return
        }
        if textName.text == ""{
            labelStatus.text = "사용자 이름을 입력하세요"
            return
        }
        
        let urlString: String = "http://condi.swu.ac.kr/student/M07/project/insertUser.php"
        guard let requestURL = URL(string: urlString) else{
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "id="+textID.text!+"&password="+textPassword.text!+"&name="+textName.text!
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
                    self.labelStatus.text = utf8Data
                    print(utf8Data)
                }
            }
        }
        task.resume()
    }
    
    @IBAction func buttonBack() {
        self.dismiss(animated: true, completion: nil)
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
