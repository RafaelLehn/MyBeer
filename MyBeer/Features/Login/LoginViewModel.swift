//
//  LoginViewModel.swift
//  MyBeer
//
//  Created by Rafael on 4/12/23.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func reject()
}

class LoginViewModel {
    var login: String = ""
    var password: String = ""
    
    private let coordinator: MainCoordinator
    
    weak var delegate: LoginViewModelDelegate?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func verifyLogin() {
        if !login.isEmpty && !password.isEmpty {
            coordinator.goToHome()
        } else {
            delegate?.reject()
        }
    }
}
