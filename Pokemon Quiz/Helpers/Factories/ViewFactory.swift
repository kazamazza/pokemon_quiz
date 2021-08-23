import Foundation
import UIKit

class ViewFactory: NSObject, ViewFactoring {
    
    static let shared = ViewFactory()

    private override init() {}
    
    static func generateView(viewController: UIViewController) throws -> UIView? {
        var className = String(describing: viewController).components(separatedBy: [".",":"])[1]
        className += "View"
        let viewClass = classFromString(className) as! UIView.Type
        return viewClass.init(frame: viewController.view.frame)
    }
}
