//
//  AddViewController.swift
//  ComicVN
//
//  Created by Tuấn on 4/3/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import DropDown

class AddViewController: BaseViewController, NavigationViewDelegate {
    func didTapRightAddButton(in view: UIView) {
    }
    
    func didTapLeftButton(in view: UIView) {
        navigationController?.popViewController(animated: true)
    }
    
    let viewModel = AddViewModel()
    
    lazy var navigationView = {
        NavigationViewFactory.createSecondNavigationView(leftImage: .arrowLeft,
                                                         titleButton: "Thêm truyện",
                                                         delegate: self)
    }()
    
    lazy var avatarImageView = {
        let imageView = ImageViewFactory.createImageView(image: .upload, radius: 8)
        imageView.contentMode = .center
        imageView.backgroundColor = .lightGray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var nameTextField = {
        let tf = TextFieldFactory.createTextField(placeholder: "Nhập tên truyện",
                                                  font: .medium14,
                                                  rounded: true,
                                                  height: 48)
        tf.imageLeftView(image: "")
        return tf
    }()
    
    lazy var authorTextField = {
        let tf = TextFieldFactory.createTextField(placeholder: "Nhập tên tác giả",
                                                  font: .medium14,
                                                  rounded: true,
                                                  height: 48)
        tf.imageLeftView(image: "")
        return tf
    }()
    
    lazy var categoryTextField = {
        let tf = TextFieldFactory.createTextField(placeholder: "Thể loại",
                                                  font: .medium14,
                                                  rounded: true,
                                                  height: 48)
        tf.imageLeftView(image: "")
        return tf
    }()
    
    lazy var chapterTextField = {
        let tf = TextFieldFactory.createTextField(placeholder: "Tổng số chương",
                                                  font: .medium14,
                                                  rounded: true,
                                                  height: 48)
        tf.imageLeftView(image: "")
        tf.keyboardType = .numberPad
        return tf
    }()
    
    lazy var summaryTextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor(hex: "#DCDBDB", alpha: 0.8)
        tv.font = .regular14
        tv.textColor = .lightGray
        tv.text = "Tóm tắt"
        tv.layer.cornerRadius = 5
        tv.delegate = self
        return tv
    }()
    
    lazy var trendingButton = ButtonFactory.createButton("Thịnh hành",
                                                         image: UIImage(systemName: "circle"),
                                                         font: .medium12,
                                                         textColor: .black,
                                                         bgColor: .white,
                                                         padding: 5)
    
    lazy var newComicButton = ButtonFactory.createButton("Truyện mới",
                                                         image: UIImage(systemName: "circle"),
                                                         font: .medium12,
                                                         textColor: .black,
                                                         bgColor: .white,
                                                         padding: 5)
    
    lazy var buttonStackView = [trendingButton, newComicButton].hStack(10, distribution: .fillEqually)
    
    lazy var ratingCosmos = CosmosViewFactory.createCosmosView(updateOnTouch: true)
    
    lazy var topDropDown = DropDown()
    
    lazy var dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Chọn loại top", for: .normal)
        button.tintColor = .black
        button.backgroundColor = UIColor(hex: "#DCDBDB", alpha: 0.8)
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()
    
    lazy var submitBtn = {
        let btn = ButtonFactory.createButton("Submit", font: .medium14, textColor: .white, bgColor: UIColor(hex: "#FF7B00"), rounded: true)
        return btn
    }()
    
    lazy var stackView = [nameTextField, authorTextField, categoryTextField, chapterTextField, summaryTextView, ratingCosmos, buttonStackView, dropdownButton].vStack(8)

    override func setupUI() {
        view.addSubviews([navigationView, avatarImageView, stackView, submitBtn])
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }

        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(160)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(40)
        }
        
        summaryTextView.snp.makeConstraints { make in
            make.height.equalTo(142)
        }
        
        dropdownButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        customDropDown()
        
        submitBtn.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(176)
            make.height.equalTo(48)
        }
    }
    
    func customDropDown() {
        topDropDown.dataSource = ["Top Tuần", "Top Tháng", "Top Đánh giá"]
        topDropDown.anchorView = dropdownButton
        topDropDown.cellHeight = 50
        topDropDown.selectionAction = { [weak self] (index, item) in
            guard let self = self else {return}
            self.dropdownButton.setTitle(item, for: .normal)
            switch item {
            case "Top Tuần":
                self.viewModel.topWeak.accept(true)
                break
            case "Top Tháng":
                self.viewModel.topMonth.accept(true)
                break
            case "Top Đánh giá":
                self.viewModel.topReviews.accept(true)
                break
            default:
                break
            }
        }
    }
    
    override func setupEvent() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(chooseImageView))
        avatarImageView.addGestureRecognizer(tapImageView)
        nameTextField.rx.text.orEmpty.bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        categoryTextField.rx.text.orEmpty.bind(to: viewModel.category)
            .disposed(by: disposeBag)
        
        authorTextField.rx.text.orEmpty.bind(to: viewModel.author)
            .disposed(by: disposeBag)
        
        chapterTextField.rx.text.orEmpty
            .map { Int($0) ?? 0 }
            .bind(to: viewModel.totalChapter)
            .disposed(by: disposeBag)
        
        summaryTextView.rx.text.orEmpty.bind(to: viewModel.summary)
            .disposed(by: disposeBag)
        
        ratingCosmos.didFinishTouchingCosmos = { rating in
            self.viewModel.avgRating.accept(Int(rating))
        }

        newComicButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            self.newComicButton.isSelected.toggle()
            if newComicButton.isSelected {
                newComicButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                self.viewModel.isNewComic.accept(true)
            } else {
                newComicButton.setImage(UIImage(systemName: "circle"), for: .normal)
                self.viewModel.isNewComic.accept(false)
            }
        }).disposed(by: disposeBag)
        
        trendingButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            self.trendingButton.isSelected.toggle()
            if trendingButton.isSelected {
                trendingButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                self.viewModel.isTrending.accept(true)
            } else {
                trendingButton.setImage(UIImage(systemName: "circle"), for: .normal)
                self.viewModel.isTrending.accept(true)
            }
        }).disposed(by: disposeBag)
        
        dropdownButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            topDropDown.show()
        })
        .disposed(by: disposeBag)
        
        submitBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            self.viewModel.saveAddModelToRealm()
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    @objc func chooseImageView() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("Không hỗ trợ")
            return
        }
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
}

extension AddViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            avatarImageView.contentMode = .scaleAspectFill
            avatarImageView.image = image
            viewModel.imageData.accept(image)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Tóm tắt" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Tóm tắt"
            textView.textColor = .lightGray
        }
    }
}
