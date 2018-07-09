//
//  RingerViewController.swift
//  Swift3
//
//  Created by Mathews on 07/06/18.
//  Copyright © 2018 experion. All rights reserved.
//

import UIKit

class RingerViewController: UIViewController {

    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.acceptButton.addTarget(self, action: #selector(self.acceptVideoCall), for: .touchUpInside)
        self.rejectButton.addTarget(self, action: #selector(self.rejectVideoCall), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension RingerViewController {
    
    @objc func acceptVideoCall() {
        let controller = UIStoryboard(name: "VideoCall", bundle: Bundle.main).instantiateViewController(withIdentifier: "VideoCallViewController") as! VideoCallViewController
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.setRootView(controller: controller)
    }
    
    @objc func rejectVideoCall() {
        
    }
    
}
