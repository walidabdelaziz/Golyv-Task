//
//  ReposTVCell.swift
//  Golyv Task
//
//  Created by Walid Ahmed on 11/09/2023.
//

import UIKit

class ReposTVCell: UITableViewCell,AsyncImageLoadable,FormatDateProtocol {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var ownerLbl: UILabel!
    @IBOutlet weak var repoTitleLbl: UILabel!
    @IBOutlet weak var ownerImg: UIImageView!
    @IBOutlet weak var bgV: UIView!
    
    var repo: Repos? {
        didSet {
            guard let repo = repo else { return }
            ownerLbl.text = "By: \(repo.owner?.login ?? "")"
            repoTitleLbl.text = repo.fullName
            loadImage(from: repo.owner?.avatarURL ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgV.layer.cornerRadius = 10
        bgV.dropShadow(radius: 3, opacity: 0.08, offset: CGSize(width: 1, height: 1))
        ownerImg.layer.cornerRadius = 0.5 * ownerImg.frame.height
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
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            return date.formattedString()
        }
        return ""
    }
    func setDateAccordingToIndex(row: Int){
        var formattedDate = String()
        if row == 0{
            formattedDate = formatDate("2023-07-22")
        }else if row == 1{
            formattedDate = formatDate("2023-02-22")
        }else{
            formattedDate = formatDate("2021-03-22")
        }
        dateLbl.text = formattedDate
    }
}
