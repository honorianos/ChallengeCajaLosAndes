//
//  ProductoDetalleViewController.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 4/01/25.
//
import Foundation
import UIKit
import JGProgressHUD
import Kingfisher

class ProductoDetalleViewController: TokenTimerViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var numberAccountTextfield: UITextField!
    
    @IBOutlet weak var pinAccountTextfield: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noMovementsLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    private let presenter = ProductoDetallePresenter()
    private let loader = JGProgressHUD(style: .light)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTokenTimer()
    }
    
    var movimientos = [CuentaResponse.Movimiento]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setViewDelegate(delegate: self)
        setupLayout()
        obtenerMovimientos()
    }
    
    private func setupNavigationConf() {
        view.backgroundColor = .white
        title = "Detalle del Producto"
    }
    
    private func setupLayout() {
        tableView.register(MovimientoCell.self, forCellReuseIdentifier: "MovimientoCell")
        tableView.rowHeight = 70
        refreshControl.addTarget(self, action: #selector(refreshMovimientos), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshMovimientos() {
        obtenerMovimientos(isFirstCall: false)
    }
    
    private func obtenerMovimientos(isFirstCall: Bool = true) {
        self.showLoader(show: true)
        self.movimientos.removeAll()
        resetTokenTimer()
        self.presenter.callAccount(isFirstCall: isFirstCall)
    }

    @IBAction func didTapSharedAccount(_ sender: Any) {
        if let numeroCuenta = numberAccountTextfield.text, !numeroCuenta.isEmpty {
            let mensaje = "Hola, te comparto mi número de cuenta: \(numeroCuenta)"
            let urlWhats = "whatsapp://send?text=\(mensaje)"
            
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                } else {
                    let activityViewController = UIActivityViewController(activityItems: [mensaje], applicationActivities: nil)
                    present(activityViewController, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "No hay número de cuenta para compartir.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movimientos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovimientoCell", for: indexPath) as! MovimientoCell
        let movimiento = movimientos[indexPath.row]
        cell.configure(with: movimiento)
        return cell
    }
}

extension ProductoDetalleViewController: ProductoDetailPresenterDelegate {
   
    func showLoader(show: Bool) {
        if show {
            self.loader.show(in: self.view)
        }
        else {
            self.loader.dismiss()
        }
    }
    
    func successResponse(account: CuentaResponse) {
        self.showLoader(show: false)
        if account.movimientos.count > 0 {
            noMovementsLabel.isHidden = true
        }
        else {
            noMovementsLabel.isHidden = false
        }
       
        if let url = URL(string: account.cuenta.urlImage) {
            let placeholder = UIImage(named: "imagenSplas")
            cardImage.kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: nil) { result in
                switch result {
                case .success:
                    print("Imagen cargada correctamente.")
                case .failure(let error):
                    print("Error al cargar la imagen: \(error.localizedDescription)")
                }
            }
        } else {
            cardImage.image = UIImage(named: "imagenSplas")
        }
        
        numberAccountTextfield.text = account.cuenta.numeroCuenta
        pinAccountTextfield.text = account.cuenta.pin
        
        self.movimientos = account.movimientos
        tableView.reloadData()
        refreshControl.endRefreshing()
       
    }
}
