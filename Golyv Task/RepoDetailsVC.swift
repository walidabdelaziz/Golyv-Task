//
//  RepoDetailsVC.swift
//  Golyv Task
//
//  Created by Walid Ahmed on 11/09/2023.
//

import UIKit
import RxSwift

class RepoDetailsVC: UIViewController,AsyncImageLoadable {

    let repoViewModel = ReposViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var privateIcon: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var ownerLbl: UILabel!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var ownerImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        bindViewModel()
    }
    func setupUI(){
        navigationController?.setNavigationBarHidden(true, animated: true)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        ownerImg.layer.cornerRadius = 0.5 * ownerImg.frame.height
    }
    func bindViewModel(){
        // handle back action
        backBtn.rx.tap
            .bind(onNext: {[weak self] in
                guard let self = self else{return}
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        // load data
        repoViewModel.selectedRepo.asObservable()
            .bind(onNext: {[weak self] (selectedRepo) in
                guard let self = self else{return}
                self.fetchData(repo: selectedRepo)
            }).disposed(by: disposeBag)
    }
    func fetchData(repo: Repos){
        descriptionLbl.text = repo.description
        ownerLbl.text = "By \(repo.owner?.login ?? "")"
        repoNameLbl.text = repo.fullName ?? ""
        loadImage(from: repo.owner?.avatarURL ?? "")
        privateIcon.image = (repo.welcomePrivate ?? true) ? UIImage(named: "correctIcon") : UIImage(named: "wrongIcon")
    }
    func loadImage(from urlString: String) {
        Task {
            do {
                let image = try await NetworkManager.shared.loadImage(from: urlString)
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else{return}
                    self.ownerImg.image = image
                }
            } catch {
                print("Error loading image: \(error)")
            }
        }
    }
}
extension RepoDetailsVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //disable bounce only at the top of the screen
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
