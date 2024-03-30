//
//  ViewController.swift
//  Project7
//
//  Created by Burak Güzey on 15.03.2024.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var petitionsFiltered = [Petition]()
    
    @IBAction func creditsButton(_ sender: UIBarButtonItem) {
        showCredits()
    }
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        search()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
           
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    parse(json: data)
                    return
                }
            }
            
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        
    }
    
    @objc func search(){
        
        let ac = UIAlertController(title: "Search", message: "type to search", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] action in
                guard let answer = ac?.textFields?[0].text else { return }
            print(self?.filter(text: answer))
            
            }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    
    }
    
    func filter(text: String) -> [Petition]  {
        for petition in petitions {
            if petition.body.contains(text) && petition.title.contains(text) {
                petitionsFiltered.append(petition)
            }
        }
        return petitionsFiltered
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
            
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func showError() {
        
        
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
    }
    
    func showCredits() {
        let ac = UIAlertController(title: "CREDITS", message: "The data comes from We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

