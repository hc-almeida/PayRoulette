//
//  HistoricViewController.swift
//  PayRoulette
//
//  Created by Hellen on 15/08/21.
//

import UIKit

class HistoricViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private let historicController = HistoricController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        historicController.fetchHistoric()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        historicController.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        ItemCell.registerOn(tableView)
        
        let footerView = UIView()
        footerView.backgroundColor = .black
        self.tableView.tableFooterView = footerView
    }
    
    private func getHistoricCell(_ indexPath: IndexPath) -> UITableViewCell {
        let identifier = ItemCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)as? ItemCell,
              let item = historicController.getItem(indexPath: indexPath) else { return UITableViewCell() }
        
        cell.setupHistoric(item: item)

        return cell
    }
}

// MARK: - UITableView extension

extension HistoricViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicController.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getHistoricCell(indexPath)
    }
}

// MARK: - HistoricViewController extension

extension HistoricViewController: HistoricControllerDelegate {
    
    func fetchListSucceed() {
        tableView.reloadData()
    }
}
