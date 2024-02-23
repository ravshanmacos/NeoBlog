//
//  Constants.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 16/02/24.
//

import UIKit

struct Constants {
    struct Strings {
        
        //Warnings
        static let confirPasswordWarning = "Пароли должны совпадать"
        
        static let usernameWarning = "От 6 до 20 символов. Используйте английские буквы, цифры и спецсимволы (!, #, $ и т.д.)"
        
        static let passwordWarning = "Минимум 8 символов, включая одну заглавную букву и один спецсимвол (!, #, $ и т.д.)"
        
        //Errors
        static let invalidEmail = "Неверный формат"
        static let invalidConfirmPassword = "Пароли не совпадают"
        
        enum TabBar {
            static func title(for tab: Tabs) -> String {
                switch tab {
                case .firstTab: return "Главная"
                //case .secondTab: return "Создать пост"
                //case .thirdTab: return "Профиль"
                }
            }
        }
    }
    
    enum Images {
        enum TabBar {
            static func imageActive(for tab: Tabs) -> UIImage? {
                switch tab {
                case .firstTab: return R.image.home_tab_active_icon()
                //case .secondTab: return R.image.plus_tab_icon()
                //case .thirdTab: return R.image.profile_tab_active_icon()
                }
            }
            
            static func image(for tab: Tabs) -> UIImage? {
                switch tab {
                case .firstTab: return R.image.home_tab_inactive_icon()
                //case .secondTab: return R.image.plus_tab_icon()
                //case .thirdTab: return R.image.profile_tab_inactive_icon()
                }
            }
        }
    }
}
