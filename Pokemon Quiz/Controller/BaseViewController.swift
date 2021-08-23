import UIKit

class BaseViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    var viewTemplate: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            viewTemplate = try ViewFactory.generateView(viewController: self)
        }
        catch {
            fatalError()
        }
        guard viewTemplate != nil else {
            fatalError()
        }
        self.view.addSubview(viewTemplate)
    }
}
