//
//  CardVC.swift
//  Apple Store
//
//  Created by Gamid Gapizov on 24.01.2024.
//

import UIKit
import SnapKit

final class CardVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    private let darkestGray = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
    private let scrollView = UIScrollView()
    private let horizontalScrollView = UIScrollView()
    private let countTextField = UITextField()
    private let lineView = UIView()
    
    
    //Product info
    public var cardLabel: UILabel = {
        let cardLabel = UILabel()
        cardLabel.font = .systemFont(ofSize: 15, weight: .bold)
        cardLabel.textColor = .white
        cardLabel.numberOfLines = 1
        cardLabel.textAlignment = .center
        return cardLabel
    }()
    public var cardPriceLabel: UILabel = {
        let cardPriceLabel = UILabel()
        cardPriceLabel.font = .systemFont(ofSize: 15, weight: .regular)
        cardPriceLabel.textColor = .systemGray
        return cardPriceLabel
    }()
    private var cardSubLabel: UILabel = {
        let cardSubLabel = UILabel()
        cardSubLabel.text = "Available in 2 finishes"
        cardSubLabel.font = .systemFont(ofSize: 10, weight: .regular)
        cardSubLabel.textColor = .systemGray
        return cardSubLabel
    }()
    private var compatibleLabel = UILabel()
    private var myDeviceLabel = UILabel()
    private var checkIV: UIImageView = {
        let checkIV = UIImageView()
        checkIV.image = UIImage(systemName: "checkmark.circle.fill")
        checkIV.tintColor = .green
        return checkIV
    }()
    
    
    //Product images
    public var cardImage1 = UIImage()
    public var cardImage2 = UIImage()
    public var cardImage3 = UIImage()
    private var productCardIV1: UIImageView = {
        let productCardIV1 = UIImageView()
        productCardIV1.contentMode = .scaleAspectFit
        return productCardIV1
    }()
    private var productCardIV2: UIImageView = {
        let productCardIV2 = UIImageView()
        productCardIV2.contentMode = .scaleAspectFit
        return productCardIV2
    }()
    private var productCardIV3: UIImageView = {
        let productCardIV3 = UIImageView()
        productCardIV3.contentMode = .scaleAspectFit
        return productCardIV3
    }()
    
    
    //Product colors and buy button
    private var colorButton1: UIButton = {
        let colorButton1 = UIButton()
        colorButton1.setBackgroundImage(UIImage(named: "Silver Color"), for: .normal)
        colorButton1.configuration?.cornerStyle = .capsule
        colorButton1.layer.cornerRadius = 17.5
        return colorButton1
    }()
    private var colorButton2: UIButton = {
        let colorButton2 = UIButton()
        colorButton2.setBackgroundImage(UIImage(named: "Space Gray Color"), for: .normal)
        colorButton2.configuration?.cornerStyle = .capsule
        colorButton2.layer.cornerRadius = 17.5
        return colorButton2
    }()
    private let cardBuyButton: UIButton = {
        let cardBuyButton = UIButton()
        cardBuyButton.backgroundColor = .systemBlue
        cardBuyButton.setTitle("Add to card", for: .normal)
        cardBuyButton.setTitleColor(.white, for: .normal)
        cardBuyButton.layer.cornerRadius = 10
        return cardBuyButton
    }()
    
    
    //Delivery info
    private let deliveryIcon: UIImageView = {
        let deliveryIcon = UIImageView()
        deliveryIcon.image = UIImage(systemName: "shippingbox")
        deliveryIcon.tintColor = .systemGray
        return deliveryIcon
    }()
    private let deliveryLabel: UILabel = {
        let deliveryLabel = UILabel()
        deliveryLabel.text = "Order today during of day, delivery:"
        deliveryLabel.font = .systemFont(ofSize: 15, weight: .bold)
        deliveryLabel.textColor = .white
        return deliveryLabel
    }()
    private let deliverySubLabel: UILabel = {
        let deliverySubLabel = UILabel()
        deliverySubLabel.font = .systemFont(ofSize: 15, weight: .regular)
        deliverySubLabel.textColor = .systemGray
        return deliverySubLabel
    }()
    private let deliveryOptionsLabel: UILabel = {
        let deliveryOptionsLabel = UILabel()
        deliveryOptionsLabel.text = "Delivery options for location: 115533"
        deliveryOptionsLabel.font = .systemFont(ofSize: 15, weight: .regular)
        deliveryOptionsLabel.textColor = .systemBlue
        return deliveryOptionsLabel
    }()
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBar()
        createScrollView()
        createTopSection()
        createOptionsSection()
        createDeliverySection()
        
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillShowNotification, object: nil, queue: nil) { Notification in self.view.frame.origin.y = -200.0 }
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillHideNotification, object: nil, queue: nil) { Notification in self.view.frame.origin.y = 0.0 }
        
        scrollView.snp.makeConstraints { make in make.bottom.equalTo(deliveryOptionsLabel.snp.bottom) }
    }
    
    
    // MARK: ViewDidLoad
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.tabBarController?.tabBar.backgroundColor = .black
    }
    
    
    // MARK: UI setup methods
    private func createNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = darkestGray
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.compactScrollEdgeAppearance = appearance
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(method))
        let likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(method))
        navigationItem.rightBarButtonItems = [shareButton, likeButton]
    }
    private func createScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .black
        scrollView.indicatorStyle = .white
        scrollView.delegate = self
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func createTopSection() {
        //
        scrollView.addSubview(cardLabel)
        cardLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
        }
        
        scrollView.addSubview(cardPriceLabel)
        cardPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(cardLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        
        //
        scrollView.addSubview(lineView)
        
        scrollView.addSubview(horizontalScrollView)
        horizontalScrollView.isPagingEnabled = true
        horizontalScrollView.delegate = self
        horizontalScrollView.indicatorStyle = .black
        horizontalScrollView.snp.makeConstraints { make in
            make.top.equalTo(cardPriceLabel).inset(40)
            make.height.equalTo(220)
            make.width.equalTo(400)
        }
        horizontalScrollView.contentSize = CGSize(width: 400 * 3, height: 220)
        
        
        //
        horizontalScrollView.addSubview(productCardIV1)
        productCardIV1.image = cardImage1
        productCardIV1.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        horizontalScrollView.addSubview(productCardIV2)
        productCardIV2.image = cardImage2
        productCardIV2.contentMode = .scaleAspectFit
        productCardIV2.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(300)
            make.left.equalTo(productCardIV1).inset(400)
            make.top.equalToSuperview()
        }
        
        horizontalScrollView.addSubview(productCardIV3)
        productCardIV3.image = cardImage3
        productCardIV3.contentMode = .scaleAspectFit
        productCardIV3.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(300)
            make.left.equalTo(productCardIV2).inset(400)
            make.top.equalToSuperview()
        }
        
        
        //
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(horizontalScrollView.snp.bottom).inset(3)
            make.width.equalTo(380)
            make.centerX.equalTo(view)
            make.height.equalTo(3)
        }
        lineView.backgroundColor = .systemGray
        
        scrollView.addSubview(cardSubLabel)
        cardSubLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalScrollView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
    }
    private func createOptionsSection() {
        //
        scrollView.addSubview(colorButton1)
        colorButton1.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.top.equalTo(cardSubLabel.snp.bottom).offset(20)
            make.left.equalTo(view).inset(152)
        }
        colorButton1.imageView?.setRounded()
        colorButton1.layer.masksToBounds = true
        
        scrollView.addSubview(colorButton2)
        colorButton2.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.top.equalTo(cardSubLabel.snp.bottom).offset(20)
            make.right.equalTo(view).inset(152)
        }
        colorButton2.imageView?.setRounded()
        colorButton2.layer.masksToBounds = true
        
        
        colorButton1.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        colorButton2.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        
        //
        scrollView.addSubview(compatibleLabel)
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Compatible with your: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]));
        text.append(NSAttributedString(string: "Macbook Air 15'", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        compatibleLabel.attributedText = text
        compatibleLabel.font = .systemFont(ofSize: 10, weight: .regular)
        compatibleLabel.snp.makeConstraints { make in
            make.top.equalTo(colorButton1.snp.bottom).offset(40)
            make.centerX.equalTo(view).inset(15)
        }
        
        scrollView.addSubview(checkIV)
        checkIV.snp.makeConstraints { make in
            make.centerY.equalTo(compatibleLabel)
            make.centerX.equalTo(compatibleLabel.snp.left).inset(-15)
            make.height.width.equalTo(15)
        }
        
        
        //
        scrollView.addSubview(cardBuyButton)
        cardBuyButton.snp.makeConstraints { make in
            make.top.equalTo(compatibleLabel.snp.bottom).offset(40)
            make.centerX.equalTo(view)
            make.width.equalTo(380)
            make.height.equalTo(50)
        }
        cardBuyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        
        
        //
        scrollView.addSubview(countTextField)
        countTextField.placeholder = "Enter the quantity..."
        countTextField.borderStyle = .roundedRect
        countTextField.backgroundColor = .white
        countTextField.textColor = .black
        countTextField.snp.makeConstraints { make in
            make.top.equalTo(cardBuyButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.centerX.equalTo(cardBuyButton)
            make.height.equalTo(35)
        }
        countTextField.isHidden = true
        countTextField.delegate = self
        countTextField.textAlignment = .center
    }
    private func createDeliverySection() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM"
        let formatedDate = dateFormatter.string(from: date)
        
        scrollView.addSubview(deliveryIcon)
        deliveryIcon.snp.makeConstraints { make in
            make.left.equalTo(cardBuyButton.snp.left)
            make.top.equalTo(cardBuyButton.snp.bottom).offset(60)
        }
        
        scrollView.addSubview(deliveryLabel)
        deliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryIcon.snp.top)
            make.left.equalTo(deliveryIcon.snp.right).offset(15)
        }
        
        scrollView.addSubview(deliverySubLabel)
        deliverySubLabel.text = "\(formatedDate) – Free"
        deliverySubLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryLabel.snp.bottom).offset(3)
            make.left.equalTo(deliveryLabel)
        }
        
        scrollView.addSubview(deliveryOptionsLabel)
        deliveryOptionsLabel.snp.makeConstraints { make in
            make.top.equalTo(deliverySubLabel.snp.bottom).offset(3)
            make.left.equalTo(deliveryLabel)
        }
    }
    
    
    // MARK: @objc methods
    @objc func buttonTapped(sender: UIButton) {
        if sender == colorButton1 {
            colorButton2.layer.borderWidth = 0
            colorButton2.layer.borderColor = .init(red: 0/255, green: 122/255, blue: 255/255, alpha: 0)
            
            colorButton1.layer.borderWidth = 2
            colorButton1.layer.borderColor = .init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        } else if sender == colorButton2 {
            colorButton1.layer.borderWidth = 0
            colorButton1.layer.borderColor = .init(red: 0/255, green: 122/255, blue: 255/255, alpha: 0)
            
            colorButton2.layer.borderWidth = 2
            colorButton2.layer.borderColor = .init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        }
    }
    @objc func buyButtonTapped() {
        countTextField.isHidden = false
        countTextField.becomeFirstResponder()
    }
    
    
    // MARK: TextField methods
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        countTextField.resignFirstResponder()
        return true
    }
    internal func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        cardBuyButton.setTitle("\(countTextField.text!) pcs added to cart", for: .normal)
        countTextField.isHidden = true
        return true
    }
}


// MARK: Extension to make UIImageView rounded
extension UIImageView {
    func setRounded() {
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
