//
//  ViewController.swift
//  MemoCloud
//
//  Created by Yuki Ono on 2023/01/07.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var payloadText: String? {
        didSet {
            guard label != nil else { return }
            label.text = payloadText
            view.backgroundColor = backgroundColor ?? .white
        }
    }

    var backgroundColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
