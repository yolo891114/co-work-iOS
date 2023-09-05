//
//  PhotoViewController.swift
//  STYLiSH
//
//  Created by TingFeng Shen on 2023/9/5.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    var selectPhoto = false // 判定是否有選擇照片

    @IBOutlet weak var imageSelectButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    @IBAction func imagePickerButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    


}


extension PhotoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectPhoto = true
        let image = info[.originalImage] as? UIImage
        imageSelectButtonOutlet.setImage(image, for: .normal)

        dismiss(animated: true, completion: nil)
    }
    
}
