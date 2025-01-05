//
//  MovimientoCell.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 4/01/25.
//

import Foundation
import UIKit

class MovimientoCell: UITableViewCell {
    
    let descripcionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fechaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let montoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(descripcionLabel)
        contentView.addSubview(fechaLabel)
        contentView.addSubview(montoLabel)
        
        NSLayoutConstraint.activate([
            descripcionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            descripcionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            fechaLabel.topAnchor.constraint(equalTo: descripcionLabel.bottomAnchor, constant: 4),
            fechaLabel.leadingAnchor.constraint(equalTo: descripcionLabel.leadingAnchor),
            fechaLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            montoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            montoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with movimiento: CuentaResponse.Movimiento) {
        descripcionLabel.text = movimiento.descripcion
        fechaLabel.text = movimiento.fecha
        montoLabel.text = "\(movimiento.moneda) \(movimiento.monto)"
        
        if movimiento.tipo == "egreso" {
            montoLabel.textColor = .red
        } else {
            montoLabel.textColor = .systemGreen
        }
    }
}
