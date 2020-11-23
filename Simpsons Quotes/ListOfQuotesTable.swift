//
//  ListOfQuotesTable.swift
//  SimpsonsQuotes
//
//  Created by Yaroslav on 14.10.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import UIKit

class ListOfQuotesTable: UITableViewController {
    
    var tableQuotes: [Quote]?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.backgroundColor = .yellow

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableQuotes?.count ?? 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .yellow
        
        guard let tableQuotes = tableQuotes else { return cell }
        
        cell.textLabel?.text = tableQuotes[indexPath.row].character
        cell.detailTextLabel?.text = tableQuotes[indexPath.row].quote
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
