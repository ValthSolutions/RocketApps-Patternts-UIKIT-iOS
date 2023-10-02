
import UIKit

public protocol TitleIdble {
    var id: String { get }
    var title: String { get }
}

public enum ErrorState {
    case error(message: String)
    case noError
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
