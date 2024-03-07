//
//  AddPostScreenRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit
import Combine

class AddPostScreenRootView: ScrollableBaseView {
    
    //MARK: Properties
    private let titleLabel = makeTitleLabel()
    private let categoryLabel = makeCategoryLabel()
    private let collectionView = makeCollectionView()
    //Buttons
    private let closeButton = makeCloseViewButton()
    private let publishPostBtn = makePublisheButton()
    
    //Fields
    private let headingTextfield = makeHeadingTextfield()
    private let descriptionTextview = makeDescriptionTextview()
    private let headerHStack = makeHeaderHStack()
    
    private let uploadImageViewWrapper = makeUploadImageViewWrapper()
    var uploadImageView: UploadImageView?
    var uploadedImageView: UploadedImageView?
    
    private var subscriptions = Set<AnyCancellable>()
    private let reuseIdentifier = "categoryButtonCell"
    private let viewModel: AddPostScreenViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: AddPostScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        scrollViewContent.addSubviews(headerHStack, headingTextfield)
        headerHStack.addArrangedSubviews(closeButton, titleLabel)
        scrollViewContent.addSubviews(categoryLabel, collectionView, descriptionTextview)
        scrollViewContent.addSubviews(uploadImageViewWrapper, publishPostBtn)
        setUploadImageState()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        headerHStack.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(-10)
        }
        
        headingTextfield.snp.makeConstraints { make in
            make.top.equalTo(headerHStack.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(headingTextfield.snp.bottom).offset(10)
            make.leading.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        descriptionTextview.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        uploadImageViewWrapper.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextview.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        publishPostBtn.snp.makeConstraints { make in
            make.top.equalTo(uploadImageViewWrapper.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        descriptionTextview.delegate = self
        headingTextfield.delegate = self
        closeButton.addTarget(viewModel, action: #selector(viewModel.closeBtnTapped), for: .touchUpInside)
        publishPostBtn.addTarget(viewModel, action: #selector(viewModel.publishPostBtnTapped), for: .touchUpInside)
    }
    
    @objc func clearImageBtnTapped() {
        setUploadImageState()
    }
    
    func setUploadImageState() {
        self.uploadImageViewWrapper.removeSubviews()
        self.uploadedImageView = nil
        self.viewModel.imageData = nil
        self.uploadImageView = UploadImageView()
        self.uploadImageViewWrapper.addArrangedSubviews(uploadImageView!)
        self.uploadImageView!.uploadButton.addTarget(self, action: #selector(uploadImageBtnTapped), for: .touchUpInside)
    }
    
    func setUploadedImageState(with image: UIImage) {
        uploadImageViewWrapper.removeSubviews()
        self.uploadImageView = nil
        self.uploadedImageView = UploadedImageView()
        self.uploadedImageView!.imageView.image = image
        self.viewModel.imageData = image.jpegData(compressionQuality: 0.5)
        uploadImageViewWrapper.addArrangedSubviews(uploadedImageView!)
        uploadedImageView!.closeButton.addTarget(self, action: #selector(clearImageBtnTapped), for: .touchUpInside)
    }
    
   
    
    @objc private func uploadImageBtnTapped(_ button: UIButton) {
        let chooseFromLibraryAction = UIAction(title: "Медиатека") { action in
            self.viewModel.chooseFromLibrary()
        }
        
        let takPhotoOrVideoAction = UIAction(title: "Снять фото или видео") { action in
            self.viewModel.takePhotoOrVideo()
        }
        
        let ChooseFileAction = UIAction(title: "Выбор файлов") { action in
            self.viewModel.chooseFile()
        }
        
        let menu = UIMenu(children: [chooseFromLibraryAction, takPhotoOrVideoAction, ChooseFileAction])
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }
}

//MARK: UITextViewDelegate
extension AddPostScreenRootView: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == R.color.gray_color_2() {
            textView.text = nil
            textView.textColor = R.color.gray_color_1()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Описание"
            textView.textColor = R.color.gray_color_2()
        } else {
            viewModel.description = textView.text
        }
    }
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension AddPostScreenRootView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let item = viewModel.categories[indexPath.item]
        let makeCategoryBtn = makeCategoryButton()
        makeCategoryBtn.setTitle(item.name, for: .normal)
        makeCategoryBtn.isEnabled = item.active
        if item.active {
            viewModel.selectedCategory = item.id
        }
        cell.contentView.addSubviews(makeCategoryBtn)
        makeCategoryBtn.snp.makeConstraints { $0.edges.equalToSuperview()  }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.activateCategorFor(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let btn = makeCategoryButton()
        btn.setTitle(viewModel.categories[indexPath.item].name, for: .normal)
        btn.sizeToFit()
        return .init(width: btn.frame.width + 10, height: btn.frame.height)
    }
}

//MARK: Bindings
extension AddPostScreenRootView {
    func bindViewToViewModel() {
        headingTextfield
            .publisher(for: \.text)
            .receive(on: DispatchQueue.main)
            .map { $0 ?? "" }
            .assign(to: \.heading, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToView() {
        viewModel
            .$publishBtnEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: publishPostBtn)
            .store(in: &subscriptions)
        
        viewModel
            .$categories
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.collectionView.reloadData()
            }.store(in: &subscriptions)
        
        viewModel
            .$clearForm
            .receive(on: DispatchQueue.main)
            .sink {[weak self] clean in
                guard let self, clean else { return }
                headingTextfield.text = nil
                descriptionTextview.text = "Описание"
                descriptionTextview.textColor = R.color.gray_color_2()
                viewModel.setDefaultSelectedCategory()
                setUploadImageState()
            }.store(in: &subscriptions)
    }
}
