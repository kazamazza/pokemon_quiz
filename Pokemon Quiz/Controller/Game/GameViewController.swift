import UIKit

class GameViewController: BaseViewController {

    private var questionViewModel: QuestionViewModel!
    var currentQuestion: Question!
    let session = SessionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session.delegate = self
        questionViewModel = QuestionViewModel()
        bindToObservable(observable: questionViewModel.questionsReady)
        questionViewModel.load()
    }
    
    func nextQuestion() {
        currentQuestion = questionViewModel.nextQuestion()
        guard currentQuestion != nil else{
            gameOver()
        return}
        loadQuestion()
    }
    
    private func loadQuestion() {
        ImageDownloadManager.shared.downloadImage(currentQuestion.correct.imagePath!, indexPath: nil) {
            image,_,_,_  in
            let nativeView = self.nativeView as? GameViewControllerView
            DispatchQueue.main.async {
                nativeView?.characterView.profilePic.image = image
                let nativeView = self.nativeView as? GameViewControllerView
                nativeView?.loadOptions(question: self.currentQuestion)
                self.session.question()
            }
        }
    }
    
    func gameOver() {
        session.gameOver()
        let nativeView = self.nativeView as? GameViewControllerView
        nativeView?.shadow.isHidden = false 
    }
    
    func bindToObservable(observable: Observable<[Bool]>){
        observable.bind { [weak self] result in
            guard let self = self else {return}
                self.nextQuestion()
        }
    }
}
