//
//  SearchVC.swift
//  Apple Store
//
//  Created by Gamid Gapizov on 24.01.2024.
//

import UIKit
import SnapKit

final class SearchVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for products"
        searchBar.contentMode = .scaleAspectFit
        searchBar.barTintColor = .black
        searchBar.barStyle = .black
        return searchBar
    }()
    
    private let recentLabel: UILabel = {
        let recentLabel = UILabel()
        recentLabel.text = "Recents"
        recentLabel.font = .systemFont(ofSize: 25, weight: .bold)
        recentLabel.textColor = .white
        return recentLabel
    }()
    private let cleanRecentButton: UIButton = {
        let cleanRecentButton = UIButton()
        cleanRecentButton.setTitle("Clean", for: .normal)
        cleanRecentButton.setTitleColor(.systemBlue, for: .normal)
        cleanRecentButton.setTitleColor(.white, for: .highlighted)
        cleanRecentButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        return cleanRecentButton
    }()
    
    
    public let productCardView1 = UIView()
    public let productCardView2 = UIView()
    public let productCardView3 = UIView()
    
    public let productCardIV1 = UIImageView()
    public let productCardIV2 = UIImageView()
    public let productCardIV3 = UIImageView()
    
    public let productCardLabel1 = UILabel()
    public let productCardLabel2 = UILabel()
    public let productCardLabel3 = UILabel()
    
    
    private let suggestLabel: UILabel = {
        let suggestLabel = UILabel()
        suggestLabel.text = "Popular searches"
        suggestLabel.font = .systemFont(ofSize: 25, weight: .bold)
        suggestLabel.textColor = .white
        return suggestLabel
    }()
    private var suggestTableView: UITableView = {
        let suggestTableView = UITableView()
        suggestTableView.isScrollEnabled = false
        suggestTableView.separatorColor = .systemGray
        suggestTableView.isUserInteractionEnabled = false
        suggestTableView.separatorInset = .zero
        return suggestTableView
    }()
    
    
    //Data for UITableView
    private let suggestIdentifier = "suggestCell"
    private let suggestArray = ["AirPods", "AppleCare", "Beats", "iPhone 15 Pro Max"]
    
    
    private let scrollView = UIScrollView()
    private let darkestGray = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createScrollView()
        createSearchBar()
        createRecentSection()
        createSuggestionSection()
        
        let tapRecogniser1 = UITapGestureRecognizer(target: self, action: #selector(cardSheetOpen))
        let tapRecogniser2 = UITapGestureRecognizer(target: self, action: #selector(cardSheetOpen))
        let tapRecogniser3 = UITapGestureRecognizer(target: self, action: #selector(cardSheetOpen))
        productCardIV1.addGestureRecognizer(tapRecogniser1)
        productCardIV2.addGestureRecognizer(tapRecogniser2)
        productCardIV3.addGestureRecognizer(tapRecogniser3)
    }
    
    
    // MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createNavBar()
        navigationController?.tabBarController?.tabBar.backgroundColor = .black
    }
    
    // MARK: ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let scrollWidth = productCardView1.frame.size.width + productCardView2.frame.size.width + productCardView3.frame.size.width
        scrollView.contentSize = CGSize(width: scrollWidth + 80, height: 220)
    }
    
    
    // MARK: Creates a product card
    private func createProductCard(theView: UIView, theIV: UIImageView, theLabel: UILabel, parentConstraint: ConstraintRelatableTarget, constraintAmount: ConstraintOffsetTarget, imageName: String, labelText: String) {
        scrollView.addSubview(theView)
        theView.backgroundColor = darkestGray
        theView.layer.cornerRadius = 10
        theView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(140)
            make.top.equalTo(recentLabel).offset(50)
            make.left.equalTo(parentConstraint).offset(constraintAmount)
        }
        
        theView.addSubview(theIV)
        theIV.image = UIImage(named: imageName)
        theIV.contentMode = .scaleAspectFit
        theIV.isUserInteractionEnabled = true
        theIV.snp.makeConstraints { make in
            make.centerX.equalTo(theView)
            make.top.equalTo(theView)
            make.height.width.equalTo(140)
        }
        
        theView.addSubview(theLabel)
        theLabel.text = labelText
        theLabel.font = .systemFont(ofSize: 15, weight: .bold)
        theLabel.textColor = .white
        theLabel.numberOfLines = 3
        theLabel.lineBreakMode = .byWordWrapping
        theLabel.textAlignment = .left
        theLabel.sizeToFit()
        theLabel.snp.makeConstraints { make in
            make.centerX.equalTo(theView)
            make.bottom.equalTo(theView).inset(25)
            make.width.equalTo(120)
        }
    }
    
    
    // MARK: UI setup methods
    private func createNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.compactScrollEdgeAppearance = appearance
        
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode =  .always
    }
    private func createScrollView() {
        view.addSubview(scrollView)
        scrollView.indicatorStyle = .black
        scrollView.delegate = self
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.height.equalTo(220)
            make.width.equalTo(400)
        }
    }
    private func createSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(140)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(375)
        }
    }
    private func createRecentSection() {
        view.addSubview(recentLabel)
        recentLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar).offset(70)
            make.left.equalToSuperview().inset(20)
        }
        
        view.addSubview(cleanRecentButton)
        cleanRecentButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentLabel)
            make.right.equalToSuperview().inset(20)
        }
        
        createProductCard(theView: productCardView1, theIV: productCardIV1, theLabel: productCardLabel1, parentConstraint: scrollView, constraintAmount: 20, imageName: "Mac Mini Front", labelText: "Mac Studio 2022 (M2 Max)")
        createProductCard(theView: productCardView2, theIV: productCardIV2, theLabel: productCardLabel2, parentConstraint: productCardView1, constraintAmount: 150, imageName: "Apple Display Front", labelText: "Studio Display 27'")
        createProductCard(theView: productCardView3, theIV: productCardIV3, theLabel: productCardLabel3, parentConstraint: productCardView2, constraintAmount: 150, imageName: "HomePod", labelText: "HomePod 2023 Midnight")
    }
    private func createSuggestionSection() {
        view.addSubview(suggestLabel)
        suggestLabel.snp.makeConstraints { make in
            make.top.equalTo(productCardView1.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(20)
        }
        
        suggestTableView = UITableView(frame: view.bounds, style: .plain)
        suggestTableView.register(UITableViewCell.self, forCellReuseIdentifier: suggestIdentifier)
        suggestTableView.dataSource = self
        suggestTableView.delegate = self
        suggestTableView.frame = CGRect(x: 0, y: 530, width: 350, height: 180)
        suggestTableView.center.x = view.center.x
        view.addSubview(suggestTableView)
    }
    
    
    // MARK: Opens product card
    @objc func cardSheetOpen(sender: UITapGestureRecognizer){
        let cardVC = CardVC()
        
        //Tags for recognizing senders
        productCardIV1.tag = 0
        productCardIV2.tag = 1
        productCardIV3.tag = 2
        productCardLabel1.tag = 0
        productCardLabel2.tag = 1
        productCardLabel3.tag = 2
        
        
        if let imageTransfered = sender.view as? UIImageView {
            if let transfer = imageTransfered.image {
                cardVC.cardImage1 = transfer
                //Setting up proper photos
                if cardVC.cardImage1 == UIImage(named: "Mac Mini Front") {
                    cardVC.cardImage2 = UIImage(named: "Mac Mini Back")!
                    cardVC.cardImage3 = UIImage(named: "Mac Mini and Monitor")!
                } else if cardVC.cardImage1 == UIImage(named: "Apple Display Front") {
                    cardVC.cardImage2 = UIImage(named: "Apple Display Back")!
                    cardVC.cardImage3 = UIImage(named: "Apple Display Side")!
                } else if cardVC.cardImage1 == UIImage(named: "HomePod") {
                    cardVC.cardImage2 = UIImage(named: "HomePod Top")!
                    cardVC.cardImage3 = UIImage(named: "HomePods")!
                }
                
            }
        }
        
        //Setting up proper label and price
        let textDictionary = [0: productCardLabel1.text, 1: productCardLabel2.text, 2: productCardLabel3.text]
        let priceDictionary = [0: "$700", 1: "$900", 2: "$200"]
        cardVC.cardLabel.text = textDictionary[sender.view!.tag]!!
        cardVC.cardPriceLabel.text = priceDictionary[sender.view!.tag]!
        
        
        navigationController?.pushViewController(cardVC, animated: true)
    }
    
    
    //MARK: TableView methods
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return suggestArray.count }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: suggestIdentifier, for: indexPath)
        let number = suggestArray[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: "magnifyingglass")
        cell.imageView?.tintColor = .systemGray
        cell.textLabel?.text = number
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = .black
        
        return cell
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 45 }
}

