import UIKit

class GameViewController: BaseViewController, Restarting {

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
        guard currentQuestion != nil else{gameOver();return}
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
    
    func updateViewWithReduceAction(options: [Character]) {
        let nativeView = self.nativeView as? GameViewControllerView
        nativeView?.updateOptionsWithReduceAction(remove: options)
    }
    
    
    func updateViewWithTimeBoostAction() {
        let nativeView = self.nativeView as? GameViewControllerView
        nativeView?.updateTimeBoostSupportWithTimeBoostAction()
    }
    
    func gameOver() {
        session.gameOver()
        let nativeView = self.nativeView as? GameViewControllerView
        nativeView?.gameOver(score: session.getScore())
    }
    
    func restart() {
        print("restart.....")
    }
    
    func bindToObservable(observable: Observable<[Bool]>){
        observable.bind { [weak self] result in
            guard let self = self else {return}
                self.nextQuestion()
        }
    }
    
    func bindToCounter(observable: Observable<Int>) {
        _ = observable.bind {count in
            let nativeView = self.nativeView as? GameViewControllerView
            nativeView?.timerView.counter.text = String(count)
        }
    }
}
