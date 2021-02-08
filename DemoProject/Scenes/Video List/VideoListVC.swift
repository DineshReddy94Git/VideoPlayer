//
//  VideoListVC.swift
//  DemoProject
//
//  Created by K12 Services on 02/01/21.
//

import UIKit

class VideoListVC: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    let VideoListVM = VideoListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mobiotics Video List"
        TableViewUI()
        getListApi()
    }
    
     func TableViewUI() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.tableFooterView = UIView()
        listTableView.register(UINib(nibName: "VideoListTVCell", bundle: nil), forCellReuseIdentifier: "VideoListTVCell")
        listTableView.separatorStyle = .none
    }
}

//MARK:- Tableview delegate and Datasource
extension VideoListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VideoListVM.videoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTVCell", for: indexPath) as! VideoListTVCell
        cell.itemData = self.VideoListVM.videoList?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = playVideoListSB.instantiateViewController(withIdentifier: "PlayVideoListVC") as! PlayVideoListVC
        print(self.VideoListVM.videoList?[indexPath.row].url ?? "")
        vc.title = self.VideoListVM.videoList?[indexPath.row].title ?? ""
        vc.getUrl = self.VideoListVM.videoList?[indexPath.row].url ?? ""
        vc.getData = self.VideoListVM.videoList
        vc.getTitle = self.VideoListVM.videoList?[indexPath.row].title ?? ""
        vc.getDescription = self.VideoListVM.videoList?[indexPath.row].description ?? ""
        vc.getIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- Api Calls
extension VideoListVC {
    func getListApi(){
        VideoListVM.getVideoList {
            DispatchQueue.main.async {
                print(self.VideoListVM.videoList?.count ?? 0)
                self.listTableView.reloadData()
            }
        }
    }
}
