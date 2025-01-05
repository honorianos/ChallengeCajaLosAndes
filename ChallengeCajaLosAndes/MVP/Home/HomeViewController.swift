import UIKit
import Foundation

class HomeTabBarController: UITabBarController, HomeTabBarPresenterDelegate {
    private let presenter = HomeTabBarPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        let productosVC = ProductosViewController()
        productosVC.tabBarItem = UITabBarItem(title: "Productos", image: UIImage(systemName: "list.bullet"), tag: 0)
        viewControllers = [productosVC]
    }
}
