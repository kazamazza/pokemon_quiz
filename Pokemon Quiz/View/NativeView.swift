import UIKit

class NativeView: UIView {

    var viewContoller: BaseViewController!

    required init(viewController: BaseViewController) {
        super.init(frame: viewController.view.frame)
        self.viewContoller = viewController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
