//
//  PaymentCell.swift
//  PayRoulette
//
//  Created by Hellen on 09/08/21.
//

import UIKit

protocol PaymentCellDelegate {
    
    func dismiss()
}

class PaymentCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    // MARK: - Public Properties
    
    var delegate: PaymentCellDelegate?
    
    class var identifier: String {
        String(describing: PaymentCell.self)
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    @IBAction func payButton(_ sender: UIButton) {
        delegate?.dismiss()
    }
    
    // MARK: - Functions
    
    func setup(orderTotal: String) {
        totalPrice.text = orderTotal
    }
    
    // MARK: - Private Functions
    
    private func setup() {
        payButton.layer.cornerRadius = 4
        self.selectionStyle = .none
    }
}
