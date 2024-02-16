//
//  UIViewController+ErrorExt.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

extension UIViewController {

  // MARK: - Methods
//  public func present(errorMessage: ErrorMessage) {
//    let errorAlertController = UIAlertController(title: errorMessage.title,
//                                                 message: errorMessage.message,
//                                                 preferredStyle: .alert)
//    let okAction = UIAlertAction(title: "OK", style: .default)
//    errorAlertController.addAction(okAction)
//    present(errorAlertController, animated: true, completion: nil)
//  }
//
//  public func present(errorMessage: ErrorMessage,
//                      withPresentationState errorPresentation: PassthroughSubject<ErrorPresentation?, Never>) {
//    errorPresentation.send(.presenting)
//    let errorAlertController = UIAlertController(title: errorMessage.title,
//                                                 message: errorMessage.message,
//                                                 preferredStyle: .alert)
//    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//      errorPresentation.send(.dismissed)
//      errorPresentation.send(nil)
//    }
//    errorAlertController.addAction(okAction)
//    present(errorAlertController, animated: true, completion: nil)
//    
//  }
}
