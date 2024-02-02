//
//  AccountVC.swift
//  Apple Store
//
//  Created by Gamid Gapizov on 24.01.2024.
//

import UIKit
import SnapKit

final class AccountVC: UIViewController, UIScrollViewDelegate {
    
    
    let data = DataModel()
    let changedPhoto = UserDefaults.standard.bool(forKey: "changedPhoto") as Bool
    
    
    //Top bar section
    private let photoPicker = ImagePicker()
    private var tapRecognizer = UITapGestureRecognizer()
    private var myTimer = Timer()
    private var scrollView = UIScrollView()

    
    //Top bar section
    public let avatarIV: UIImageView = {
        let avatarIV = UIImageView()
        avatarIV.contentMode = .scaleAspectFill
        avatarIV.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        avatarIV.clipsToBounds = true
        avatarIV.translatesAutoresizingMaskIntoConstraints = false
        avatarIV.isUserInteractionEnabled = true
        return avatarIV
    }()
    private let whatsNewLabel = UILabel()
    
    
    //Order section
    public let orderBannerView = UIView()
    private let orderIV: UIImageView = {
        let orderIV = UIImageView()
        orderIV.image = UIImage(named: "airpods")
        orderIV.contentMode = .scaleAspectFit
        return orderIV
    }()
    private let orderLabel: UILabel = {
        let orderLabel = UILabel()
        orderLabel.text = "Your order is on the way"
        orderLabel.font = .systemFont(ofSize: 15, weight: .bold)
        return orderLabel
    }()
    private let orderSubLabel: UILabel = {
        let orderSubLabel = UILabel()
        orderSubLabel.text = "1 piece, delivery is tomorrow"
        orderSubLabel.font = .systemFont(ofSize: 15, weight: .regular)
        orderSubLabel.textColor = .systemGray
        return orderSubLabel
    }()
    public let orderProgress: UIProgressView = {
        let orderProgress = UIProgressView()
        orderProgress.progress = 0.0
        orderProgress.progressViewStyle = .default
        orderProgress.progressTintColor = .systemGreen
        return orderProgress
    }()
    private let orderProcessingLabel: UILabel = {
        let orderProcessingLabel = UILabel()
        orderProcessingLabel.text = "Processing"
        orderProcessingLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        orderProcessingLabel.textColor = .black
        return orderProcessingLabel
    }()
    public let orderSendedLabel: UILabel = {
        let orderSendedLabel = UILabel()
        orderSendedLabel.text = "Sended"
        orderSendedLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        orderSendedLabel.textColor = .systemGray
        return orderSendedLabel
    }()
    private let orderDeliveredLabel: UILabel = {
        let orderDeliveredLabel = UILabel()
        orderDeliveredLabel.text = "Delivered"
        orderDeliveredLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        orderDeliveredLabel.textColor = .systemGray
        return orderDeliveredLabel
    }()
    public let orderButton: UIButton = {
        let orderButton = UIButton()
        orderButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        orderButton.imageView?.tintColor = .systemGray
        orderButton.imageView?.contentMode = .scaleAspectFit
        return orderButton
    }()
    
    
    //Recommended section
    private let recommendedLabel = UILabel()
    private let notificationIV: UIImageView = {
        let notificationIV = UIImageView()
        notificationIV.image = UIImage(systemName: "app.badge")
        notificationIV.tintColor = .systemRed
        notificationIV.contentMode = .scaleAspectFit
        return notificationIV
    }()
    private let notificationLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.text = "Recieve news about your orders in real time mode"
        notificationLabel.font = .systemFont(ofSize: 15, weight: .bold)
        notificationLabel.textColor = .black
        notificationLabel.sizeToFit()
        notificationLabel.numberOfLines = 3
        return notificationLabel
    }()
    private let notificationSubLabel: UILabel = {
        let notificationSubLabel = UILabel()
        notificationSubLabel.text = "Turn on the notifications to get news about your orders"
        notificationSubLabel.font = .systemFont(ofSize: 14, weight: .regular)
        notificationSubLabel.textColor = .systemGray
        notificationSubLabel.sizeToFit()
        notificationSubLabel.numberOfLines = 0
        return notificationSubLabel
    }()
    private let notificationButton: UIButton = {
        let notificationButton = UIButton()
        notificationButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        notificationButton.imageView?.tintColor = .systemGray3
        notificationButton.imageView?.contentMode = .scaleAspectFit
        return notificationButton
    }()
    
    
    //Dividers for design
    private let dividerBar: UIView = {
        let dividerBar = UIView()
        dividerBar.backgroundColor = .systemGray5
        return dividerBar
    }()
    private let dividerBar2: UIView = {
        let dividerBar2 = UIView()
        dividerBar2.backgroundColor = .systemGray5
        return dividerBar2
    }()
    
    
    //My devices section
    private let yourDevicesLabel = UILabel()
    private let showDevicesButton: UIButton = {
        let showDevicesButton = UIButton()
        showDevicesButton.setTitle("Show all", for: .normal)
        showDevicesButton.setTitleColor(.systemBlue, for: .normal)
        showDevicesButton.setTitleColor(.systemCyan, for: .highlighted)
        showDevicesButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        return showDevicesButton
    }()
    private let myDeviceIV: UIImageView = {
        let myDeviceIV = UIImageView()
        myDeviceIV.image = UIImage(named: "iphone 14")
        myDeviceIV.contentMode = .scaleAspectFit
        return myDeviceIV
    }()
    public let myDeviceLabel: UILabel = {
        let myDeviceLabel = UILabel()
        myDeviceLabel.text = "iPhone 14"
        myDeviceLabel.font = .systemFont(ofSize: 15)
        return myDeviceLabel
    }()
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        createNavBar()

        if changedPhoto { didChangePhoto() } else { didntChangePhoto() }
        
        createScrollView()
        createOrderSection()
        createNotificationSection()
        createMyDevicesSection()
        
        scrollView.snp.makeConstraints { make in make.bottom.equalTo(myDeviceLabel.snp.bottom).offset(40) }
    }
    
    
    // MARK: ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        orderBannerView.dropShadow(color: .black, opacity: 0.2, offSet: .init(width: 3, height: 10), radius: 10, scale: true)
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
    }
    
    
    // MARK: ViewDidDissapear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        orderProgress.progress = 0
        orderSendedLabel.textColor = .systemGray
    }
    
    
    // MARK: UI setup section
    private func createScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.indicatorStyle = .black
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentSize = .init(width: view.frame.width, height: view.frame.height)
        scrollView.delegate = self
    }
    private func createNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        title = "For you"
        navigationItem.largeTitleDisplayMode = .automatic
        
        guard let nav = navigationController?.navigationBar else { return }
        nav.prefersLargeTitles = true
        nav.standardAppearance = appearance
        nav.scrollEdgeAppearance = appearance
        nav.compactAppearance = appearance
        nav.compactScrollEdgeAppearance = appearance
        nav.isTranslucent = true
        nav.sizeToFit()
        
        nav.addSubview(avatarIV)
        NSLayoutConstraint.activate([
            avatarIV.rightAnchor.constraint(equalTo: nav.rightAnchor, constant: -Const.ImageRightMargin),
            avatarIV.bottomAnchor.constraint(equalTo: nav.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            avatarIV.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            avatarIV.widthAnchor.constraint(equalTo: avatarIV.heightAnchor)
        ])
        
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        avatarIV.isUserInteractionEnabled = true
        avatarIV.addGestureRecognizer(tapRecognizer)
    }
    private func createLabel(label: UILabel, text: String, color: UIColor, size: CGFloat, weight: UIFont.Weight = .bold, topConstraint: ConstraintRelatableTarget, topOffset: ConstraintOffsetTarget, leftConstraint: ConstraintRelatableTarget, leftOffset: ConstraintOffsetTarget) {
        scrollView.addSubview(label)
        label.text = text
        label.textColor = color
        label.font = .systemFont(ofSize: size, weight: weight)
        label.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(topOffset)
            make.left.equalTo(leftConstraint).offset(leftOffset)
        }
    }
    private func createOrderSection() {
        createLabel(label: whatsNewLabel, text: "What's new", color: .black, size: 30, topConstraint: scrollView, topOffset: 30, leftConstraint: view, leftOffset: 18)
        
        scrollView.addSubview(orderBannerView)
        orderBannerView.backgroundColor = .white
        orderBannerView.layer.cornerRadius = 15
        orderBannerView.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(150)
            make.top.equalTo(whatsNewLabel).offset(70)
            make.centerX.equalToSuperview()
        }
        
        orderBannerView.addSubview(orderIV)
        orderIV.snp.makeConstraints { make in
            make.top.equalTo(orderBannerView).offset(10)
            make.left.equalTo(orderBannerView).offset(15)
            make.width.height.equalTo(70)
        }
        
        orderBannerView.addSubview(orderLabel)
        orderLabel.snp.makeConstraints { make in
            make.top.equalTo(orderIV.snp.top).offset(10)
            make.left.equalTo(orderIV.snp.right).offset(14)
        }
        
        
        orderBannerView.addSubview(orderSubLabel)
        orderSubLabel.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(7)
            make.left.equalTo(orderLabel)
        }
        
        orderBannerView.addSubview(dividerBar)
        dividerBar.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(orderBannerView)
            make.centerX.equalTo(orderBannerView)
            make.top.equalTo(orderSubLabel.snp.bottom).offset(25)
        }
        
        orderBannerView.addSubview(orderProgress)
        orderProgress.snp.makeConstraints { make in
            make.top.equalTo(dividerBar.snp.bottom).offset(20)
            make.width.equalTo(320)
            make.height.equalTo(6)
            make.centerX.equalTo(orderBannerView)
        }
        
        orderBannerView.addSubview(orderProcessingLabel)
        orderProcessingLabel.snp.makeConstraints { make in
            make.left.equalTo(orderProgress.snp.left)
            make.top.equalTo(orderProgress.snp.bottom).offset(10)
        }
        
        orderBannerView.addSubview(orderSendedLabel)
        orderSendedLabel.snp.makeConstraints { make in
            make.centerX.equalTo(orderProgress)
            make.top.equalTo(orderProgress.snp.bottom).offset(10)
        }
        
        orderBannerView.addSubview(orderDeliveredLabel)
        orderDeliveredLabel.snp.makeConstraints { make in
            make.right.equalTo(orderProgress.snp.right)
            make.top.equalTo(orderProgress.snp.bottom).offset(10)
        }
        
        orderBannerView.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.centerY.equalTo(orderSubLabel)
            make.right.equalTo(orderBannerView.snp.right).inset(10)
            make.width.height.equalTo(25)
        }
    }
    private func createNotificationSection() {
        createLabel(label: recommendedLabel, text: "Recommended for you", color: .black, size: 30, topConstraint: orderBannerView.snp.bottom, topOffset: 70, leftConstraint: whatsNewLabel, leftOffset: 0)
        
        scrollView.addSubview(notificationIV)
        notificationIV.snp.makeConstraints { make in
            make.top.equalTo(recommendedLabel.snp.bottom).offset(30)
            make.left.equalTo(recommendedLabel.snp.left)
            make.width.height.equalTo(50)
        }
        
        scrollView.addSubview(notificationLabel)
        notificationLabel.snp.makeConstraints { make in
            make.top.equalTo(notificationIV)
            make.left.equalTo(notificationIV.snp.right).offset(20)
            make.right.equalTo(view).inset(60)
        }
        
        scrollView.addSubview(notificationSubLabel)
        notificationSubLabel.snp.makeConstraints { make in
            make.top.equalTo(notificationLabel.snp.bottom).offset(5)
            make.left.equalTo(notificationLabel)
            make.right.equalTo(notificationLabel)
        }
        
        scrollView.addSubview(dividerBar2)
        dividerBar2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(view)
            make.centerX.equalTo(view)
            make.top.equalTo(notificationSubLabel.snp.bottom).offset(25)
        }
        
        scrollView.addSubview(notificationButton)
        notificationButton.snp.makeConstraints { make in
            make.bottom.equalTo(notificationSubLabel.snp.top)
            make.right.equalTo(view).inset(20)
            make.width.height.equalTo(20)
        }
    }
    private func createMyDevicesSection() {
        createLabel(label: yourDevicesLabel, text: "Your devices", color: .black, size: 30, topConstraint: dividerBar2, topOffset: 60, leftConstraint: whatsNewLabel, leftOffset: 0)
        
        scrollView.addSubview(showDevicesButton)
        showDevicesButton.snp.makeConstraints { make in
            make.centerY.equalTo(yourDevicesLabel)
            make.right.equalTo(orderBannerView.snp.right)
        }
        
        scrollView.addSubview(myDeviceIV)
        myDeviceIV.snp.makeConstraints { make in
            make.left.equalTo(yourDevicesLabel)
            make.top.equalTo(yourDevicesLabel.snp.bottom).offset(25)
            make.width.equalTo(100)
            make.height.equalTo(133)
        }
        
        scrollView.addSubview(myDeviceLabel)
        myDeviceLabel.snp.makeConstraints { make in
            make.top.equalTo(myDeviceIV.snp.bottom).offset(10)
            make.centerX.equalTo(myDeviceIV)
        }
    }
    
    
    // MARK: Methods for loading profile picture
    private func didntChangePhoto() {
        let catImage = UIImage(named: "cat")
        avatarIV.image = catImage
    }
    private func didChangePhoto() {
        var loadedImage: UIImage?
        loadedImage = UIImage(data: UserDefaults.standard.data(forKey: "savedImage")!)
        avatarIV.image = loadedImage
    }
    
    
    // MARK: Methods for setting up profile picture right
    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        
        let yTranslation: CGFloat = {
            // This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        avatarIV.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    private func showProfilePicture(_ show: Bool) {
        UIView.animate(withDuration: 0.4) {
            self.avatarIV.alpha = show ? 1.0 : 0.0
        }
    }
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)
        
        //Removes profile picture when scroll is down
        if scrollView.contentOffset.y > -132.0 {
            showProfilePicture(false)
        } else if scrollView.contentOffset.y < -132.0 {
            showProfilePicture(true)
        }
    }
    
    
    // MARK: @Objc methods
    @objc func updateProgressView() {         //Creates smooth load animation
        if orderProgress.progress != 0.5 {
            orderProgress.setProgress(0.5, animated: true)
        } else if orderProgress.progress == 0.5 {
            UIView.animate(withDuration: 0.5) {
                self.orderSendedLabel.textColor = .black
                self.myTimer.invalidate()
            }
        }
    }
    @objc func changePic(tapGestureRecognizer: UITapGestureRecognizer){         //Choosing profile picture
        print("changepiccalled")
        let imageAlert = UIAlertController(title: "Select one...", message: "How you want to pick the photo?", preferredStyle: .actionSheet)
        
        imageAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            //Action if user choose to make a photo
            self.photoPicker.openImageCamera(in: self) { [self] pickedImage in
                avatarIV.image = pickedImage
                UserDefaults.standard.setValue(pickedImage.jpegData(compressionQuality: 0.5)!, forKey: "savedImage")
                UserDefaults.standard.set(true, forKey: "changedPhoto")
                print("Changing photo...")
            }
        }))
        
        imageAlert.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { action in
            //Action if user choose to open photo library
            self.photoPicker.showImagePicker(in: self) { [self] pickedImage in
                avatarIV.image = pickedImage
                UserDefaults.standard.setValue(pickedImage.jpegData(compressionQuality: 0.5)!, forKey: "savedImage")
                UserDefaults.standard.set(true, forKey: "changedPhoto")
                print("Changing photo...")
            }
        }))
        
        //Cancel choosing photo
        imageAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            imageAlert.dismiss(animated: true)
        }))
        
        self.present(imageAlert, animated: true)
    }
}


extension UIView {         //Extension for creating shadow
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}


private struct Const {         //Structure for setting up profile picture correctly. Thanks to @tungfam
    // Image height/width for Large NavBar state
    static let ImageSizeForLargeState: CGFloat = 40
    // Margin from right anchor of safe area to right anchor of Image
    static let ImageRightMargin: CGFloat = 16
    // Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ImageBottomMarginForLargeState: CGFloat = 12
    // Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ImageBottomMarginForSmallState: CGFloat = 6
    // Image height/width for Small NavBar state
    static let ImageSizeForSmallState: CGFloat = 32
    // Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    // Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}
