import UIKit

class CharacterView: UIView {
    
    var profilePic: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        profilePic = UIImageView()
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        profilePic.contentMode = .scaleAspectFit
        profilePic.clipsToBounds = true
        addSubview(profilePic)
        backgroundColor = .yellow
        setProfilePicConstraints()
    }
    
    private func setProfilePicConstraints() {
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [profilePic.topAnchor.constraint(equalTo: topAnchor),
                            profilePic.leadingAnchor.constraint(equalTo: leadingAnchor),
                            profilePic.trailingAnchor.constraint(equalTo: trailingAnchor),
                            profilePic.bottomAnchor.constraint(equalTo: bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
