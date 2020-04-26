//
//  ValidateInputs.swift
//  Test
//
//  Created by Dante Kim on 4/2/20.
//
import Foundation
import Validator

struct ValidateInputs {
    var email: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""
    
    func isEmailValid() -> Bool {
        let rule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ExampleValidationError("Email Rule Error"))
        let result = email.validate(rule: rule)
        switch result {
        case .valid:
            return true
        case .invalid:
            return false
        }
    }
    func isPasswordLengthValid() -> Bool {
        let minLengthRule = ValidationRuleLength(min: 5, error: ExampleValidationError("Email Rule Error"))
        let result = password.validate(rule: minLengthRule)
        switch result {
        case .valid:
            return true
        case .invalid:
            return false
        }
    }
    
    func doesPasswordHaveDigits() -> Bool {
        let digitRule = ValidationRulePattern(pattern: ContainsNumberValidationPattern(), error: ExampleValidationError("Digit Rule Error"))
        let result2 = password.validate(rule: digitRule)
        switch result2 {
        case .valid:
            return true
        case .invalid:
            return false
        }
    }
    
    func isPasswordConfirmationValid() -> Bool {
        let staticEqualityRule = ValidationRuleEquality<String>(target: password, error: ExampleValidationError("Password Confirmation Error"))
        let result = passwordConfirmation.validate(rule: staticEqualityRule)
        switch result {
        case .valid:
            return true
        case .invalid:
            return false
        }
    }
    
}
