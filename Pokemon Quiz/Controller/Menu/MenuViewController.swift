import UIKit

class MenuViewController: BaseViewController, StackViewSelectable {
    
    func didSelectStackViewItem(sender: Any) {
        coordinator?.startGame()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            //try AudioHelper.shared.playTrack(name: "theme", loops: -1)
        }
        catch{
            print("unable to play theme....")
        }
    }
}
