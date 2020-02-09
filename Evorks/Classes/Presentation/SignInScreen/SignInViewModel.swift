//
//  SignInViewModel.swift
//  Evorks
//
//  Created by Anton Samonin on 2/8/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel {
    
    enum ValidationProblem {
        case passwordIsSmall
    }
    
    let login = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    let signIn = PublishRelay<Void>()
    let signUp = PublishRelay<Void>()
    let signInProcessing = RxActivityIndicator()
    let signInSuccess = PublishRelay<Void>()
    let signInError = PublishRelay<String>()
    
    private lazy var credentials = createCredentials()
    
    func observeValidateContent() -> Driver<[ValidationProblem]> {
            let observe = Driver
                .combineLatest(login.asDriver(onErrorJustReturn: ""),
                               password.asDriver(onErrorJustReturn: "")) {
                                login, password -> [ValidationProblem] in
                                let isPasswordSmall = password.count < 1
                                
                                var result: [ValidationProblem] = []
                                
                                if isPasswordSmall { result.append(.passwordIsSmall) }
                                
                                return result
                }
            
            
            
            return Driver.merge(observe,
                                signInAction())
    }
    
    private func createCredentials() -> Driver<(String, String)> {
        return Driver
            .combineLatest(login.asDriver(onErrorJustReturn: ""),
                           password.asDriver(onErrorJustReturn: ""))
    }
    
    private func signInAction() -> Driver<[ValidationProblem]> {
        return Driver.never()
    }
}
