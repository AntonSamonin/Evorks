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
        return Driver.never()
    }
}
