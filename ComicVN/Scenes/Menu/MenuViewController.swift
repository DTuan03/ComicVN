//  MenuViewController.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    private let viewModel = MenuViewModel()
    
    // MARK: - UI
    private lazy var avatarImage = ImageViewFactory.createImageView(image: UIImage(named: "avartarUser"),
                                                                    radius: 35)
    private lazy var titleLabel = LabelFactory.createLabel(text: "Để theo dõi nhiều truyện hay !",
                                                           font: .medium12, textColor: .black,
                                                           textAlignment: .center)
    private lazy var loginButton: UIButton = {
        let button = ButtonFactory.createButton("Đăng nhập ngay",
                                                image: UIImage(named: "arrowRight"),
                                                locationImageRight: true,
                                                font: .medium12, textColor: .white,
                                                bgColor: UIColor(hex: "#FF7B00"),
                                                rounded: true, height: 30, padding: -10)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private lazy var vInfo = UIView()
    private lazy var readView = UIView()
    private lazy var savedView = UIView()
    
    private lazy var readIcon = ImageViewFactory.createImageView(image: UIImage(named: "smart"))
    private lazy var savedIcon = ImageViewFactory.createImageView(image: UIImage(named: "reading"))
    private lazy var readLabel = LabelFactory.createLabel(text: "10", font: .regular16, textColor: .black)
    private lazy var savedLabel = LabelFactory.createLabel(text: "102", font: .regular16, textColor: .black)
    
    private lazy var readButton: UIButton = {
        let button = ButtonFactory.createButton("Đã đọc",
                                                image: UIImage(named: "smart"),
                                                font: .medium14, textColor: UIColor(hex: "#DE4C3F"),
                                                bgColor: UIColor(hex: "#FF9C8C", alpha: 0.29),
                                                rounded: true, height: 19, padding: -15)
        button.semanticContentAttribute = .forceRightToLeft
        button.frame.size.width = 112
        return button
    }()
    
    private lazy var savedButton: UIButton = {
        let button = ButtonFactory.createButton("Truyện Lưu",
                                                image: UIImage(named: "reading"),
                                                font: .medium14, textColor: UIColor(hex: "#0B1329"),
                                                bgColor: UIColor(hex: "#321910", alpha: 0.3),
                                                rounded: true, height: 19, padding: -20)
        button.semanticContentAttribute = .forceRightToLeft
        button.frame.size.width = 112
        return button
    }()
    
    private lazy var containerView = createContainerView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#C4C4C4", alpha: 0.6)
        let gradientView = createGradientView()
        view.addSubview(gradientView)
        
        let stackView = [readView, savedView].hStack(0, distribution: .fillEqually)
        
        gradientView.addSubviews([vInfo, containerView, tableView])
        vInfo.addSubviews([avatarImage, titleLabel, loginButton])
        containerView.addSubview(stackView)
        
        setupConstraints(stackView: stackView, containerView: containerView)
        setupVInfo()
        setupReadView()
        setupSavedView()
        setupTableView()
    }
    
    private func createGradientView() -> UIView {
        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: width * 0.77, height: height))
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor(hex: "#2EE2A1").cgColor, UIColor(hex: "#FFFFFF").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.25, y: 0.5)
        
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        return gradientView
    }
    
    private func createContainerView() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 6
        containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerView.layer.shadowColor = UIColor(hex: "#455154", alpha: 0.9).cgColor
        containerView.layer.shadowOpacity = 0.1
        return containerView
    }
    
    private func setupConstraints(stackView: UIStackView, containerView: UIView) {
        vInfo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(17)
            make.right.equalToSuperview().offset(31)
            make.height.equalTo(70)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(vInfo.snp.bottom).offset(32.5)
            make.left.right.equalToSuperview().inset(14)
            make.height.equalTo(75)
        }
    }
    
    private func setupVInfo() {
        avatarImage.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(avatarImage.snp.right).offset(6)
            make.height.equalTo(34)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(avatarImage.snp.right).offset(12)
            make.width.equalTo(147)
        }
    }
    
    private func setupReadView() {
        readView.addSubviews([readIcon, readLabel, readButton])
        readIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(8.5)
        }
        readLabel.snp.makeConstraints { make in
            make.left.equalTo(readIcon.snp.right).offset(5)
            make.top.equalToSuperview().offset(12.5)
        }
        readButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-14.23)
            make.left.right.equalToSuperview().inset(11)
        }
    }
    
    private func setupSavedView() {
        savedView.addSubviews([savedIcon, savedLabel, savedButton])
        savedIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(8.5)
        }
        savedLabel.snp.makeConstraints { make in
            make.left.equalTo(savedIcon.snp.right).offset(5)
            make.top.equalToSuperview().offset(12.5)
        }
        savedButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-14.23)
            make.left.right.equalToSuperview().inset(11)
        }
    }
    
    private func setupTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(64)
            make.left.right.equalToSuperview().inset(22)
            make.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 34
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        let menuItem = viewModel.item(at: indexPath)
        cell.configData(with: menuItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = UIView()
            headerView.backgroundColor = .clear
            
            let lineView = UIView()
            lineView.backgroundColor = UIColor(hex: "#979797")
            headerView.addSubview(lineView)
            
            lineView.snp.makeConstraints { make in
                make.left.equalTo(headerView.snp.left).offset(16)
                make.right.equalTo(headerView.snp.right).inset(16)
                make.top.equalToSuperview()
                make.height.equalTo(1)
            }
            
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 20 : 0
    }
    
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath)
        tableView.reloadData()
        let selectedAction = viewModel.item(at: indexPath).action
        handleMenuSelection(for: selectedAction)
    }
    
    private func handleMenuSelection(for action: MenuAction) {
        switch action {
        case .home:
            self.dismiss(animated: false)
        case .categories:
            print("Thể loại được chọn")
        case .topComics:
            print("Top truyện được chọn")
        case .rankings:
            print("Xếp hạng được chọn")
        case .bookmark:
            print("Bookmark được chọn")
        case .settings:
            print("Cài đặt được chọn")
        case .rateApp:
            print("Đánh giá 5 sao")
        case .sendFeedback:
            print("Gửi phản hồi")
        case .privacyPolicy:
            print("Chính sách bảo mật")
        }
    }
}
