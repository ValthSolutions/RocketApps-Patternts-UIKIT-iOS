//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 22.09.2023.
//

import UIKit

public protocol TitleIdble {
    var id: String { get }
    var title: String { get }
}

public enum ErrorState {
    case error(message: String, delta: CGFloat)
    case noError(delta: CGFloat)
}

// MARK: - BaseInputView

public protocol BaseInputViewDelegate: AnyObject {
    func textFieldView(_ textFieldView: BaseInputView, didChangeHeight additionalHeight: CGFloat, animated: Bool)
}

public protocol TextFieldViewButtonDelegate: AnyObject {
    func textFieldViewDidTapButton(_ textFieldView: TextFieldView)
}

public protocol TextFieldViewDidSelectDelegate: AnyObject {
    func textFieldView(_ textFieldView: TextFieldView, didSelectTitle title: TitleIdble)
}
