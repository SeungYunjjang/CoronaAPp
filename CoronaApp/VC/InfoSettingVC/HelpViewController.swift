//
//  HelpViewController.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/28.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import UIKit

class HelpViewController: BaseViewController, Alertable {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var seachTextField: UITextField!
    
    private var helperList: [Helper] = []
    private let helperListCell: String = "helperListCell"
    private let cellHeight = UIScreen.main.bounds.height * 160 / 1920
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonData()
        tableView.tableHeaderView = headerView
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
        searchView.isHidden = false
    }
    
    @IBAction func tableViewTapGesture(_ sender: Any) {
        seachTextField.resignFirstResponder()
    }
    
    @IBAction func sendEmailBtn(_ sender: UIButton) {
        let subject = "코로나 감염자 이동 지역 제보합니다"
        let content = "1. 제보자 성명 / 별명: \n\n2. 나를 소개할 수 있는 제보자 한마디 - 선택사항: \n\n3. 나를 소개하는 홈페이지 주소(인스타 / 페이스북 등) - 선택사항 : - \n\n4. 감염자 이동 지역(ex: 인천공항) : \n\n5. 감연자 이동 지역 방문 날짜 : \n\n6. 감염자 이동지역 좌표 - 선택사항 : "
        
        if let encoedParam = "subject=\(subject).&body=\(content)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let emailUrl = URL(string: "mailto:coronasearchhelp@gmail.com?\(encoedParam)") {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    @IBAction func emailPasteBtn(_ sender: UIButton) {
        UIPasteboard.general.string = "coronasearchhelp@gmail.com"
        showAlert(title: "주소복사가 완료되었습니다.", confirm: "확인")
    }
    
    private func getJsonData() {
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "Helper", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let helper = try? decoder.decode([Helper].self, from: data)
            else { return }
        
        DispatchQueue.main.async {
            self.helperList.append(contentsOf: helper.reversed())
            self.tableView.reloadData()
        }
    }
    
}

extension HelpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helperList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: helperListCell, for: indexPath) as! HelperListCell
        cell.display(with: helperList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = helperList[indexPath.row].origin_link,
            let url = URL(string: urlString) else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchView.isHidden = true
    }
    
}

extension HelpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
