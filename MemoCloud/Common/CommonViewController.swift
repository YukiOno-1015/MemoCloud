//
//  CommonViewController.swift
//  MemoCloud
//
//  Created by Yuki Ono on 2023/01/16.
//

import UIKit

class CommonViewController: UIViewController {
    
    var payloadText: [AnyHashable : Any]? {
        didSet {
            guard let userInfo = payloadText,
                  let payload = userInfo["aps"] as? [String:AnyObject],
                  let alert = payload["alert"] as? [String:AnyObject],
                  let title = alert["title"] as? String,
                  let subtitle = alert["subtitle"] as? String,
                  let body = alert["body"] as? String else{
                return
            }
            print(userInfo)
            view.backgroundColor = backgroundColor ?? .white
            
            var itemId = ""
            // 実際に処理で使いたい内容
            if let call = userInfo["call"] as? [String:AnyObject],
               let id = call["id"] as? String {
                itemId = id
           }
            print(title)
            print(subtitle)
            print(body)
            print(itemId)
            
            let alertController:UIAlertController = UIAlertController(title: "\(title)\n\(subtitle)", message: "\(body)\n\(itemId)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    var backgroundColor: UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor ?? .white
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
