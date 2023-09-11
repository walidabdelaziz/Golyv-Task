//
//  ReposVC.swift
//  Golyv Task
//
//  Created by Walid Ahmed on 11/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ReposVC: UIViewController {

    let reposViewModel = ReposViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var reposTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        bindViewModel()
        reposViewModel.getRepos()
    }
    func setupUI(){
        title = "Repositories"
        navigationItem.setHidesBackButton(true, animated: true)
        setTableView()
    }
    func setTableView(){
        reposTV.register(UINib(nibName: "ReposTVCell", bundle: nil), forCellReuseIdentifier: "ReposTVCell")
        reposTV.estimatedRowHeight = UITableView.automaticDimension
    }
    func bindViewModel(){
        reposViewModel.repos
            .bind(to: reposTV.rx.items(cellIdentifier: "ReposTVCell", cellType: ReposTVCell.self)) { row, repo, cell in
                cell.selectionStyle = .none
                cell.repo = repo
            }
            .disposed(by: disposeBag)
        
        // show error
        reposViewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        // handle next page trigger
        reposViewModel.bindLoadNextPageTrigger()
            
       // handle selection in tableview
        Observable
            .zip(self.reposTV.rx.itemSelected, self.reposTV.rx.modelSelected(Repos.self))
            .bind { [unowned self] indexPath, model in
                self.naviagateToDetailsScreen(model: model)
            }
            .disposed(by: disposeBag)
        
        // Load the next page when reaching the end
        reposTV.rx.willDisplayCell
                .subscribe(onNext: { [weak self] cell, indexPath in
                    guard let self = self else { return }
                    let lastElement = self.reposViewModel.repos.value.count - 1
                    if indexPath.row == lastElement {
                        self.reposViewModel.loadNextPageTrigger.onNext(())
                    }
                }).disposed(by: disposeBag)

    }
    func naviagateToDetailsScreen(model: ControlEvent<Repos>.Element){
        let storyboard = UIStoryboard(name: "Repos", bundle: nil)
        let RepoDetailsVC = storyboard.instantiateViewController(withIdentifier: "RepoDetailsVC") as! RepoDetailsVC
        RepoDetailsVC.repoViewModel.selectedRepo.accept(model)
        navigationController?.pushViewController(RepoDetailsVC, animated: true)
    }
    
}
