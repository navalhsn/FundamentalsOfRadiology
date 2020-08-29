//
//  ViewController+MFSDKServicesCall.swift
//  MFSDKDemo-Swift
//
//  Created by Elsayed Hussein on 8/29/19.
//  Copyright © 2019 Elsayed Hussein. All rights reserved.
//

//import MFSDK

//extension ViewController {
//    func initiatePayment() {
//        let request = generateInitiatePaymentModel()
//        startLoading()
//        MFPaymentRequest.shared.initiatePayment(request: request, apiLanguage: .english, completion: { [weak self] (result) in
//            self?.stopLoading()
//            switch result {
//            case .success(let initiatePaymentResponse):
//                self?.paymentMethods = initiatePaymentResponse.paymentMethods
//                self?.collectionView.reloadData()
//            case .failure(let failError):
//                self?.showFailError(failError)
//            }
//        })
//    }
//    
//    func executeDirectPayment(paymentMethodId: Int) {
//        let request = getExecutePaymentRequest(paymentMethodId: paymentMethodId)
//        let card = getCardInfo()
//        startLoading()
//        MFPaymentRequest.shared.executeDirectPayment(request: request, cardInfo: card, apiLanguage: .english) { [weak self] (response, invocieId) in
//            self?.stopLoading()
//            switch response {
//            case .success(let directPaymentResponse):
//                if let cardInfoResponse = directPaymentResponse.cardInfoResponse, let card = cardInfoResponse.cardInfo {
//                    self?.resultTextView.text = "Status: with card number: \(card.number)"
//                }
//                if let invocieId = invocieId {
//                    self?.errorcodeLabel.text = "Success with invocie id \(invocieId)"
//                } else {
//                    self?.errorcodeLabel.text = "Success"
//                }
//            case .failure(let failError):
//                self?.resultTextView.text = "Error: \(failError.errorDescription)"
//                if let invocieId = invocieId {
//                    self?.errorcodeLabel.text = "Fail: \(failError.statusCode) with invocie id \(invocieId)"
//                } else {
//                    self?.errorcodeLabel.text = "Fail: \(failError.statusCode)"
//                }
//            }
//        }
//    }
//    
//    func executePayment(paymentMethodId: Int) {
//        let request = getExecutePaymentRequest(paymentMethodId: paymentMethodId)
//        startLoading()
//        MFPaymentRequest.shared.executePayment(request: request, apiLanguage: .english) { [weak self] response, invocieId  in
//            self?.stopLoading()
//            switch response {
//            case .success(let executePaymentResponse):
//                if let invoiceStatus = executePaymentResponse.invoiceStatus {
//                    self?.showSuccess(invoiceStatus)
//                }
//            case .failure(let failError):
//                self?.showFailError(failError)
//            }
//        }
//    }
//    
//    func sendPayment() {
//        let request = getSendPaymentRequest()
//        startSendPaymentLoading()
//        MFPaymentRequest.shared.sendPayment(request: request, apiLanguage: .arabic) { [weak self] (result) in
//            self?.stopSendPaymentLoading()
//            switch result {
//            case .success(let sendPaymentResponse):
//                if let invoiceURL = sendPaymentResponse.invoiceURL {
//                    self?.errorcodeLabel.text = "Success"
//                    self?.resultTextView.text = "result: send this link to your customers \(invoiceURL)"
//                }
//            case .failure(let failError):
//                self?.showFailError(failError)
//            }
//            
//        }
//    }
//}
//extension ViewController {
//    private func generateInitiatePaymentModel() -> MFInitiatePaymentRequest {
//        // you can create initiate payment request with invoice value and cuurecny
//        // let invoiceValue = Double(amountTextField.text ?? "") ?? 0
//        // let request = MFInitiatePaymentRequest(invoiceAmount: invoiceValue, currencyIso: .kuwait_KWD)
//        // return request
//
//        let request = MFInitiatePaymentRequest()
//        return request
//    }
//    private func getCardInfo() -> MFCardInfo {
//        let cardNumber = cardNumberTextField.text ?? ""
//        let cardExepiryMonth = monthTextField.text ?? ""
//        let cardExpiryYear = yearTextField.text ?? ""
//        let cardSeucreCode = secureCodeTextField.text ?? ""
//
//        let card = MFCardInfo(cardNumber: cardNumber, cardExpiryMonth: cardExepiryMonth, cardExpiryYear: cardExpiryYear, cardSecurityCode: cardSeucreCode, saveToken: false)
//        return card
//    }
//    private func getExecutePaymentRequest(paymentMethodId: Int) -> MFExecutePaymentRequest {
//        let invoiceVaue = Double(amountTextField.text ?? "0") ?? 0
//        let request = MFExecutePaymentRequest(invoiceValue: Decimal(invoiceVaue) , paymentMethod: paymentMethodId)
//        //request.userDefinedField = ""
//        request.customerEmail = "a@b.com"// must be email
//        request.customerMobile = ""
//        request.customerCivilId = ""
//        let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
//        request.customerAddress = address
//        request.customerReference = ""
//        request.language = .english
//        request.mobileCountryCode = MFMobileCountryCodeISO.kuwait.rawValue
//
//        //         Uncomment this to add ptoducts for your invoice
//        //        var productList = [MFProduct]()
//        //        let product = MFProduct(name: "ABC", unitPrice: 1, quantity: 2)
//        //        productList.append(product)
//        //        request.invoiceItems = productList
//
//        return request
//    }
//
//    func getSendPaymentRequest() -> MFSendPaymentRequest {
//        let invoiceValue = Double(amountTextField.text ?? "") ?? 0
//        let request = MFSendPaymentRequest(invoiceValue: Decimal(invoiceValue), notificationOption: .all, customerName: "Test")
//
//        // send invoice link as sms to specified number
//        // let request = MFSendPaymentRequest(invoiceValue: invoiceValue, notificationOption: .sms, customerName: "Test")
//        // request.customerMobile  = "" // required here
//
//        // get invoice link
//        // let request = MFSendPaymentRequest(invoiceValue: invoiceValue, notificationOption: .link, customerName: "Test")
//
//        //  send invoice link to email
//        // let request = MFSendPaymentRequest(invoiceValue: invoiceValue, notificationOption: .email, customerName: "Test")
//        // request.customerEmail = "" required here
//
//
//
//        //request.userDefinedField = ""
//        request.customerEmail = "a@b.com"// must be email
//        request.customerMobile = "mobile no"//Required
//        request.customerCivilId = ""
//        request.mobileCountryIsoCode = MFMobileCountryCodeISO.kuwait.rawValue
//        request.customerReference = ""
//        request.language = .english
//        let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
//        request.customerAddress = address
//        request.customerReference = ""
//        request.language = .english
//        let date = Date().addingTimeInterval(1000)
//        request.expiryDate = date
//        return request
//    }
//}
