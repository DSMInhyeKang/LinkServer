//
//  ListVC.swift
//  Examstudy
//
//  Created by 강인혜 on 2022/06/10.
//

import UIKit

class ListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    var result: [resultsArr] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        
        getUsers()
    }
    
    private func getUsers() {
        AF.request("https://randomuser.me/api/?results=20&inc=name,email", method: .get)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: friendsModel.self) {
                response in switch response.result {
                case.success:
                    if let data = try? JSONDecoder().decode(friendsModel.self, from: response.data!){
                        print(data)
                        DispatchQueue.main.async {
                            self.result = data.results
                            self.mainTableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error)
                }
                }
            }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        cell.lbTitle.text = "\(result[indexPath.row].name)"
        return cell
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
