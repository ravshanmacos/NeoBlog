//
//  PostDetailScreenRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit
import Kingfisher
import Combine

class PostDetailScreenRootView: ScrollableBaseView {
    
    //MARK: Properties
    private let userProfileView = MainContainerViewComponents.makeProfileView()
    private let postCreateAtView = MainContainerViewComponents.makeHeaderLabel()
    private let postTitleLabel = MainContainerViewComponents.makePostTitleLabel()
    private let postSubtitleLabel = makePostSubtitleLabel()
    private let postImageView = MainContainerViewComponents.makePostImageView(with: nil)
    private let categoryInfoLabel = makeCategoryInfoLabel(with: "Искусство")
    private let commentsView = CommentsView(comments: [])
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: PostDetailScreenViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: PostDetailScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        scrollViewContent.addSubviews(userProfileView, postCreateAtView)
        scrollViewContent.addSubviews(postTitleLabel, postSubtitleLabel)
        scrollViewContent.addSubviews(postImageView, categoryInfoLabel, commentsView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
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
            make.height.equalTo(250)
            
        }
        
        categoryInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview()
        }
        
        commentsView.snp.makeConstraints { make in
            make.top.equalTo(categoryInfoLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(260)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        commentsView.sendMessageView.delegate = self
    }
    
    private func bindViewModelToView() {
        viewModel
            .$post
            .receive(on: DispatchQueue.main)
            .filter { $0 != nil }
            .sink {[weak self] post in
                guard let self else { return }
                self.configurePostDetails(with: post)
            }.store(in: &subscriptions)
    }
    
    private func configurePostDetails(with post: BlogPost?) {
        extractLabelFromStack()?.text = post?.author?.username
        postCreateAtView.text = post?.publicationDate
        postTitleLabel.text = post?.title
        postSubtitleLabel.text = post?.description
        postSubtitleLabel.setLineSpacing(lineHeightMultiple: 1.3)
        commentsView.updateComments(with: post?.postComments)
        postImageView.kf.setImage(with: post?.getImageURL(), placeholder: R.image.post_sample_image_full())
    }
    
    private func extractLabelFromStack() -> UILabel? {
        guard let label = userProfileView.subviews[1] as? UILabel else { return nil }
        return label
    }
}



extension PostDetailScreenRootView: SendMessageFieldViewDelegate {
    func sendMessageTapped(message: String, textfield: UITextField) {
        viewModel.createComment(with: message) {
            textfield.text = nil
        }
    }
}

//MARK: Components
extension PostDetailScreenRootView {
    enum Strings: String {
        case titleLabel = "Три портрета Надежды Половцовой и не только"
        case subtitleLabel = "Просматривая портреты разных художников, невольно обращаешь внимание на тех, кто оставил след в истории. Каролюс-Дюран был одним из популярнейших французских салонных портретистов последней четверти XIX века. Его работы регулярно выставлялись в парижских Салонах; ему неоднократно присуждались награды. При создании портретов он талантливо умел сочетать достоверность с разумной долей идеализации при передаче облика портретируемых.В 1876 году Каролюс-Дюран приехал в Санкт-Петербург. Он был выписан в столицу Российской империи сенатором и почетным членом Академии художеств Александром Александровичем Половцовым. В Петербурге им были написаны как минимум два портрета: барона Штиглица и жены Половцова — Надежды Михайловны."
    }
    
    static func makePostSubtitleLabel() -> UILabel {
        let label = MainContainerViewComponents.makePostSubtitleLabel()
        label.numberOfLines = 0
        return label
    }
    
    static func makeCategoryInfoLabel(with text: String = "") -> InfoWithTwoSides {
        let infoWithTwoSides = InfoWithTwoSides()
        infoWithTwoSides.setLeftSideLabel(text: "Категория:")
        infoWithTwoSides.setRightSideLabel(text: text)
        return infoWithTwoSides
    }
    
    static func testComments() -> [CommentFake] {
        let comment1 = CommentFake(username: "alisanes", date: "14 дек в 20:17", description: "Прикольно")
        let comment2 = CommentFake(username: "kiyaki", date: "14 дек в 22:49", description: "Интересная статья")
        let comment3 = CommentFake(username: "kiyaki", date: "14 дек в 22:49", description: "Интересная статья")
        let comment4 = CommentFake(username: "kiyaki", date: "14 дек в 22:49", description: "Интересная статья")
        return [comment1, comment2, comment3, comment4 ]
    }
}


//MARK: PlaceHolder
/*
 //        if let label = userProfileView.subviews[1] as? UILabel {
 //            label.text = "yamahaman"
 //        }
 //        postCreateAtView.text = "14 дек в 21:00"
 //        postTitleLabel.text = Strings.titleLabel.rawValue
 //        postSubtitleLabel.text = Strings.subtitleLabel.rawValue
 //        postSubtitleLabel.setLineSpacing(lineHeightMultiple: 1.3)
 //        postImageView.image = R.image.post_sample_image_full()
 */
