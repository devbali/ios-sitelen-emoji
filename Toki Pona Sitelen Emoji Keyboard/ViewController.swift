//
//  ViewController.swift
//  Toki Pona Sitelen Emoji Keyboard
//
//  Created by Dev Bali on 29/04/20.
//  Copyright © 2020 Awara Badal Developments. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mainbutton: UIButton!
    
    @objc func gotosettings () {
        let url = URL.init(string: UIApplicationOpenSettingsURLString)
        if url != nil {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mainbutton.titleLabel?.numberOfLines = 10
        self.mainbutton.titleLabel?.textAlignment = .center
        self.mainbutton.setTitle("Click to enable the Sitelen Emoji Keyboard in your settings\n\nIn the Settings page, click Add Keyboard and select Sitelen Emoji", for: [])
        self.mainbutton.addTarget(self, action: #selector(gotosettings), for: .allTouchEvents)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

