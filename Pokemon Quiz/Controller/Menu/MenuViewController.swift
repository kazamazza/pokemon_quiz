import UIKit

class MenuViewController: BaseViewController {
    
    private var questionViewModel: QuestionViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionViewModel = QuestionViewModel()
    }
}
