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
        let txtFieldTitle = self.txtFieldTitle.text
        let txtViewContent = self.txtViewContent.text
    }
    
    
    @IBAction func btnPost(_ sender: Any) {
        
        
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
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("POST 성공")
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
        
        var result: [postData] = []
        
        //    extension DetailVC: UITableViewDataSource, UITableViewDelegate {
        //        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //            return result.count
        //        }
        //
        //        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ListTableViewCell
        //            cell.lbTitle.text = "\(result[indexPath.row].title)"
        //            return cell
        //        }
        //    }
        
        
        
        
        
        
        
        
        
        
        
        
        
        //        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        //
        //            DispatchQueue.main.async() {
        //                do {
        //                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
        //                    guard let jsonObject = object else { return }
        //
        //                    let result = jsonObject["result"] as? String
        //                    let id = jsonObject["id"] as? String
        //                    let title = jsonObject["title"] as? String
        //                    let content = jsonObject["content"] as? String
        //
        //                    if result == "SUCCESS" {
        //                        self.txtViewContent.text = "아이디: \(id!)" + "\n"
        //                        + "제목: \(title!)" + "\n"
        //                        + "내용: \(content!)" + "\n"
        //                    }
        //                } catch let e as NSError {
        //                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
        //                }
        //            }
        //        }
        //
        //        task.resume()
        //    }
        
        
    }
}
