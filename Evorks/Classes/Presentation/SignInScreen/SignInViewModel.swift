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
        return signIn.withLatestFrom(credentials).flatMapLatest { [signInSuccess, signInProcessing, signInError] login,password -> Observable<Void> in
            return SessionService
                .signIn(username: login, password: password)
                .trackActivity(signInProcessing)
                .do(onNext: { _ in
                    signInSuccess.accept(Void())
                }, onError: { error in
                    guard let apiError = error as? ApiError else {
                        signInError.accept("error_try_later".localized)
                        return
                    }
                    
                    if apiError.code == 0 {
                        signInError.accept("network_problem".localized)
                    } else if apiError.code == 200 {
                        signInSuccess.accept(Void())
                    }  else if apiError.code == 401 {
                        signInError.accept("unauthorized".localized)
                    } else if apiError.code == 403 {
                        signInError.accept("forbidden".localized)
                    } else if apiError.code == 404 {
                        signInError.accept("not_found".localized)
                    } else {
                        signInError.accept("error_try_later".localized)
                    }
                })
                .catchError { _ in .never() }
        }
        .flatMap { _ -> Driver<[ValidationProblem]> in return .never() }
        .asDriver(onErrorJustReturn: [])
    }
}
