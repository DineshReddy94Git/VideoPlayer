//
//  PlayVideoListVC.swift
//  DemoProject
//
//  Created by K12 Services on 04/01/21.
//

import UIKit
import GPVideoPlayer

class PlayVideoListVC: UIViewController {

    @IBOutlet weak var avPlayerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var videoListTableView: UITableView!
    
    var getUrl = String()
    var getData : [VideoListModel]? = nil
    var getTitle = String()
    var getDescription = String()
    var getIndex = Int()
    
    fileprivate func playVideo(videoUrl : String) {
        //https://cocoapods.org/pods/GPVideoPlayer
        if let player = GPVideoPlayer.initialize(with: self.avPlayerView.bounds) {
            player.isToShowPlaybackControls = true
            
            self.avPlayerView.addSubview(player)
            
            let url1 = URL(string: videoUrl)!
            player.loadVideos(with: [url1])
            player.isToShowPlaybackControls = true
            player.isMuted = true
            player.playVideo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        titleLabel.text = getTitle
        
        descriptionLabel.text = getDescription
        
        titleLabel.font = UIFont(name: "Helvetica Neue Bold", size: 17)

        descriptionLabel.font = UIFont(name: "Helvetica Neue", size: 14)
        
        videoListTableView.delegate = self
        videoListTableView.dataSource = self
        videoListTableView.register(UINib(nibName: "VideoListTVCell", bundle: nil), forCellReuseIdentifier: "VideoListTVCell")
        playVideo(videoUrl: getUrl)
        
    }
    
}
extension PlayVideoListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTVCell", for: indexPath) as! VideoListTVCell
        cell.itemData = self.getData?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        title = self.getData?[indexPath.row].title
        playVideo(videoUrl: self.getData?[indexPath.row].url ?? "")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
////        let indexPath:IndexPath = IndexPath(row: getIndex, section: 0)
////        self.videoListTableView.scrollToRow(at: indexPath, at: .none, animated: true)
//        self.videoListTableView.beginUpdates()
//        self.videoListTableView.scrollToRow(at: IndexPath.init(row: getIndex, section: 0), at: .bottom, animated: true)
//        self.videoListTableView.endUpdates()
//    }
    
}
