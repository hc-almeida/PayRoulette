//
//  CheckoutController.swift
//  PayRoulette
//
//  Created by Hellen on 15/08/21.
//

import UIKit


protocol CheckoutControllerDelegate: AnyObject {
    
    func fetchOrderSuccess()
}

class CheckoutController {
    
    // MARK: - Private Properties
    
    private var order: Order?

    // MARK: - Public Properties
    
    weak var delegate: CheckoutControllerDelegate?
    
//    let fecthOrder: [Order] = Bundle.main.decode("Account.json") test
    
    var count: Int {
        return order?.productList.count ?? 0
    }

    // MARK: - Public Functions
    
    func fetchOrder() {
        guard let url = Bundle.main.url(forResource: "Account", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        
        do {
            self.order = try JSONDecoder().decode(Order.self, from: data)
            self.delegate?.fetchOrderSuccess()
        } catch {
            print("Erro JSON")
        }
    }
    
    func getTotalValue() -> String {
        return String(format: "%.2f", order?.totalValue ?? 0.0)
    }
    
    func getItemOrder(indexPath: IndexPath) -> ItemOrder? {
        return order?.productList[indexPath.row]
    }

    func numberOfRow(for section: Int) -> Int {
        
        switch CheckoutViewController.TableViewSection(rawValue: section) {
        case .order:
            return order?.productList.count ?? 0
        case .payment:
            return 1
        case .none:
            return 1
        }
    }
}
