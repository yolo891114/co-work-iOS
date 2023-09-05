//
//  MessageTextFieldTableViewCell.swift
//  STYLiSH
//
//  Created by TingFeng Shen on 2023/9/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

protocol MessageDelegate: AnyObject {
    func sendMessage(message: String)
    func postReviewApi()
}

class MessageTextFieldTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var messageTextfield: UITextField!
    
    @IBOutlet weak var sendButtonOutlet: UIButton! {
        didSet{
            sendButtonOutlet.lkCornerRadius = 20
            sendButtonOutlet.clipsToBounds = true
        }
    }
    weak var delegate: MessageDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sendButton(_ sender: Any) {
        if let message = messageTextfield.text {
            if message != "" {
                delegate?.sendMessage(message: message)
                delegate?.postReviewApi()
                
            }
        }
        messageTextfield.text = ""
    }
    
    

}
