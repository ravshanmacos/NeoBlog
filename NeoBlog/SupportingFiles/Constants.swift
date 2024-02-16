//
//  Constants.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 16/02/24.
//

import Foundation

struct Constants {
    struct String {
        
        //Warnings
        static let confirPasswordWarning = "Пароли должны совпадать"
        
        static let usernameWarning = "От 6 до 20 символов. Используйте английские буквы, цифры и спецсимволы (!, #, $ и т.д.)"
        
        static let passwordWarning = "Минимум 8 символов, включая одну заглавную букву и один спецсимвол (!, #, $ и т.д.)"
        
        //Errors
        static let invalidEmail = "Неверный формат"
        static let invalidConfirmPassword = "Пароли не совпадают"
    }
}
