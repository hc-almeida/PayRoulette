//
//  OrderCell.swift
//  PayRoulette
//
//  Created by Hellen on 09/08/21.
//

import UIKit

class ItemCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    // MARK: - Public Properties
    
    class var identifier: String {
        String(describing: ItemCell.self)
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    // MARK: - Functions
    
    func setupHistoric(item: HistoricList) {
        itemName.text = item.name
        itemPrice.text = String(format: "%.2f", item.price)
        itemQuantity.isHidden = true
    }
    
    func setup(item: ItemOrder) {
        itemName.text = item.name
        itemPrice.text = String (item.price)
        itemQuantity.text = String(item.quantity)
        itemImage.image = setImage(items: item)
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
