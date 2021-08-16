//
//  HistoricController.swift
//  PayRoulette
//
//  Created by Hellen on 15/08/21.
//

import Foundation

protocol HistoricControllerDelegate: AnyObject {
    
    func fetchListSucceed()
}

class HistoricController {
    
    // MARK: - Private Properties
    
    private var list: Historic?
    
    // MARK: - Public Properties
    
    weak var delegate: HistoricControllerDelegate?
    
    var count: Int {
        return list?.historyAccountList.count ?? 0
    }
    
    // MARK: - Public Functions
    
    func fetchHistoric() {
        guard let url = Bundle.main.url(forResource: "Historico", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        
        do {
            self.list = try JSONDecoder().decode(Historic.self, from: data)
            self.delegate?.fetchListSucceed()
            
        } catch {
            print("Erro JSON")
        }
    }
    
    func getTotalValue() -> String {
        return String(format: "%.2f", list?.totalValue ?? 0.0)
    }
    
    func getItem(indexPath: IndexPath) -> HistoricList? {
        return list?.historyAccountList[indexPath.row]
    }
}
