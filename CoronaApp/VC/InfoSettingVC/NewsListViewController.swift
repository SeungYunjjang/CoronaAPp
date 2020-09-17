//
//  NewsListViewController.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/26.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import UIKit

class NewsListViewController: BaseViewController, Alertable {

    @IBOutlet weak var tableView: UITableView!
    
    private var newsItemList: [NewsPresentModel] = []
    private var pageNum: Int = 1
    
    private let newsListCell: String = "newsListCell"
    private let cellHeight = UIScreen.main.bounds.height * 240 / 1920

    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsList()
    }
    
    private func getNewsList() {

        let query: String = "https://openapi.naver.com/v1/search/news.json?query=코로나&display=10&start=\(pageNum)&sort=sim"
    
        guard let queryUrl: String = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: queryUrl) else { return }
        
        var request = URLRequest(url: url)
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("pxtA4prm9VpNRUv9cvkk", forHTTPHeaderField: "X-Naver-Client-ID")
        request.addValue("VcTY7r4MXO", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let _data = data,
                let newsList = try? JSONDecoder().decode(News.self, from: _data)
                else {
                    self.showErrorAlert()
                    return
            }
        
            DispatchQueue.main.async {
                let newsPresentModels = newsList.items.map { NewsPresentModel.init($0) }
                self.newsItemList.append(contentsOf: newsPresentModels)
                self.tableView.reloadData()
            }
            
        }.resume()
     
    }

    private func showErrorAlert() {
        showAlert(title: "서버에러", message: "Safari로 네이버 뉴스를 보시겠습니까?", confirm: "확인", cancel: "취소", confirmAction: { (action) in
            guard let url = URL(string: "https://search.naver.com/search.naver?where=news&sm=tab_jum&query=코로나") else {
                    return
            }
            UIApplication.shared.open(url, options: [:])
        }) { (action) in
            
        }
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsListCell, for: indexPath) as! NewsListCell
        
        cell.display(with: newsItemList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: newsItemList[indexPath.row].originLink) else {
            self.showErrorAlert()
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= (newsItemList.count / 10) * 10 - 2 {
            pageNum += 10
            getNewsList()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
}
