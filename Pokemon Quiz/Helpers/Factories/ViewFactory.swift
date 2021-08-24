import Foundation
import UIKit

class ViewFactory: NSObject, ViewFactoring {
    
    static let shared = ViewFactory()

    private override init() {}
    
    static func generateView(viewController: BaseViewController) throws -> NativeView? {
        var className = String(describing: viewController).components(separatedBy: [".",":"])[1]
        className += "View"
        let viewClass = classFromString(className) as! NativeView.Type
        return viewClass.init(viewController: viewController)
    }
}
