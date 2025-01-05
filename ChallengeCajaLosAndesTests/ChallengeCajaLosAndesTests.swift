//
//  ChallengeCajaLosAndesTests.swift
//  ChallengeCajaLosAndesTests
//
//  Created by Oswaldo Escobar on 3/01/25.
//
import XCTest
@testable import ChallengeCajaLosAndes

final class ChallengeCajaLosAndesTests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        return false
    }
    
    // MARK: - API ACCOUNT
    func testFetchAccount_Success() {
        let expectation = self.expectation(description: "FetchAccount should succeed")
        UtilsAPI.baseURLMoock = "https://1e56283e-0ce5-4d4b-a21f-de829f523fd9.mock.pstmn.io"
        APIProductosDetalleRequest.fetchAccount(isFirstCall: false) { result in
            switch result {
            case .success(let cuentaResponse):
                XCTAssertEqual(cuentaResponse.cuenta.tipo, "Cuenta soles", "El tipo de cuenta no coincide")
                XCTAssertEqual(cuentaResponse.movimientos.first?.descripcion, "Transferencia", "La descripción del primer movimiento no es la esperada")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Se recibió un error inesperado: \(error)")
            }
        }
        waitForExpectations(timeout: 200)
    }
    
    func testFetchAccount_Failure() {
        let expectation = self.expectation(description: "FetchAccount should fail")
        UtilsAPI.baseURLMoock = "https://mockurl.com"
        
        APIProductosDetalleRequest.fetchAccount(isFirstCall: true) { result in
            switch result {
            case .success:
                XCTFail("Se esperaba un error, pero se recibió una respuesta exitosa")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, NSCocoaErrorDomain, "El dominio del error no coincide con NSURLErrorDomain")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 200)
    }
    
    // MARK: - API GETPRODUCT
    func testFetchCard_Success() {
        let expectation = self.expectation(description: "FetchCard should succeed")
        UtilsAPI.baseURLMoock = "https://1e56283e-0ce5-4d4b-a21f-de829f523fd9.mock.pstmn.io"
        APIProductosRequest.fetchCards(isFirstCall: true) { result in
            switch result {
            case .success(let cards):
                if let cardItem = cards.first?.cardType {
                    XCTAssertEqual(cardItem, "VISA", "El tipo de tarjeta no coincide con VISA")
                    expectation.fulfill()
                } else {
                    XCTFail("La lista de tarjetas está vacía")
                }
            case .failure(let error):
                XCTFail("Se recibió un error inesperado: \(error)")
            }
        }
        
        waitForExpectations(timeout: 200)
    }
    
    func testFetchCard_Failure() {
        let expectation = self.expectation(description: "FetchCard should fail")
        UtilsAPI.baseURLMoock = "https://mockurl.com"
        APIProductosRequest.fetchCards(isFirstCall: true) { result in
            switch result {
            case .success:
                XCTFail("Se esperaba un error, pero se recibió una respuesta exitosa")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, NSCocoaErrorDomain, "El dominio del error no coincide con NSURLErrorDomain")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 200)
    }
    
    // MARK: - API GETPRODUCT
    func testLogin_Success() {
        let expectation = self.expectation(description: "FetchLogin should succeed")
        let request = APILoginRequest.createLoginRequest(usuario: "usuario", contrasena: "contrasena")
        
        APILoginRequest.callServiceLogin(request: request) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let errorResponse):
                XCTFail("Se recibió un error inesperado: \(errorResponse)")
            }
        }
        
        waitForExpectations(timeout: 200)
    }
    
    func testLogin_Failure() {
        let expectation = self.expectation(description: "FetchLogin should fail")
        let request = APILoginRequest.createLoginRequest(usuario: "a", contrasena: "contrasena")
        
        APILoginRequest.callServiceLogin(request: request) { result in
            switch result {
            case .success:
                XCTFail("Se esperaba un error, pero se recibió una respuesta exitosa")
            case .failure:
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 200)
    }
}

