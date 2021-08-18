//
//  NewsFeedViewModel.swift
//  Assignment
//
//  Created by Abhishek on 17/08/21.
//

import UIKit
import AlamofireImage

protocol NewsFeedViewModelDelegate: class{
    func pullToRefreshAction()
}

class NewsFeedViewModel: UIView {
    
    @IBOutlet weak var tblView: UITableView!
    
    var newsFeed: NewsResponse?
    weak var delegate: NewsFeedViewModelDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setUpTableView()
    }
    
    class func instanceFromNib() -> NewsFeedViewModel {
        return UINib(nibName: "NewsFeedViewModel", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NewsFeedViewModel
    }
    
    /// Refresh control is lazy variable type.
    /// It will setup the controller action for pull to refresh
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(self.refreshControlAction), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .black
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black,]
        let attributedTitle = NSAttributedString(string: Messages.refreshingData, attributes: attributes as [NSAttributedString.Key : Any])
        
        refreshControl.attributedTitle = attributedTitle
        return refreshControl
        
    }()
    
    func setUpTableView() {
        tblView.register(UINib(nibName: AppConstants.CellReuseIdentifiers.newsFeedTableCell, bundle: nil), forCellReuseIdentifier: AppConstants.CellReuseIdentifiers.newsFeedTableCell)
        tblView.register(UINib(nibName: AppConstants.CellReuseIdentifiers.NewsFeedNormalTableCell, bundle: nil), forCellReuseIdentifier: AppConstants.CellReuseIdentifiers.NewsFeedNormalTableCell)
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 100
        tblView.rowHeight = UITableView.automaticDimension
        tblView.tableFooterView = UIView()
        tblView.separatorStyle = .none
        tblView.refreshControl = refreshControl
    }
    
    func reloadTableData(_ nFeed: NewsResponse?) {
        newsFeed = nFeed
        tblView.reloadData()
    }
    
    @objc func refreshControlAction() {
        delegate?.pullToRefreshAction()
    }
    /// It will stop pull to refresh command
    func stopRefreshControl(){
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tblView.refreshControl?.endRefreshing()
        }
    }
}


extension NewsFeedViewModel: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed?.newsItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard newsFeed?.newsItems?[indexPath.row] != nil else {
            return 0
        }
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        } else{
            if AppUtils.isIphone() {
            return 140
            }
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.CellReuseIdentifiers.newsFeedTableCell) as! NewsFeedTableCell
            setUpLargeCell(cell,indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.CellReuseIdentifiers.NewsFeedNormalTableCell) as! NewsFeedNormalTableCell
            setUpNormalCell(cell,indexPath)
            return cell
        }
    }
    
    func setUpLargeCell(_ cell: NewsFeedTableCell, _ indexPath:IndexPath){
        if let obj = newsFeed?.newsItems?[indexPath.row] {
            cell.lblTitle.text = obj.title ?? ""
            if let dateStr = obj.pubDate {
                cell.lblDate.attributedText = getAttributedText(dateStr: dateStr)
            }
            let urlStr = obj.thumbnail?.convertSpecialCharacters() ?? ""
            setImage(imgView: cell.imgView, strURL: urlStr)
        } else{
            cell.imgView.image = #imageLiteral(resourceName: "Placeholder")
            cell.lblTitle.text = ""
            cell.lblDate.text = ""
        }
        
    }
    
    func setUpNormalCell(_ cell: NewsFeedNormalTableCell, _ indexPath:IndexPath){
        if let obj = newsFeed?.newsItems?[indexPath.row] {
            cell.lblTitle.text = obj.title ?? ""
            if let dateStr = obj.pubDate {
                cell.lblDate.attributedText = getAttributedText(dateStr: dateStr)
            }
            let urlStr = obj.thumbnail?.convertSpecialCharacters() ?? ""
            setImage(imgView: cell.imgView, strURL: urlStr)
        } else{
            cell.imgView.image = #imageLiteral(resourceName: "Placeholder")
            cell.lblTitle.text = ""
            cell.lblDate.text = ""
        }
    }
    
    func setImage(imgView: UIImageView, strURL: String) {
        if let imgUrl = URL(string: strURL) {
            imgView.af.setImage(withURL: imgUrl, placeholderImage: #imageLiteral(resourceName: "Placeholder"))
        } else{
            imgView.image = #imageLiteral(resourceName: "Placeholder")
        }
    }
    
    func getAttributedText(dateStr: String) -> NSAttributedString {
        let date = DateUtils.stringToDateWithFormat(date: dateStr, format: AppConstants.DateFormat.dateTime)
        let dateObj = DateUtils.getDateDetails(date: date)
        let dateStr =  "\(dateObj.monthName.capitalized) \(dateObj.day), \(dateObj.year) \(dateObj.hours):\(dateObj.minutes) \(dateObj.amPm.uppercased())"
        let dateStrBold = "\(dateObj.monthName.capitalized) \(dateObj.day), \(dateObj.year)"
        return AppUtils.geAttributedText(mainStr: dateStr, boldStr: dateStrBold)
    }
    
}
