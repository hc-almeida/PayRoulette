//
//  HistoricTableViewCell.swift
//  PayRoulette
//
//  Created by Hellen on 15/08/21.
//

import UIKit

class HistoricCell: UITableViewCell {

    @IBOutlet weak var namePub: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var imagePub: UIImageView!
    
    // MARK: - Public Properties
    
    class var identifier: String {
        String(describing: HistoricCell.self)
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    // MARK: - Functions
    
    func setupList(item: ItemList) {
        namePub.text = item.name
        price.text = String(format: "%.2f", item.price)
    }
    
    func setupOrder(item: ItemOrder) {
        namePub.text = item.name
        price.text = String (item.price)
        imagePub.image = setImage(items: item)
    }
    
    // MARK: - Private Functions
    
    private func setImage(items: ItemOrder) -> UIImage? {
        let bear = UIImage(named: "beer")
        let food = UIImage(named: "food")
        
        return items.productType == "BEBIDA" ? bear : food
    }
    
    private func setupCell() {
        self.selectionStyle = .none
    }

}
