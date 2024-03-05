//
//  PostsTableviewCell.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 21/02/24.
//

import UIKit

protocol PostsTableviewCellDelegate {
    func savePost(_ saved: ((Bool)->Void))
    func openComments()
    func seeMore()
}

class PostsTableviewCell: UITableViewCell {
    
    //MARK: Properties
    private let userProfileView = MainContainerViewComponents.makeProfileView()
    private let postCreateAtView = MainContainerViewComponents.makeHeaderLabel()
    private let postTitleLabel = MainContainerViewComponents.makePostTitleLabel()
    private let postSubtitleLabel = MainContainerViewComponents.makePostSubtitleLabel()
    private let postImageView = makePostImageView()
    private let commentsAndSaveView = makeCommentsAndSaveView()
    private let postCategoryLabel = makePostCategoryLabel()
    
    private let postViewWrapper = UIView()
    private let postView = UIView()
    
    var delegate: PostsTableviewCellDelegate?
    
    //MARK: Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstaints()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUsername(with text: String?) {
        if let label = userProfileView.subviews[1] as? UILabel {
            label.text = text ?? "user"
        }
    }
    
    func setCreated(at date: String?) {
        postCreateAtView.text = date
    }
    
    func setCommentsCount(with count: Int?) {
        if let commentsBtn = commentsAndSaveView.subviews[0] as? UIButton {
            if let count {
                commentsBtn.setTitle(String(count), for: .normal)
            }
        }
    }
    
    func setTitle(with text: String?) {
        postTitleLabel.text = text
    }
    
    func setSubtitle(wtih text: String?) {
        postSubtitleLabel.text = text
        postSubtitleLabel.numberOfLines = 6
        postSubtitleLabel.setLineSpacing(lineHeightMultiple: 1.3)
    }
    
    func setImage(urlString: String?) {
        if let urlString, let imageURL = URL(string: urlString) {
            postImageView.kf.setImage(with: imageURL, placeholder: R.image.post_sample_image_full())
        }
    }
    
    func IsPostInCollection(saved: Bool) {
        if let saveBtn = commentsAndSaveView.subviews[1] as? UIButton {
            saveBtn.isSelected = saved
        }
    }
    
    func setCategoryLabel(with text: String?) {
        postCategoryLabel.text = text
    }
}

//MARK: Layout
private extension PostsTableviewCell {
    func setupSubviews() {
        contentView.addSubviews(postViewWrapper)
        postViewWrapper.addSubviews(postView)
        postView.addSubviews(userProfileView, postCreateAtView, postTitleLabel, postSubtitleLabel)
        postView.addSubviews(postImageView, commentsAndSaveView, postCategoryLabel)
    }
    
    func setupConstaints() {
        postViewWrapper.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        postView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().offset(-10)
        }
        
        userProfileView.snp.makeConstraints { $0.top.leading.equalToSuperview() }
        postCreateAtView.snp.makeConstraints { $0.top.trailing.equalToSuperview() }
        
        postTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userProfileView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        postSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(postTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(postSubtitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            
        }
        
        commentsAndSaveView.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(10)
            make.leading.bottom.equalToSuperview()
        }
        
        postCategoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(commentsAndSaveView.snp.centerY)
            make.trailing.equalToSuperview()
        }
    }
    
    func configureAppearance() {
        postViewWrapper.layer.borderColor = R.color.gray_color_2()?.cgColor
        postViewWrapper.layer.borderWidth = 0.3
        postViewWrapper.layer.cornerRadius = 8
        
        if let commentsBtn = commentsAndSaveView.subviews[0] as? UIButton {
            commentsBtn.addTarget(self, action: #selector(openCommentsTapped), for: .touchUpInside)
        }
        
        if let saveBtn = commentsAndSaveView.subviews[1] as? UIButton {
            saveBtn.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
        }
    }
}

@objc private extension PostsTableviewCell {
    func saveBtnTapped(_ sender: UIButton) {
        delegate?.savePost({ saved in
            sender.isSelected = saved
        })
    }
    
    func openCommentsTapped() {
        print("Open comments tapped")
        delegate?.openComments()
    }
}
