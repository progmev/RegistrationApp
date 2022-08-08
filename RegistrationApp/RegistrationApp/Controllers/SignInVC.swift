//
//  SignInVC.swift
//  RegistrationApp
//
//  Created by Martynov Evgeny on 28.07.22.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    @IBOutlet weak var errorEmailLbl: UILabel!
    @IBOutlet weak var errorPass: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoggedUser()
    }
    
    @IBAction func signInAction() {
        if let email = emailTF.text,
           let pass = passTF.text,
           let userModel = UserDafaultsService.getUserModel(),
           email == userModel.email,
           pass == userModel.pass {
            performSegue(withIdentifier: "goToMain", sender: nil)
        }
    }
    
    private func isLoggedUser() {
        if let _ = UserDafaultsService.getUserModel() {
            performSegue(withIdentifier: "goToMain", sender: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
