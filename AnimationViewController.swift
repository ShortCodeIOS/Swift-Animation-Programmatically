import UIKit

class ViewController: UIViewController {
    
    private var animatedMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Menu", for: .normal)
        button.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var endMenuAnchor = animatedMenuView.topAnchor.constraint(equalTo: view.topAnchor)
    private lazy var startMenuAnchor = animatedMenuView.bottomAnchor.constraint(equalTo: view.topAnchor)
    
    private var menuIsOpen = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        addConstraints()
    }
    
    @objc
    func menuButtonAction() {
        UIView.animate(withDuration: 0.5, delay: 0) { [weak self] in
            guard let self = self else { return }
            self.startMenuAnimation()
        }
        menuIsOpen.toggle()
    }
    
    func startMenuAnimation() {
        menuIsOpen ? remakeConstraintsToCloseMenu() : remakeConstraintsToOpenMenu()
        view.layoutSubviews()
    }
}

extension ViewController {
    func setupView() {
        view.addSubview(animatedMenuView)
        view.addSubview(menuButton)
    }
    
    func addConstraints() {
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        //Start position
        animatedMenuView.translatesAutoresizingMaskIntoConstraints = false
        animatedMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animatedMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animatedMenuView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        startMenuAnchor.isActive = true
    }
    
    func remakeConstraintsToOpenMenu() {
        startMenuAnchor.isActive = false
        endMenuAnchor.isActive = true
    }
    
    func remakeConstraintsToCloseMenu() {
        endMenuAnchor.isActive = false
        startMenuAnchor.isActive = true
    }
}
