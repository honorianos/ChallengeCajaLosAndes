//
//  LoginViewController.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 3/01/25.
//

import UIKit
import JGProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelSubTitle: UILabel!
    @IBOutlet var imageViewLogo: UIImageView!
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var buttonHideShowPassword: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    private let presenter = LoginPresenter()
    private let loader = JGProgressHUD(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        textFieldEmail.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        textFieldPassword.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTexfields()
        updateLoginButtonState()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textFieldEmail.setLeftPadding(value: 15)
        textFieldPassword.setLeftPadding(value: 15)
        textFieldPassword.setRightPadding(value: 40)
        labelTitle.text = Utils.labelTitle
        labelSubTitle.text = Utils.labelSubTitle
    }

    func resetTexfields() {
        textFieldEmail.text = ""
        textFieldPassword.text = ""
    }
    
    @objc func textFieldsDidChange() {
        updateLoginButtonState()
    }
    
    func updateLoginButtonState() {
        if textFieldEmail.text?.isEmpty == false && textFieldPassword.text?.isEmpty == false {
            loginButton.backgroundColor = UIColor.blue
        } else {
            loginButton.backgroundColor = UIColor.systemGray
        }
    }
    
    // MARK: - User actions
    
    @IBAction func actionHideShowPassword(_ sender: Any) {
        buttonHideShowPassword.isSelected = !buttonHideShowPassword.isSelected
        textFieldPassword.isSecureTextEntry = !buttonHideShowPassword.isSelected
    }

    @IBAction func actionLogin(_ sender: Any) {
        presenter.validateLogin(username: textFieldEmail.text ?? "", password: textFieldPassword.text ?? "")
    }


}

extension LoginViewController : LoginPresenterDelegate {
    
    func showLoader(show: Bool) {
        if show {
            self.loader.show(in: self.view)
        }
        else {
            self.loader.dismiss()
        }
    }
    
    func successResponse() {
        self.showLoader(show: false)
        self.navigationController?.pushViewController(HomeTabBarController(), animated: true)
    }
    
}
