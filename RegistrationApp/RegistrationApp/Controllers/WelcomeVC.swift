//
//  WelcomeVC.swift
//  RegistrationApp
//
//  Created by Martynov Evgeny on 4.08.22.
//

import UIKit

final class WelcomeVC: UIViewController {
    
    @IBOutlet private weak var infoLbl: UILabel!
    
    var userModel: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    @IBAction private func continueAction() {
        guard let userModel = userModel else { return }
        UserDafaultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        let name = userModel?.name ?? "User"
        infoLbl.text = "\(name) welcome to our Cool App"
    }
}
