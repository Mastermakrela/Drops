//
//  SettingsViewController.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 08/07/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //Properties
    private let defaults = UserDefaults.standard
    var settings: [String : Any] = [
        "IgelBball" : false,
        ] {
        didSet {
            saveSettings()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        settings = defaults.dictionary(forKey: "settings") ?? [:]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        settings = defaults.dictionary(forKey: "settings") ?? [:]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(settings)
    }
    
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        saveSettings()
        NotificationCenter.default.post(name: NotificationNames.backFromSettings, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func saveSettings() {
        defaults.set(settings, forKey: "settings")
    }

}
