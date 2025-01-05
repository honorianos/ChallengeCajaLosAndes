//
//  HomeTabBarPresenter.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 4/01/25.
//

import Foundation
import UIKit

protocol HomeTabBarPresenterDelegate: AnyObject {
}

typealias PresenterHomeDelegate = HomeTabBarPresenterDelegate & UIViewController

class HomeTabBarPresenter {
    weak var delegate: PresenterHomeDelegate?
    private let utils = Utils()

    public func setViewDelegate(delegate: PresenterHomeDelegate) {
        self.delegate = delegate
    }
    
}
