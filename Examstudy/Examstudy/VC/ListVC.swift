//
//  ListVC.swift
//  Examstudy
//
//  Created by 강인혜 on 2022/06/10.
//

import UIKit
import Alamofire

class ListVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var result: [resultsArr] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        
        getUsers()
    }
    
    private func getUsers() {
        AF.request("http://13.125.227.67:8080/post/list", method: .get)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: [resultsArr].self) {
                response in switch response.result {
                case.success:
                    if let data = try? JSONDecoder().decode([resultsArr].self, from: response.data!){
                        print(data)
                        DispatchQueue.main.async {
                            self.result = data
                            self.listTableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error)
                }
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

extension ListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ListTableViewCell
        cell.lbContent.text = "\(result[indexPath.row].content)"
        cell.lbTitle.text = "\(result[indexPath.row].title)"
        return cell
    }

}
