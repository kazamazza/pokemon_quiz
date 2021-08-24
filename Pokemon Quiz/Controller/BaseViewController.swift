import UIKit

class BaseViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    var nativeView: NativeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            nativeView = try ViewFactory.generateView(viewController: self)
        }
        catch {
            fatalError()
        }
        guard nativeView != nil else {
            fatalError()
        }
        self.view.addSubview(nativeView)
    }

}
