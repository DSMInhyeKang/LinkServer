//
//  DetailVC.swift
//  Examstudy
//
//  Created by 강인혜 on 2022/06/10.
//

import UIKit
import Alamofire


class DetailVC: UIViewController {
    
    
    @IBOutlet weak var txtFieldTitle: UITextField!
    @IBOutlet weak var txtViewContent: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnPost(_ sender: Any) {
        
        let txtFieldTitle = self.txtFieldTitle.text
        let txtViewContent = self.txtViewContent.text
        
        //전송할 값
        let url = "http://13.125.227.67:8080/post"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["title": txtFieldTitle,
                      "content": txtViewContent] as Dictionary
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).response { (response) in
            print(response.request)
            switch response.result {
            case .success:
                print("POST 성공")
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}
