//
//  SplashVC.swift
//  Golyv Task
//
//  Created by Walid Ahmed on 11/09/2023.
//

import UIKit

class SplashVC: UIViewController {

    var count = 2
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    func setupUI(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
    }
    @objc func updateUI(){
        if count > 0 {
            count -= 1
        }else{
            showVC()
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    @objc func showVC(){
        let storyboard = UIStoryboard(name: "Repos", bundle: nil)
        let ReposVC = storyboard.instantiateViewController(withIdentifier: "ReposVC")
        navigationController?.pushViewController(ReposVC, animated: true)
    }
}
