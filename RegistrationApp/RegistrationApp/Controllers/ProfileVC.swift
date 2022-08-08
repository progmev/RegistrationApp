//
//  ProfileVC.swift
//  RegistrationApp
//
//  Created by Martynov Evgeny on 4.08.22.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBAction func logOutAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteAccountAction() {
        UserDafaultsService.cleanUserDafauls()
        navigationController?.popToRootViewController(animated: true)
    }
}
