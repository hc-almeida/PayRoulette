//
//  UserViewController.swift
//  PayRoulette
//
//  Created by Hellen on 08/08/21.
//

import UIKit

class UserViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sortButton: UIButton!
    
    // MARK: - Private Properties
    
    private var userController = UserController()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButon()
    }
    
    @IBAction func tappedSortedButton(_ sender: UIButton) {
        userController.sortUserToPay()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        userController.delegate = self
        
        tableView.backgroundColor = UIColor.black
        tableView.delegate = self
        tableView.dataSource = self
        
        EmptyCell.registerOn(tableView)
        UserCell.registerOn(tableView)
        
        nameTextField.delegate = self
        
        tabBarController?.tabBar.barTintColor = .black
    }
    
    private func setupButon() {
       let isEnabledButton = userController.ativatedButton()
        sortButton.isEnabled = isEnabledButton
        sortButton.backgroundColor = isEnabledButton ? .systemBlue : .systemGray2
    }
    
    private func getEmptyCell() -> UITableViewCell {
        let identifer = EmptyCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifer)
                as? EmptyCell else { return UITableViewCell() }
        
        return cell
    }
    
    private func getUserCell(index: Int) -> UITableViewCell {
        let identifer = UserCell.identifier
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifer)
                as? UserCell else { return UITableViewCell() }
        
        let user = userController.getUser(index: index)
        cell.setup(user: user)
        
        return cell
    }
    
    private func proceedToCheckout() {
        let identifier = "CheckoutViewController"
        guard let checkoutViewController = self.storyboard?.instantiateViewController(identifier: identifier)
                as? CheckoutViewController else { return }
        checkoutViewController.modalPresentationStyle = .fullScreen
        present(checkoutViewController, animated: true) {
            self.userController.removeAllUsers()
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extension UITableView

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userController.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return userController.isUserEmpty() ? getEmptyCell() : getUserCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userController.checkUserSorted(indexPath: indexPath)
    }
}

// MARK: - Extension UITextFieldDelegae

extension UserViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        guard let nameUser = textField.text else { return false }
        userController.addUser(name: nameUser)
        nameTextField.text?.removeAll()
        setupButon()
        tableView.reloadData()
        
        return true
    }
}

// MARK: - Extension UserControllerProtocol

extension UserViewController: UserControllerProtocol {
    
    func showSortedUser(name: String) {
        showMessageWithAction(title: name, message: "Você foi o sorteado para pagar a conta ;)", actionTitle: "Ok") { action in
            self.proceedToCheckout()
        }
    }
    
    func removeNotSortedUser(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
