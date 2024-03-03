//
//  CommentsView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 23/02/24.
//

import UIKit

struct CommentFake {
    let username: String
    let date: String
    let description: String
}

class CommentsView: BaseView {
    
    //MARK: Properties
    
    private let divider1 = makeDivider()
    private let divider2 = makeDivider()
    private let tableview = makeTableView()
    private let sendMessageView = makeSendMessageFieldView()
    
    private let comments: [CommentFake]
    //MARK: Methods
    
    init(frame: CGRect = .zero, comments: [CommentFake]) {
        self.comments = comments
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(divider1, tableview, divider2, sendMessageView)
        
        divider1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        divider2.snp.makeConstraints { make in
            make.top.equalTo(tableview.snp.bottom)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
        
        sendMessageView.snp.makeConstraints { make in
            make.top.equalTo(divider2.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        tableview.dataSource = self
        tableview.delegate = self
    }
}

extension CommentsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.isEmpty ? 1 : comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if comments.isEmpty {
            guard let emptyCommentsCell = EmptyCommentsCell.deque(on: tableView, at: indexPath)
            else { return cell }
            cell = emptyCommentsCell
        } else {
            guard let commentTableViewCellell = CommentTableViewCell.deque(on: tableView, at: indexPath) else { return cell }
            let comment = comments[indexPath.item]
            commentTableViewCellell.setUsernameLabel(with: comment.username)
            commentTableViewCellell.setDateLabel(with: comment.date)
            commentTableViewCellell.setDescriptionLabel(with: comment.description)
            cell = commentTableViewCellell
        }
        return cell
    }
}

extension CommentsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let numberOfCommentsLabel = makeNumberOfCommentsLabel()
        numberOfCommentsLabel.text = "Комментарии (\(comments.count))"
        return numberOfCommentsLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        comments.isEmpty ? 200 : UITableView.automaticDimension
    }
}

private extension CommentsView {
    static func makeTableView() -> UITableView {
        let tableview = UITableView()
        tableview.separatorStyle = .none
        CommentTableViewCell.register(to: tableview)
        EmptyCommentsCell.register(to: tableview)
        return tableview
    }
    
    func makeNumberOfCommentsLabel() -> UILabel {
        let label = UILabel()
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }
    
    static func makeSendMessageFieldView() -> SendMessageFieldView {
        let view = SendMessageFieldView()
        //view.disableSendMsgBtn()
        return view
    }
    
    static func makeDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = R.color.gray_color_3()
        return view
    }
}
