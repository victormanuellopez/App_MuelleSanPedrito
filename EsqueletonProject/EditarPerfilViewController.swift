//
//  EditarPerfilViewController.swift
//  EsqueletonProject
//
//  Created by marco alonso on 13/01/21.
//

import UIKit

class EditarPerfilViewController: UIViewController {

    @IBOutlet weak var imagePerfil: UIImageView!
   
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var edadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePerfil.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cambiarFotoPerfil))
        
        imagePerfil.addGestureRecognizer(gesture)
    }
    
    @objc func cambiarFotoPerfil(){
        print("Seleccionar foto de perfil")
        presentFotoActionSheet()
    }
   
    
    
    
    @IBAction func sliderEdad(_ sender: UISlider) {
        edadLabel.text = String(format: "%0.1f", sender.value)
        print(sender.value)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func tomarFoto(_ sender: UIBarButtonItem) {
        presentFotoActionSheet()
    }
    
}

//MARK: - Seleccionar foto
extension EditarPerfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //ActionSheet para seleccionar foto
    func presentFotoActionSheet() {
        let actionSheet = UIAlertController(title: "Foto de Perfil", message: "¿Como quieres elegir una foto?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancelar",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Tomar una foto",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentCamara()
                                            }))
        
        actionSheet.addAction(UIAlertAction(title: "Elegir una existente",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentLibreria()
                                            }))
        present(actionSheet, animated: true)
    }
    
    func presentCamara(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func presentLibreria() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let imagenSeleccionada = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imagePerfil.image = imagenSeleccionada
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelar")
        picker.dismiss(animated: true, completion: nil)
    }
}
