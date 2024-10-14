//
//  ProfileVC.swift
//  ITI Task
//

import UIKit

class profileVC: UIViewController {
    
    var user: User!
    
    @IBOutlet weak var logOutBTN: UIButton!
    @IBOutlet weak var addProfileBTN: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fullNameUser: UITextField!
    @IBOutlet weak var addressUser: UITextField!
    @IBOutlet weak var phoneNumberUser: UITextField!
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passwordUser: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImg.layer.cornerRadius = profileImg.frame.height/2
        
        logOutBTN.layer.cornerRadius = 20
        logOutBTN.layer.masksToBounds = true
        
        addProfileBTN.layer.cornerRadius = 20
        addProfileBTN.layer.masksToBounds = true
        
        fullNameUser.text = user.fullName
        addressUser.text = user.address
        phoneNumberUser.text = user.phoneNumber
        emailUser.text = user.email
        passwordUser.text = user.password
        profileImg.image = user.image
        
        
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: "LoginID") as! LoginVC
        loginVC.user = user
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    
    
    @IBAction func addProfileImg(_ sender: Any) {
        
        let imagePaker = UIImagePickerController()
        imagePaker.delegate = self
        imagePaker.allowsEditing = true
        present(imagePaker, animated: true, completion: nil)
        
    }

}

extension profileVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true)
        profileImg.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
    }
    
}
