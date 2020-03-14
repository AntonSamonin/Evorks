//
//  SingUpViewModel.swift
//  Evorks
//
//  Created by Anton Samonin on 2/9/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel {
    
    enum ValidationProblem {
        case phoneNumberInvalidate
    }
    
    let phoneNumber = BehaviorRelay<String>(value: "")
    
    let signUp = PublishRelay<Void>()
    let signUpProcessing = RxActivityIndicator()
    let signUpComplete = PublishRelay<Void>()
    let signUpError = PublishRelay<String>()
    
    private lazy var credentials = createCredentials()
    
    func observeValidateContent() -> Driver<[ValidationProblem]> {
        let observe = phoneNumber.asDriver(onErrorJustReturn: "").map {
            phoneNumber-> [ValidationProblem] in
            let isPhoneNumberInvalidate = phoneNumber.count != 10
            
            var result: [ValidationProblem] = []
            
            if isPhoneNumberInvalidate { result.append(.phoneNumberInvalidate) }
            
            return result
        }
        
        return Driver.merge(observe, signUpAction())
    }
    
    private func createCredentials() -> Driver<(String)> {
        return phoneNumber.asDriver(onErrorJustReturn: "")
    }
    
    private func signUpAction() -> Driver<[ValidationProblem]> {
        return signUp
            .withLatestFrom(credentials)
            .flatMapLatest { [signUpProcessing, signUpComplete, signUpError] phoneNumber -> Observable<Void> in
                
                return SessionService
                    .signUp(phoneNumber: phoneNumber)
                    .trackActivity(signUpProcessing)
                    .do(onNext: { _ in
                        signUpComplete.accept(Void())
                    }, onError: { error in
                        guard let apiError = error as? ApiError else {
                            signUpError.accept("error_try_later".localized)
                            return
                        }
                        
                        if apiError.code == 0 {
                            signUpError.accept("network_problem".localized)
                        } else if apiError.code == 200 {
                            signUpComplete.accept(Void())
                        }  else if apiError.code == 401 {
                            signUpError.accept("unauthorized".localized)
                        } else if apiError.code == 403 {
                            signUpError.accept("forbidden".localized)
                        } else if apiError.code == 404 {
                            signUpError.accept("not_found".localized)
                        } else {
                            signUpError.accept("error_try_later".localized)
                        }
                    })
                    .catchError { _ in .never() }
        }
        .flatMap { _ -> Driver<[ValidationProblem]> in return .never() }
        .asDriver(onErrorJustReturn: [])
    }
}
