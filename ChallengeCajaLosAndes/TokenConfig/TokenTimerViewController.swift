//
//  TokenTimerViewController.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 4/01/25.
//

import Foundation
import UIKit

class TokenTimerViewController: UIViewController {
    private var tokenTimer: Timer?
    private var tokenExpirationTime: TimeInterval = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTokenTimer()
    }
    
    func startTokenTimer() {
        tokenTimer?.invalidate()
        tokenTimer = Timer.scheduledTimer(timeInterval: tokenExpirationTime, target: self, selector: #selector(tokenExpired), userInfo: nil, repeats: false)
    }
    
    @objc private func tokenExpired() {
        handleTokenExpiration()
    }
    
    func handleTokenExpiration() {
        showAlertForTokenExpiration()
    }
    
    private func showAlertForTokenExpiration() {
        let alert = UIAlertController(title: "Sesión Expirada", message: "Tu sesión ha expirado. Por favor, inicia sesión nuevamente.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func resetTokenTimer() {
        startTokenTimer()
    }
}
