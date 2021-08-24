import UIKit

class MenuViewControllerView: NativeView {
    
    var menu: UIStackView!
    var background: UIImageView!
    
    override func didMoveToWindow() {
        configureBackground()
    }
    
    private func configureBackground(){
        background = UIImageView(frame: UIScreen.main.bounds)
        background.image = UIImage(named: "Background")
        addSubview(background)
        configureMenuButtons()
    }
    
    private func configureMenuButtons() {
        menu = UIStackView()
        menu.axis = .horizontal
        menu.distribution = .fillEqually
        menu.spacing = 20
        menu.isLayoutMarginsRelativeArrangement = true
        menu.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 5, bottom: 16, trailing: 5)
        menu.addBackground(color: .brandNavyBlue)

        let play = MenuButton()
        play.setTitle("Play", for: .normal)
        play.delegate = (self.viewContoller as! StackViewSelectable)
        menu.addArrangedSubviews(views: [play])
        addSubview(menu)
        setMenuConstraints()
    }
    
    private func setMenuConstraints() {
        menu.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [menu.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                            menu.leadingAnchor.constraint(equalTo: leadingAnchor),
                            menu.trailingAnchor.constraint(equalTo: trailingAnchor),
                            menu.heightAnchor.constraint(equalToConstant: frame.height * 0.10)]
        NSLayoutConstraint.activate(constraints)
    }
}
