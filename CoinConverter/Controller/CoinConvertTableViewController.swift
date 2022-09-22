//
//  CoinConvertTableViewController.swift
//  CoinConverter
//
//  Created by Jean Lucas Vitor on 22/09/22.
//

import UIKit

class CoinConvertTableViewController: UITableViewController {
    
    var viewModel: CoinConverterViewModel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.coinHistory = viewModel.getHistoryExchange()[indexPath.row]
        dismiss(animated: true)
    }

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj: Coin = viewModel.getHistoryExchange()[indexPath.row]
        if let cell: HistoryCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? HistoryCell {
            cell.configure(title: obj.name!)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
