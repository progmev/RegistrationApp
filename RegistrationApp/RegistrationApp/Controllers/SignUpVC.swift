//
//  SignUpVC.swift
//  RegistrationApp
//
//  Created by Martynov Evgeny on 1.08.22.
//

import UIKit

final class SignUpVC: UIViewController {
    
    // MARK: - IBOutlets
    
    /// email
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var errorEmailLbl: UILabel!
    /// name
    @IBOutlet private weak var nameTF: UITextField!
    /// password
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var errorPassLbl: UILabel!
    /// password indicators
    @IBOutlet private var strongPassIndicatorsViews: [UIView]!
    /// confPass
    @IBOutlet private weak var confPassTF: UITextField!
    @IBOutlet private weak var errorConfPassLbl: UILabel!
    /// continueBtn
    @IBOutlet private weak var continueBtn: UIButton!
    
    // MARK: - Properties
    
    private var isValidEmail = false { didSet { updateContinueBtnState() }}
    private var isConfPass = false { didSet { updateContinueBtnState() }}
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() }}
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Func-s
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmailLbl.isHidden = isValidEmail
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty {
            passwordStrength = VerificationService.isValidPassword(pass: passText)
        }
        errorPassLbl.isHidden = passwordStrength != .veryWeak
        sutupStrongPassIndicatorsViews()
    }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty {
            isConfPass = VerificationService.isPassCofirm(pass1: passText,
                                                          pass2: confPassText)
        } else {
            isConfPass = false
        }
        errorConfPassLbl.isHidden = isConfPass
    }
    
    @IBAction func signInBtnAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func continueBtnAction() {
        if let email = emailTF.text,
           let pass = passwordTF.text {
            let userModel = UserModel(name: nameTF.text, email: email, pass: pass)
            performSegue(withIdentifier: "goToCodeVerifVC", sender: userModel)
        }
    }
    
    // MARK: - Func-s
    

    private func sutupStrongPassIndicatorsViews() {
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.1
            }
        }
    }
    
    private func updateContinueBtnState() {
        continueBtn.isEnabled = isValidEmail && isConfPass && passwordStrength != .veryWeak
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let codeVerifVC = segue.destination as? CodeVerifVC,
           let userModel = sender as? UserModel {
            codeVerifVC.userModel = userModel
        }
    }
}
