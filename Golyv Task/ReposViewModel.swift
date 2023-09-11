//
//  ReposViewModel.swift
//  Golyv Task
//
//  Created by Walid Ahmed on 11/09/2023.
//

import Foundation
import RxSwift
import RxCocoa

class ReposViewModel {

    let disposeBag = DisposeBag()
    var currentPage = 1
    let repos = BehaviorRelay<[Repos]>(value: [])
    let isSuccess = BehaviorRelay<Bool>(value: false)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<Error>()
    let loadNextPageTrigger = PublishSubject<Void>()

    func getRepos(){
        guard !isLoading.value else { return }
        isLoading.accept(true)
        NetworkManager.shared.fetchData(from: "\(Consts.REPOS)?page=\(currentPage)&limit=10") {[weak self] (result: Result<[Repos], Error>) in
            guard let self = self else { return }
            self.isLoading.accept(false)
            switch result {
            case .success(let response):
                self.currentPage += 1
                self.repos.accept((self.repos.value) + (response))
            case .failure(let error):
                self.error.onNext(error)
            }
        }      
    }
    func bindLoadNextPageTrigger() {
        loadNextPageTrigger
            .subscribe(onNext: { [weak self] in
                self?.getRepos()
            }).disposed(by: disposeBag)
    }
}
