//
//  UserController.swift
//  PayRoulette
//
//  Created by Hellen on 09/08/21.
//

import UIKit

protocol UserControllerProtocol: AnyObject {
    
    func showSortedUser(name: String)
    
    func removeNotSortedUser(indexPath: IndexPath)
}

class UserController {
    
    // MARK: - Private Properties
    
    private var usersImages = [UIImage(named: "Image-1"), UIImage(named: "Image-2"),
                               UIImage(named: "Image-3"), UIImage(named: "Image-4"), UIImage(named: "Image-5")]
    private var users = [User]()
    private var sortedUser: User?
    
    // MARK: - Public Properties
    
    weak var delegate: UserControllerProtocol?
    
    var count: Int {
        users.isEmpty ? 1 : users.count
    }
    
    // MARK: - Public Functions
    
    func addUser(name: String) {
        if name.isEmpty { return }
        
        guard let randomImage = usersImages.randomElement() else { return }
        users.insert(User(name: name, image: randomImage ?? UIImage()), at: 0)
    }
    
    func getUser(index: Int) -> User {
        return users[index]
    }
    
    func isUserEmpty() -> Bool {
        return users.isEmpty
    }
    
    func ativatedButton() -> Bool {
        return users.count > 1 ? true : false
    }
    
    func sortUserToPay() {
        sortedUser = users.randomElement()
    }

    func checkUserSorted(indexPath: IndexPath) {
        if sortedUser === users[indexPath.row] {
            delegate?.showSortedUser(name: users[indexPath.row].name)
        } else {
            users.remove(at: indexPath.row)
            delegate?.removeNotSortedUser(indexPath: indexPath)
        }
    }
    
    func removeAllUsers() {
        users.removeAll()
    }
}
