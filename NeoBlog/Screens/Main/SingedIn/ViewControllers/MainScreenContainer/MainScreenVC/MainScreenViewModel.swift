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

protocol CategoryViewModel {
    var categories: [Category] { get }
    func activateCategorFor(index: Int)
}

class MainScreenViewModel: CategoryViewModel {
    
    //MARK: Properties
    
    @Published private(set) var view: MainScreenViewState = .initial
    @Published private(set) var blogPostList: [BlogPost] = []
    @Published private(set) var categories: [Category] = []
    
    private let goToPostDetailsNavigator: GoToPostDetailsNavigator
    
    private let userProfile: UserProfile
    private let postRepository: PostRepository
    
    var selectedCategory: String?
    
    //MARK: Methods
    
    init(userProfile: UserProfile,
         postRepository: PostRepository,
         goToPostDetailsNavigator: GoToPostDetailsNavigator) {
        self.userProfile = userProfile
        self.postRepository = postRepository
        self.goToPostDetailsNavigator = goToPostDetailsNavigator
        print(userProfile)
        getCategories()
    }
    
    //Search
    func search(with text: String?) {
        getBlogPostList(query: text ?? "")
    }
    
    // Filter by category
    func activateCategorFor(index: Int) {
        for number in 0..<categories.count {
            categories[number].active = false
        }
        
        categories[index].active = true
        if let categoryID = categories[index].id, categoryID == 0 {
            selectedCategory = nil
            getBlogPostList(categoryName: "")
        } else if let categoryName = categories[index].name {
            selectedCategory = categoryName
            getBlogPostList(categoryName: categoryName)
        }
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

//MARK: Navigators and Responders
extension MainScreenViewModel: GoToCreateNewPeriodNavigator, NewPeriodCreatedResponder, DateDidSelectedResponder, SortByDateSelectedResponder {
    func navigateToPostDetails(with postID: Int) {
        goToPostDetailsNavigator.navigateToPostDetails(postID: postID)
    }
    
    func sortByDateDidSelected(with tag: Int) {
        switch tag {
          case 0: getBlogPostList(period: "week")
          case 1: getBlogPostList(period: "month")
          case 2: getBlogPostList(period: "half_year")
          default:
            break
        }
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

//MARK: Networking
extension MainScreenViewModel {
    func getCategories() {
        postRepository
            .getCategoriesList()
            .done({ categories in
                self.categories = categories
                let category = Category(id: 0, name: "Все", active: true)
                self.categories.insert(category, at: 0)
            })
            .catch { error in
                print(error)
            }
    }
    
    func getBlogPostList(categoryName: String = "",
                         query: String = "", startDate:
                         String = "", endDate: String = "",
                         period: String = "") {
        postRepository
            .getBlogPostList(categoryName: categoryName, query: query,
                             startDate: startDate, endDate: endDate,
                             period: period)
            .done({ blogList in
                self.blogPostList = blogList
            })
            .catch { error in
                print(error)
            }
    }
}

//MARK: Helpers
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
