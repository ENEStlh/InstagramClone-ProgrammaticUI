//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit
import SwiftUI

class SettingsViewController: UIViewController {
    
    private let viewModel = SettingsViewModel()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupSwiftUIView()
    }
    
    
    private func setupSwiftUIView() {
            // 1. SwiftUI ekranımızı oluşturuyoruz. İçindeki butona basılınca 'didTapSignOut' çalışacak.
            let settingsView = SwiftUISettingsView {  [weak self] in
                self?.didTapSignOut()
                // bu da aynısı aynı mantık diğeri direkt closurelu
               // let settingsView2 = SwiftUISettingsView(onSignOutTapped: {self?.didTapSignOut()})
            }
            
            // 2. SwiftUI ekranını UIKit'in anlayacağı bir UIHostingController'a koymak için
            let hostingController = UIHostingController(rootView: settingsView)
            
            // 3. Bu HostingController'ı ekrana yerleştirioyurm
            addChild(hostingController)
            view.addSubview(hostingController.view)
            
            // Ekranı tam kaplaması için sınırları ayarladım
            hostingController.view.frame = view.bounds
            hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            hostingController.didMove(toParent: self)
        }
        
       
        private func didTapSignOut() {
            viewModel.signOut { [weak self] success, error in
                if success {
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self?.present(loginVC, animated: true)
                } else {
                    print("Çıkış hatası: \(String(describing: error))")
                }
            }
        }
    }
