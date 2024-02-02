//
//  WelcomeViewController.swift
//  Apple Store
//
//  Created by Gamid Gapizov on 01.02.2024.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let welcomePic: UIImageView = {
       let IV = UIImageView()
        IV.layer.cornerRadius = 20
        IV.layer.masksToBounds = true
        IV.contentMode = .scaleAspectFill
        IV.translatesAutoresizingMaskIntoConstraints = false
        return IV
    }()
    
    private let welcomeLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let welcomeSubLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var welcomeButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray5, for: .highlighted)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var subView: [UIView] = [self.welcomePic, self.welcomeLabel, self.welcomeSubLabel, self.welcomeButton]
    
    init(source: WelcomePageStructure) {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        
        welcomePic.image = source.image
        welcomeLabel.text = source.text
        welcomeSubLabel.text = source.subText
        
        switch source.button {
        case true:
            welcomeButton.isHidden = false
            welcomeButton.setTitle(source.buttonText, for: .normal)
            welcomeButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        case false:
            welcomeButton.isHidden = true
        default:
            break
        }
        
        for view in subView { self.view.addSubview(view) }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: welcomePic, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: welcomePic, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: welcomePic, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: welcomePic, attribute:  .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: welcomeLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: welcomeLabel, attribute: .top, relatedBy: .equal, toItem: welcomePic, attribute: .bottom, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: welcomeLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: welcomeSubLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: welcomeSubLabel, attribute: .top, relatedBy: .equal, toItem: welcomeLabel, attribute: .bottom, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: welcomeSubLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: welcomeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: welcomeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: welcomeButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -180),
            NSLayoutConstraint(item: welcomeButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed(sender: UIButton) {
        self.dismiss(animated: true)
    }
}
