import UIKit

class MenuViewControllerView: NativeView {
    
    var menu: MenuStackView!
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
        menu = MenuStackView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.10))
        menu.delegate = (self.viewContoller as! ViewSelectable)
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
