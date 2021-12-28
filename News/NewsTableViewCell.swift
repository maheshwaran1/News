//
//  NewsTableViewCell.swift
//  News
//
//  Created by MAHESHWARAN on 7/29/21.
//

import UIKit
//import SDWebImage


//newsTableViewCellViewModel

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(
         title: String,
         subtitle: String,
         imageURL: URL?
         )
    {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        
    }
}


class NewsTableViewCell: UITableViewCell {

   static let identifier = "NewsTableViewCell"
    
    //title
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        //number of lines
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    //subtitleLabel
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        //number of lines
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    //image
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        //clip to bound for image
        imageView.clipsToBounds = true
        
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        //border
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        //corner border
        imageView.layer.cornerRadius = 15
        return imageView
        
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
  //layoutsubview---------------------------------
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //title
        newsTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 200, height: 70)
        //subtitle
        subtitleLabel.frame = CGRect(x: 10, y: 70, width: contentView.frame.size.width - 200, height: contentView.frame.size.height/2)
        //ImageView
        newsImageView.frame = CGRect(x: contentView.frame.size.width-170, y: 3, width: 150, height: contentView.frame.size.height-10)
    }
    
    
    
    //prepare for reuse()--------------------------------
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    
    
    //news table viewcell----------------------------
    
    func configure(with viewModel: NewsTableViewCellViewModel ){
        newsTitleLabel.text = viewModel.title
        
        subtitleLabel.text = viewModel.subtitle
        
        
        /*
         
         
         */
        
        
        
        //image
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
            
        }
        else if let url = viewModel.imageURL{
            //fetch and download url image from api
            
            /*
             
             newsImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo.circle"), options: .continueInBackground, completed: nil)
             */
            
            
            
            
            
            /*
            
            URLSession.shared.dataTask(with: url){[weak self] data, _ ,error in
                guard let data = data, error == nil else {
                    return
                }
                //main thread - for download image
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
            
            
            */
            
        }
        
    }
}
