//
//  ViewController.swift
//  JSON
//
//  Created by Guzel on 01.11.2022.
//

import UIKit

class ViewController: UIViewController {

    var employees = [Employee]() {
        didSet {
            employees.sort(by: { $0.name < $1.name })
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchingData(URL: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") { result in
            self.employees = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchingData(URL url: String, completion: @escaping ([Employee]) -> Void) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if data != nil && error == nil {
                do {
                    let parsingData = try JSONDecoder().decode([Employee].self, from: data!)
                    completion(parsingData)
                } catch {
                    print("Error!")
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        cell.textLabel?.text = employees[indexPath.row].name
        cell.detailTextLabel?.text = employees[indexPath.row].phone_number
        for skill in employees[indexPath.row].skills {
            cell.detailTextLabel?.text?.append(skill)
        }
        return cell
    }
}
