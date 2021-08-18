//
//  NewsListVC.swift
//  assignment
//
//  Created by Abhishek on 17/08/21.
//

import UIKit

class NewsListVC: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    
    var newsFeed: NewsResponse?
    var newsFeedVM: NewsFeedViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTitle()
        setUpNewsFeedVM()
        getNewsFeedData()
    }

    func setUpNewsFeedVM() {
        newsFeedVM = NewsFeedViewModel.instanceFromNib()
        newsFeedVM.frame = vwContainer.bounds
        newsFeedVM.delegate = self
        vwContainer.addSubview(newsFeedVM)
    }
}

extension NewsListVC {
    
    func getNewsFeedData() {
        AppUtils.showProgress(objectView: self)
        let newsFeedObj = NewsFeed(_httpUtility: HttpUtility.shared)
        newsFeedObj.getNewsFeedData { (response) in
            DispatchQueue.main.async {
                self.newsFeed = response
                self.newsFeedVM.reloadTableData(self.newsFeed)
                AppUtils.hideProgress(objectView: self)
            }
        } errorhandler: { (errorStr) in
            DispatchQueue.main.async {
            AppUtils.hideProgress(objectView: self)
            AppUtils.showToast(msg: errorStr, objectView: self)
            }
        }
    }
    
    func updateTitle() {
        self.title = "GeeksForGeeks"
    }
}

extension NewsListVC: NewsFeedViewModelDelegate {
    func pullToRefreshAction() {
        getNewsFeedData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.newsFeedVM.stopRefreshControl()
        }
       
    }
}
