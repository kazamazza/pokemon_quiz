import UIKit

class MenuViewController: BaseViewController, ViewSelectable {
    
    func didSelectViewItem(sender: Any) {
        coordinator?.startGame()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try AudioHelper.shared.playTrack(name: "theme", loops: -1)
        }
        catch{
            print("unable to play theme....")
        }
    }
}
