//
//  ProductosViewController.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 4/01/25.
//

import UIKit
import Foundation
import JGProgressHUD

class ProductosViewController: TokenTimerViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tittleLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    var productos: [String] = []
    private let presenter = ProductosPresenter()
    private let loader = JGProgressHUD(style: .light)

    private var selectedCard = 0
    private var cards = [Card]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetTokenTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        setupNavigationTitle()
        setupTableView()
        configTable()
        loadData()
    }
    
    private func configTable() {
        tableView.register(UINib(nibName: "ProductCell", bundle: Bundle.main), forCellReuseIdentifier: "ProductCell")
    }
    
    private func setupNavigationTitle() {
        tittleLabel.text = "Productos"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .white
    }
    
    func loadData(isFirstCall: Bool = true) {
        cards.removeAll()
        presenter.callProducts(isFirstCall: isFirstCall)
    }
    
    func refreshTableView() {
        tableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        refreshControl.addTarget(self, action: #selector(refreshProductos), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func refreshProductos() {
        resetTokenTimer()
        loadData(isFirstCall: false)
    }
    
}

extension ProductosViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.bindData(data: cards[indexPath.row])
        cell.setCell(isSelected: (selectedCard == indexPath.row))
        return cell
    }
}

extension ProductosViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 1
        
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 220
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCard = indexPath.row
        let vc = ProductoDetalleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: .none)
    }
    
}

extension ProductosViewController: ProductosPresenterDelegate {
    
    func showLoader(show: Bool) {
        if show {
            self.loader.show(in: self.view)
        }
        else {
            self.loader.dismiss()
        }
    }
    
    func successResponse(array: [Card]) {
        self.showLoader(show: false)
        self.cards = array
        self.refreshTableView()
        refreshControl.endRefreshing()
    }
    
}
