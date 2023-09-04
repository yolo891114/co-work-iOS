//
//  ProductDetailViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/2.
//  Copyright © 2019 AppWorks School. All rights reserved.
//

import UIKit

class ProductDetailViewController: STBaseViewController,MessageDelegate {
    
    func sendMessage(message: String) {
        mockDataToMessage.append(message)
    }
    
    func postReviewApi() {
        
 
        if let url = URL(string: "http://54.66.20.75:8080/api/1.0/review/submit"){
            var request = URLRequest(url: url)
            // httpMethod 設定
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            // 將內容加入 httpBody
            request.httpBody = try? JSONEncoder().encode(postData)

            //  URLSession 本身還是必須執行，為主要上傳功能。
            URLSession.shared.dataTask(with: request) { data, response, error in
// 內容單純拿來檢查矩陣內容，與上傳並無關係
                    if let data = data,
                           let content = String(data: data, encoding: .utf8) {
                            print(content)
                        }
            }.resume()
            
        }
    }
    
// MARK: - 公用變數
    var postData: Review?

    var mockDataToMessage = ["1","2"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let likeButton: UIButton = {
        let button = UIButton()
        if UserDefaults.standard.string(forKey: "userGroup") == "A" {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
            button.tintColor = .systemPink
        } else {
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.setImage(UIImage(systemName: "star.fill"), for: .selected)
            button.tintColor = .systemYellow
        }
        
        button.addTarget(self, action: #selector(tappedLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30))
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        return button
    }()
    
    func setLayout() {
        
        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            likeButton.bottomAnchor.constraint(equalTo: galleryView.bottomAnchor, constant: -10),
            likeButton.widthAnchor.constraint(equalToConstant: 50),
            likeButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    @objc func tappedLike() {
        likeButton.isSelected.toggle()
        // 傳送 tracking API 給 data
        // 加入商品儲存到本地
        guard let product = product else { return }
        
        
        var favoriteProducts: [[String: Any]] = UserDefaults.standard.array(forKey: "favoriteProducts") as? [[String: Any]] ?? []
            
            let newFavorite: [String: Any] = [
                "productID": product.id,
                "title": product.title,
                "price": product.price,
                "imageURL": product.mainImage
            ]
            
            if likeButton.isSelected {
                favoriteProducts.append(newFavorite)
            } else {
                favoriteProducts = favoriteProducts.filter { $0["productID"] as? Int != product.id }
            }
            
            UserDefaults.standard.setValue(favoriteProducts, forKey: "favoriteProducts")
        
        for product in favoriteProducts {
            if let title = product["title"] as? String {
                print(title)
            }
            print(product)
        }
        
        
    }

// ================= 以上 angus

    
    private struct Segue {
        static let picker = "SeguePicker"
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var galleryView: LKGalleryView! {
        didSet {
            galleryView.frame.size.height = CGFloat(Int(UIScreen.width / 375.0 * 500.0))
            galleryView.delegate = self
        }
    }
    
    @IBOutlet weak var productPickerView: UIView!
    
    @IBOutlet weak var addToCarBtn: UIButton!
    
    @IBOutlet weak var baseView: UIView!
    
    private lazy var blurView: UIView = {
        let blurView = UIView(frame: tableView.frame)
        blurView.backgroundColor = .black.withAlphaComponent(0.4)
        return blurView
    }()
    
    private let datas: [ProductContentCategory] = [
        .description, .color, .size, .stock, .texture, .washing, .placeOfProduction, .remarks
    ]
    
    var product: Product? {
        didSet {
            guard let product = product, let galleryView = galleryView else { return }
            galleryView.datas = product.images
////===== angus
//            if let postData = postData {
//            }
        }
    }
    
    private var pickerViewController: ProductPickerController?
    
    override var isHideNavigationBar: Bool { return true }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        guard let product = product else { return }
        galleryView.datas = product.images
        galleryView.addSubview(likeButton)
        setLayout()
        

        let favoriteProducts: [[String: Any]] = UserDefaults.standard.array(forKey: "favoriteProducts") as? [[String: Any]] ?? []
            
            if favoriteProducts.contains(where: { $0["productID"] as? Int == product.id }) {
                likeButton.isSelected = true
            } else {
                likeButton.isSelected = false
            }

        if let group = UserDefaults.standard.string(forKey: "userGroup") {
            postData = Review(userID: "問書瑜", productID: product.id, review: "", timestamp: "", version: group)
        }

    }
    
    private func setupTableView() {
        tableView.lk_registerCellWithNib(
            identifier: String(describing: ProductDescriptionTableViewCell.self),
            bundle: nil
        )
        tableView.lk_registerCellWithNib(
            identifier: ProductDetailCell.color,
            bundle: nil
        )
        tableView.lk_registerCellWithNib(
            identifier: ProductDetailCell.label,
            bundle: nil
        )
        //============== angus
        // 留言輸入框
        tableView.lk_registerCellWithNib(
            identifier: String(describing: MessageTextFieldTableViewCell.self),
            bundle: nil
        )
        // 留言們
        tableView.lk_registerCellWithNib(
            identifier: String(describing: ProductMessageTableViewCell.self),
            bundle: nil
        )

        
        //==============
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.picker,
           let pickerVC = segue.destination as? ProductPickerController {
            pickerVC.delegate = self
            pickerVC.product = product
            pickerViewController = pickerVC
        }
    }
    
    // MARK: - Action
    @IBAction func didTouchAddToCarBtn(_ sender: UIButton) {
        if productPickerView.superview == nil {
            showProductPickerView()
        } else {
            guard
                let color = pickerViewController?.selectedColor,
                let size = pickerViewController?.selectedSize,
                let amount = pickerViewController?.selectedAmount,
                let product = product
            else {
                return
            }
            StorageManager.shared.saveOrder(
                color: color, size: size, amount: amount, product: product,
                completion: { result in
                    switch result {
                    case .success:
                        LKProgressHUD.showSuccess()
                        dismissPicker(pickerViewController!)
                    case .failure:
                        LKProgressHUD.showFailure(text: "儲存失敗！")
                    }
                }
            )
        }
    }
    
    func showProductPickerView() {
        let maxY = tableView.frame.maxY
        productPickerView.frame = CGRect(
            x: 0, y: maxY, width: UIScreen.width, height: 0.0
        )
        baseView.insertSubview(productPickerView, belowSubview: addToCarBtn.superview!)
        baseView.insertSubview(blurView, belowSubview: productPickerView)
        
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
                guard let self = self else { return }
                let height = 451.0 / 586.0 * self.tableView.frame.height
                self.productPickerView.frame = CGRect(
                    x: 0, y: maxY - height, width: UIScreen.width, height: height
                )
                self.isEnableAddToCarBtn(false)
            }
        )
    }
    
    func isEnableAddToCarBtn(_ flag: Bool) {
        if flag {
            addToCarBtn.isEnabled = true
            addToCarBtn.backgroundColor = .B1
        } else {
            addToCarBtn.isEnabled = false
            addToCarBtn.backgroundColor = .B4
        }
    }
}

// MARK: - UITableViewDataSource
extension ProductDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            guard product != nil else { return 0 }
            return datas.count
        } else if section == 1 {
            return 1
        } else {
            guard product != nil else { return 0 }
            return product?.reviews.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let product = product else { return UITableViewCell() }
            return datas[indexPath.row].cellForIndexPath(indexPath, tableView: tableView, data: product)
        } else if indexPath.section == 1 {
            // 放入輸入留言的 textField
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTextFieldTableViewCell", for: indexPath) as? MessageTextFieldTableViewCell else { return UITableViewCell() }
            
            cell.delegate = self
          

            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductMessageTableViewCell", for: indexPath) as? ProductMessageTableViewCell else { return UITableViewCell() }
            
            cell.messgeLabel.text = product?.reviews[indexPath.row]
            return cell
        }
    }

}

extension ProductDetailViewController: LKGalleryViewDelegate {
    
    func sizeForItem(_ galleryView: LKGalleryView) -> CGSize {
        return CGSize(width: Int(UIScreen.width), height: Int(UIScreen.width / 375.0 * 500.0))
    }
}

extension ProductDetailViewController: ProductPickerControllerDelegate {
    
    func dismissPicker(_ controller: ProductPickerController) {
        let origin = productPickerView.frame
        let nextFrame = CGRect(x: origin.minX, y: origin.maxY, width: origin.width, height: origin.height)
        
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
                self?.productPickerView.frame = nextFrame
                self?.blurView.removeFromSuperview()
                self?.isEnableAddToCarBtn(true)
            },
            completion: { [weak self] _ in
                self?.productPickerView.removeFromSuperview()
            }
        )
    }
    
    func valueChange(_ controller: ProductPickerController) {
        guard
            controller.selectedColor != nil,
            controller.selectedSize != nil,
            controller.selectedAmount != nil
        else {
            isEnableAddToCarBtn(false)
            return
        }
        isEnableAddToCarBtn(true)
    }
}
