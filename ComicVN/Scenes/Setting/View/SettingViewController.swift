//
//  SettingViewController.swift
//  ComicVN
//
//  Created by Tuấn on 2/3/25.
//

import UIKit
import SnapKit

class SettingViewController: BaseViewController {
    private let settingsSections = ["Dữ liệu", "Giao diện"]
    private let settingsItems = [
        ["Cache", "Dữ liệu ứng dụng"],
        ["Chế độ tối"]
    ]
    
    private var navigationView = UIView()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let logoutBtn: UIButton = {
        let button = ButtonFactory.createButton("Đăng xuất",
                                                image: UIImage(named: "logout"),
                                                font: .bold18, textColor: .white,
                                                bgColor: UIColor(hex: "#FF7B00"),
                                                rounded: true, padding: -20)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func setupUI() {
        navigationView = NavigationViewFactory.createMainNavigationView(leftImage: .menu, title: "Cài đặt", delegate: self)
        view.addSubviews([navigationView, tableView, logoutBtn])
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(230)
            
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        logoutBtn.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(85)
            make.centerX.equalToSuperview()
            make.width.equalTo(176)
            make.height.equalTo(48)
        }
    }
}

extension SettingViewController: NavigationViewDelegate {
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
    }
}

    // MARK: - UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        configureCell(cell, at: indexPath)
        return cell
    }
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let text = settingsItems[indexPath.section][indexPath.row]
        cell.textLabel?.text = text
        cell.textLabel?.font = .medium18
        cell.indentationLevel = 1
        cell.indentationWidth = 6

        if text == "Chế độ tối" {
            cell.accessoryView = createSwitch()
        } else {
            cell.accessoryView = createDeleteButton()
        }
    }

    private func createSwitch() -> UISwitch {
        let themeSwitch = UISwitch()
        themeSwitch.isOn = false
        themeSwitch.onTintColor = UIColor(hex: "#FF7B00")
        themeSwitch.thumbTintColor = .white
        themeSwitch.addTarget(self, action: #selector(darkModeChanged(_:)), for: .valueChanged)
        return themeSwitch
    }

    private func createDeleteButton() -> UIView {
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Xóa", for: .normal)
        deleteButton.titleLabel?.font = .medium14
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.backgroundColor = UIColor(hex: "#DCDBDB")
        deleteButton.layer.cornerRadius = 15
        deleteButton.frame = CGRect(x: 0, y: 0, width: 78, height: 30)
        deleteButton.addTarget(self, action: #selector(deleteData(_:)), for: .touchUpInside)

        let containerView = UIView(frame: deleteButton.frame)
        containerView.addSubview(deleteButton)
        return containerView
    }

    @objc private func deleteData(_ sender: UIButton) {
        if let cell = sender.superview as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            print("Xóa dữ liệu của cell tại \(indexPath.section)-\(indexPath.row)")
        }
    }


    @objc private func darkModeChanged(_ sender: UISwitch) {
        print("Chế độ tối: \(sender.isOn)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white

        let titleLabel = UILabel()
        titleLabel.text = settingsSections[section]
        titleLabel.font = UIFont.semiBold18
        titleLabel.textColor = UIColor.black

        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(21)
            make.centerY.equalToSuperview()
        }

        return headerView
    }
}

// MARK: - UITableViewDelegate
extension SettingViewController: UITableViewDelegate { }
