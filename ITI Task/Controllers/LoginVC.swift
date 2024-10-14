//
//  LoginVC.swift
//  ITI Task
//

import UIKit

class LoginVC: UIViewController {
    
    var user: User!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // print(user.email, user.passwoed)
    }
    
    
    @IBAction func signUpBTN(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "signupID") as? SignupVC
        
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func logInBTN(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        if email == user.email && password == user.password {
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let productVC = sb.instantiateViewController(withIdentifier: "ProductsID") as! ProductsVC
            productVC.user = user
            productVC.modalPresentationStyle = .fullScreen
            self.present(productVC, animated: true)
            
            emailTextField.text = ""
            passwordTextField.text = ""
            
//            let vc = storyboard?.instantiateViewController(identifier: "profileID") as? profileVC
//
//            vc!.modalPresentationStyle = .fullScreen
//            self.present(vc!, animated: true, completion: nil)
        } else {
            self.showAlert(title: "Sorry", message: "Please Enter valid email and passowrd" )
        }
        
    }
}

