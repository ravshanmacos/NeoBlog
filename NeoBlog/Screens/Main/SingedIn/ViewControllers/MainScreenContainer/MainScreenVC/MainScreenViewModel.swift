//
//  MainScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Combine

enum MainScreenViewState {
    case initial
    case dissmiss
    case filterByDate
    case filterByPeriod
    case addPostToCollection(savedCollectionID: Int?, postID: Int)
}

class MainScreenViewModel {
    
    //MARK: Properties
    
    @Published private(set) var view: MainScreenViewState = .initial
    @Published private(set) var blogPostList: [BlogPost] = []
    
    private let goToPostDetailsNavigator: GoToPostDetailsNavigator
    
    private let userProfile: UserProfile
    private let postRepository: PostRepository
    
    //MARK: Methods
    
    init(userProfile: UserProfile,
         postRepository: PostRepository,
         goToPostDetailsNavigator: GoToPostDetailsNavigator) {
        self.userProfile = userProfile
        self.postRepository = postRepository
        self.goToPostDetailsNavigator = goToPostDetailsNavigator
        print(userProfile)
    }
    
    func navigateToPostDetails(with postID: Int) {
        goToPostDetailsNavigator.navigateToPostDetails(postID: postID)
    }
    
    //Search
    func search(with text: String?) {
        getBlogPostList(query: text ?? "")
    }
    
    // Filter by category
    func filterByCategory(item: CategoryItem) {
        let title = item.title == "Все" ? "" : item.title
        getBlogPostList(categoryName: title)
    }
    
  //MARK: Sheets
    
    //Filter By Date
    func openFilterByDate() {
        view = .filterByDate
    }
    
    // Filter By Category
    func openFilterByPeriod() {
        view = .filterByPeriod
    }
    
    //Post Collection Sheet
    func openPostCollectionSheet(collectionID: Int?, postID: Int) {
        view = .addPostToCollection(savedCollectionID: collectionID, postID: postID)
    }
}

extension MainScreenViewModel: GoToCreateNewPeriodNavigator, NewPeriodCreatedResponder, DateDidSelectedResponder, SortByDateSelectedResponder {
    func sortByDateDidSelected(with tag: Int) {
        let periodStrings = ["За неделю", "За месяц", "За полгода", "Другое"]
        let selectedPeriod = periodStrings[tag]
        var period: (startDate: Date, endDate: Date)?
        switch selectedPeriod {
        case "За неделю":
            period = formatForLastWeek()
        case "За месяц":
            period = formatForMonth(difference: 1)
        case "За полгода":
            period = formatForMonth(difference: 6)
        default:
            break
        }
        guard let period else { return }
        let startPeriod = formatDate(for: period.startDate)
        let endPeriod = formatDate(for: period.endDate)
        getBlogPostList(startDate: startPeriod, endDate: endPeriod)
        view = .dissmiss
    }
    
    func datePeriodSelected(startDate: Date, endDate: Date) {
        let startDateFormatted = formatDate(for: startDate)
        let endDateFormatted = formatDate(for: endDate)
        getBlogPostList(startDate: startDateFormatted, endDate: endDateFormatted)
        view = .dissmiss
    }
    
    func navigateToCreateNewPeriod() {
        view = .filterByPeriod
    }
    
    func newPeriodCreated() {
        print("New period created")
    }
}

extension MainScreenViewModel {
    func getBlogPostList(categoryName: String = "", query: String = "", startDate: String = "", endDate: String = "") {
        postRepository
            .getBlogPostList(categoryName: categoryName, query: query, startDate: startDate, endDate: endDate)
            .done({ blogList in
                self.blogPostList = blogList
            })
            .catch { error in
                print(error)
            }
    }
}

private extension MainScreenViewModel {
    func formatDate(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func formatForLastWeek() -> (startDate: Date, endDate: Date)? {
        let currentDate = Date()
        let calendar = Calendar.current
        var oneWeekBeforeComponents = DateComponents()
        oneWeekBeforeComponents.day = -7
        
        // Calculate the date one week before
        guard let oneWeekBefore = calendar.date(byAdding: oneWeekBeforeComponents, to: currentDate) else { return nil }
        return (startDate: oneWeekBefore, endDate: currentDate)
    }
    
    func formatForMonth(difference: Int) -> (startDate: Date, endDate: Date)? {
        let currentDate = Date()
        let calendar = Calendar.current
        var oneMonthBeforeComponents = DateComponents()
        oneMonthBeforeComponents.month = -1 * difference
        
        // Calculate the date one week before
        guard let oneMonthBefore = calendar.date(byAdding: oneMonthBeforeComponents, to: currentDate) else { return nil }
        return (startDate: oneMonthBefore, endDate: currentDate)
    }
}
