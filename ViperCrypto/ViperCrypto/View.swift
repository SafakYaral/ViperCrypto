//
//  View.swift
//  ViperCrypto
//
//  Created by Safak Yaral on 27.11.2024.
//

import Foundation
import UIKit
// talks to -> presenter
// Class , protocol
// ViewController

protocol AnyView {
     
    var presenter : AnyPresenter? { get set }
    
    func update(with cryptos: [CryptoEntity])
    func update(with error: String)
}

class CryptoViewController: UIViewController, AnyView ,UITableViewDataSource, UITableViewDelegate{
    var cryptos: [CryptoEntity] = []
    
    var presenter: (any AnyPresenter)?
    
    private let tableView: UITableView = {
        
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
        
    }()
    
    private let massageLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading Data..."
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .blue
        view.addSubview(tableView)
        view.addSubview(massageLabel)
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        tableView.frame = view.bounds
        massageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = String(cryptos[indexPath.row].price)
        cell.contentConfiguration = content
        cell.backgroundColor = .blue
        
        return cell
    }
    
    func update(with cryptos: [CryptoEntity]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.massageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.massageLabel.text = error
            self.massageLabel.isHidden = false
           
        }
    }
    
    
}
