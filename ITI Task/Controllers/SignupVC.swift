//
//  SignupVC.swift
//  ITI Task
//

import UIKit

class SignupVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var fullNameTXT: UITextField!
    @IBOutlet weak var addressTXT: UITextField!
    @IBOutlet weak var phoneNumberTXT: UITextField!
    @IBOutlet weak var emailTXT: UITextField!
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var passwordTXT: UITextField!
    @IBOutlet weak var confirmPasswordTXT: UITextField!
    @IBOutlet weak var imgBTN: UIButton!
    
    private let imagePaker = UIImagePickerController()
    
    // MARK: Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // profileIMG.image = UIImage(named: "person.crop.circle.badge.plus")
        imagePaker.delegate = self
        profileIMG.layer.cornerRadius = 20
        profileIMG.layer.masksToBounds = true
        // profileIMG.layer.cornerRadius = profileIMG.frame.height/2
    }
    
    // MARK: IBActions
    @IBAction func imageBTN(_ sender: Any) {
        imagePaker.allowsEditing = true
        imagePaker.sourceType = .photoLibrary
        present(imagePaker, animated: true, completion: nil)
    }
    
    
    @IBAction func registerBTN(_ sender: Any) {
        
        if isValidData(){
            let user = getUserData()
            if let confirmPassword = confirmPasswordTXT.text, isPasswordConfirmed(password: user.password, conrimPassword: confirmPassword) {
                self.goToLoginScreen(user: user)
            }
            
        }
           
    }
}

// MARK: - Private Methods
extension SignupVC {
    private func isValidData() -> Bool {
        guard profileIMG.image != UIImage(systemName: "person.crop.circle.badge.plus") else {
            self.showAlert(title: "Sorry", message: "Please Add Profile Pic!")
            return false
        }
        
        guard fullNameTXT.text?.trimmed != "" else {
            self.showAlert(title: "Sorry", message: "Please enter your name!")
            return false
        }
        
        guard addressTXT.text?.trimmed != "" else {
            self.showAlert(title: "Sorry", message: "Please enter your address!")
            return false
        }
        
        guard phoneNumberTXT.text?.trimmed != "", isValidPhoneNumber(phoneNumberTXT.text!) else {
            self.showAlert(title: "Sorry", message: "Please enter your correct phone number!")
            return false
        }
        
        guard emailTXT.text?.trimmed != "", isValidEmail(emailTXT.text!) else {
        self.showAlert(title: "Sorry", message: "Please enter your correct email!")
            return false
        }
        
        guard passwordTXT.text?.trimmed != "", isValidPassword(passwordTXT.text!) else {
            self.showAlert(title: "Sorry", message: "Please enter a correct password! your password must contain at least 8 characters, including Uppercase, Lowercase, Special Characters and numbers")
            return false
        }
        
        guard confirmPasswordTXT.text?.trimmed != "" else {
            self.showAlert(title: "Sorry", message: "Please confirm your password!")
            return false
        }
  
        return true
    }
    
    private func goToLoginScreen(user: User) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: "LoginID") as! LoginVC
        loginVC.user = user
        loginVC.modalPresentationStyle = .fullScreen
        self.present (loginVC, animated: true)
    }
    
    private func getUserData() -> User {
        let user = User(fullName: fullNameTXT.text!, address: addressTXT.text!, phoneNumber: phoneNumberTXT.text!, email: emailTXT.text!, password: passwordTXT.text!, image: profileIMG.image!)
        return user
    }
    
    private func isPasswordConfirmed(password: String, conrimPassword: String) -> Bool {
        if password == conrimPassword {
            return true
        }
        self.showAlert(title: "Sorry", message: "The password isn't confirmed successfully!")
        return false
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        // "[a-z._%+a-z-0-9]+@[A-Za-z0-9.-]+\\.(com|net|org)$" (Common) edited by me
        // "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailRegEx = "[a-z._%+a-z-0-9]+@[A-Za-z0-9.-]+\\.(com|net|org)$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}$"
        // "([(A-Z)(!@#.$%ˆ&*+-=<>)(0-9)]+)([a-z]*){8,15}"
        // "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    private func isValidPhoneNumber(_ number: String) -> Bool {
        let phoneNumberRegex = "^(010|011|012|015)\\d{8}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex).evaluate(with: number)
    }
}


// MARK: Image Packer Function
extension SignupVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true)
        profileIMG.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
    }
    
}
