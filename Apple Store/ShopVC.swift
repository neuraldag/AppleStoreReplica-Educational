//
//  ShopVC.swift
//  Apple Store
//
//  Created by Gamid Gapizov on 24.01.2024.
//

import UIKit
import SnapKit
import WebKit
import AVFoundation
import AVKit

final class ShopVC: UIViewController, WKNavigationDelegate {
    
    private let data = DataModel()
    private let webKit = WKWebView()
    private var playerController = AVPlayerViewController()
    private let activityVI = UIActivityIndicatorView()
    private var activityController: UIActivityViewController? = nil
    
    
    //Buttons for NavBar and ToolBar
    private var backButton = UIBarButtonItem()
    private var forwardButton = UIBarButtonItem()
    private var shareButton = UIBarButtonItem()
    private var refreshButton = UIBarButtonItem()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if data.firstRun { } else { loadVideo() }
        
        createNavBar()
        createWebView()
        createToolBar()
        createActivityView()
    }
   
    
    // MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        
        if data.firstRun { } else { runFirstTime() }
        UserDefaults.standard.set(true, forKey: "firstRun")
    }
    
    
    // MARK: UI setup methods
    private func createNavBar() {
        let nav = navigationController?.navigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        nav?.standardAppearance = appearance
        nav?.scrollEdgeAppearance = appearance
        nav?.compactAppearance = appearance
        nav?.compactScrollEdgeAppearance = appearance
        nav?.prefersLargeTitles = false
        nav?.isTranslucent = true
        title = "Shop"
        
        shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(activityControllerTapped))
        navigationItem.rightBarButtonItem = shareButton
    }
    private func createWebView() {
        view.addSubview(webKit)
        webKit.navigationDelegate = self
        if let myURL = URL(string: "https://www.apple.com/store") {
            webKit.load(URLRequest(url: myURL))
        }
        webKit.snp.makeConstraints { make in
            make.top.right.left.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
    private func createToolBar() {
        backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(navButtonTapped))
        forwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"), style: .plain, target: self, action: #selector(navButtonTapped))
        refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(navButtonTapped))
        
        toolbarItems = [backButton,
                        UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil),
                        forwardButton,
                        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
                        refreshButton]
        
        navigationController?.toolbar.backgroundColor = .white
        navigationController?.setToolbarHidden(false, animated: false)
    }
    private func createActivityView() {
        view.addSubview(activityVI)
        activityVI.hidesWhenStopped = true
        activityVI.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    
    // MARK: Video Intro method
    private func loadVideo() {      //plays intro video (video credits: @dixie2305 on YT)
        guard let path = Bundle.main.path(forResource: "apple intro", ofType: "mov") else {
            debugPrint("video not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        playerController.showsPlaybackControls = false
        playerController.player = player
        playerController.videoGravity = .resizeAspectFill
        
        NotificationCenter.default.addObserver(self, selector: #selector(openWelcomePage), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
        
        present(playerController, animated: false) {
            player.play()
        }
    }
    
    
    // MARK: First run checker
    private func runFirstTime() {
        let welcomeVC = PageViewController()
        present(welcomeVC, animated: true)
    }
    
    
    // MARK: WebView navigation setup
    internal func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityVI.startAnimating()
        forwardButton.isEnabled = false
        backButton.isEnabled = false
    }
    internal func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityVI.stopAnimating()
        
        if webKit.canGoBack {
            backButton.isEnabled = true
        } else if webKit.canGoForward {
            forwardButton.isEnabled = true
        }
    }

    
    // MARK: @objc methods
    @objc func navButtonTapped(sender: UIBarButtonItem) {
        if sender == backButton {
            if webKit.canGoBack {
                webKit.goBack()
            }
        } else if sender == forwardButton {
            if webKit.canGoForward {
                webKit.goForward()
            }
        } else if sender == refreshButton {
            webKit.reload()
        }
    }
    @objc func activityControllerTapped() {
        let urlArray = [webKit.url]
        self.activityController = UIActivityViewController(activityItems: urlArray as [Any], applicationActivities: nil)
        self.present(activityController!, animated: true)
    }
    @objc func openWelcomePage() {
        playerController.dismiss(animated: true)
        self.view.backgroundColor = .white
    }
}
