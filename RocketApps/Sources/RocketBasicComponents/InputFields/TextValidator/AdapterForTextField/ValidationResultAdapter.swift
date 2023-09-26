//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 22.09.2023.
//
//
//public protocol ValidationResultAdapter: AnyObject {
//    associatedtype ErrorType
//    associatedtype Result = ValidationResult<ErrorType>
//    func applyValidationResult(_ validationResult: Result)
//}

protocol ValidationResultAdapter: AnyObject {
    func applyValidationResult(_ validationResult: ValidationResult)
}
