//
//  AccountViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit
import Account
import Common

class AccountViewController: UIViewController {

    @IBOutlet weak var ivAccount: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldDesc: UITextField!
    @IBOutlet weak var btnEditImage: UIImageView!
    
    private let imagePicker = UIImagePickerController()
    private var changeImage: UIImage?
    
    var accountPresenter: AccountPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUI()
        btnEditImageAccount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationView(false)
        loadUserDefaultAccount()
    }
    
    private func loadUserDefaultAccount() {
        accountPresenter?.loadUserAccount(
            receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure:
                    self.showToast("setup_profile".localized())
                }
            }, receiveValue: { account in
                self.ivAccount.image = UIImage(data: account.image)
                self.labelName.text = account.name
                self.labelDesc.text = account.desc
            })
    }
    
    private func setupNavigationView(_ isEdited: Bool) {
        let btnRightBar: UIBarButtonItem
        
        if isEdited {
            btnRightBar = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAccountTapped(tapGesture:)))
        } else {
            btnRightBar = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAccountTapped(tapGesture:)))
        }
        
        self.navigationItem.rightBarButtonItem = btnRightBar
    }
    
    @objc func doneAccountTapped(tapGesture: UITapGestureRecognizer) {
        guard let name = txtFieldName.text, let desc = txtFieldDesc.text else { return }
        guard let image = changeImage?.pngData() ?? ivAccount.image?.pngData() else { return }
        
        let account = Account(name: name, image: image, desc: desc)
        addToUserAccount(account)
        loadUserDefaultAccount()
    }
    
    private func addToUserAccount(_ account: Account) {
        accountPresenter?.addUserAccount(
            account,
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.showToast("text_saved_successfully".localized())
                case .failure:
                    self.showToast(String(describing: completion))
                }
            },
            receiveValue: {_ in
                self.editShowHiddenItems(false, true)
                self.setupNavigationView(false)
            })
    }
    
    @objc func editAccountTapped(tapGesture: UITapGestureRecognizer) {
        setupNavigationView(true)
        editShowHiddenItems(true, false)
        
        txtFieldName.text = labelName.text
        txtFieldDesc.text = labelDesc.text
    }
    
    private func btnEditImageAccount() {
        let editTap = UITapGestureRecognizer(target: self, action: #selector(editImageTapped(tapGesture:)))
        btnEditImage.isUserInteractionEnabled = true
        btnEditImage.addGestureRecognizer(editTap)
    }
    
    @objc func editImageTapped(tapGesture: UITapGestureRecognizer) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func showUI() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        txtFieldName.layer.borderWidth = 1
        txtFieldName.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        txtFieldDesc.layer.borderWidth = 1
        txtFieldDesc.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
    }
    
    private func editShowHiddenItems(_ show: Bool, _ hidden: Bool) {
        labelName.isHidden = show
        labelDesc.isHidden = show
        
        btnEditImage.isHidden = hidden
        txtFieldName.isHidden = hidden
        txtFieldDesc.isHidden = hidden
    }
}

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let result = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.ivAccount.contentMode = .scaleToFill
            self.ivAccount.image = result
            changeImage = result
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "text_failed".localized(), message: "alert_error_image".localized(), preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "text_dismiss".localized(), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
