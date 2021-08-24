import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MenuViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func startGame() {
        let vc = GameViewController()
        vc.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
}
