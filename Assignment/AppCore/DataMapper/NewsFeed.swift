//
//  NewsFeed.swift
//  Assignment
//
//  Created by Abhishek on 17/08/21.
//

import Foundation

struct NewsFeed
{

private let httpUtility: HttpUtility

    init(_httpUtility: HttpUtility) {
        httpUtility = _httpUtility
    }

    func getNewsFeedData(successHandler: @escaping (_ result: NewsResponse?) -> Void, errorhandler: @escaping (_ error: String) -> Void )
    {
        guard let url = URL(string: WSConstants.Ws.BASE_URL) else {
            debugPrint(Messages.urlErrorMsg)
            errorhandler(Messages.urlErrorMsg)
            return
        }
        let request = Request(withUrl: url, forHttpMethod: .get)
        httpUtility.request(request: request, resultType: NewsResponse.self) { (response) in
            switch response
            {
            case .success(let result):
                guard let status = result?.status else {
                    debugPrint(Messages.commomMsg)
                    errorhandler(Messages.commomMsg)
                    return
                }
                
                if status.lowercased() != WSConstants.DefaultValues.ok {
                    debugPrint(Messages.commomMsg)
                    errorhandler(Messages.commomMsg)
                }
                
                successHandler(result)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                errorhandler(Messages.commomMsg)
            }
        }
    }
}
