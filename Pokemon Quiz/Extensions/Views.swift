import Foundation
import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

extension UIStackView {
    func addArrangedSubviews(views: [UIView]) -> () {
        let _ = views.map({addArrangedSubview($0)})
    }
}

extension NativeView {
    func getParentView() -> UIView? {
        if let nextResponder = self.next as? UIView {
            return nextResponder
        } else if let nextResponder = self.next as? NativeView {
            return nextResponder.getParentView()
        } else {
            return nil
        }
    }
}

extension UIResponder {
  
  func getOwningViewController() -> BaseViewController? {
    var nextResponser = self
    while let next = nextResponser.next {
      nextResponser = next
      if let viewController = nextResponser as? BaseViewController {
        return viewController
      }
    }
    return nil
  }
}
