//
//  CheckoutViewController.swift
//  PayRoulette
//
//  Created by Hellen on 15/08/21.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var checkoutController = CheckoutController()
    
    enum TableViewSection: Int, CaseIterable {
        case order = 0
        case payment = 1
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkoutController.fetchOrder()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        PaymentCell.registerOn(tableView)
        ItemCell.registerOn(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let footerView = UIView()
        footerView.backgroundColor = .black
        self.tableView.tableFooterView = footerView
    }
    
    private func getOrderCell(_ indexPath: IndexPath) -> UITableViewCell {
        let identifier = ItemCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)as? ItemCell,
              let item = checkoutController.getItemOrder(indexPath: indexPath) else { return UITableViewCell() }
        
        cell.setup(item: item)
        
        return cell
    }
    
    private func getPaymentCell() -> UITableViewCell {
        let identifier = PaymentCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)as? PaymentCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        let total = checkoutController.getTotalValue()
        cell.setup(orderTotal: total)
        
        return cell
    }
}

// MARK: - UITableView extension

extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkoutController.numberOfRow(for: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableViewSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .order:
            return getOrderCell(indexPath)
        case .payment:
            return getPaymentCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CheckoutControllerDelegate extension

extension CheckoutViewController: CheckoutControllerDelegate {
    
    func fetchOrderSuccess() {
        self.tableView.reloadData()
    }
}

// MARK: - PaymentCellDelegate extension

extension CheckoutViewController: PaymentCellDelegate {
    
    func dismiss() {
        dismiss(animated: true)
    }
}
