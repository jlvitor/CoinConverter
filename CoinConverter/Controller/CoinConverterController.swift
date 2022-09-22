//
//  CoinConverterController.swift
//  CoinConverter
//
//  Created by Jean Lucas Vitor on 18/09/22.
//

import UIKit
import iOSDropDown

class CoinConverterController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var valueTextField: UITextField!
    @IBOutlet private weak var dropDownTo: DropDown!
    @IBOutlet private weak var dropDownFrom: DropDown!
    @IBOutlet private weak var convertedValueLabel: UILabel!
    @IBOutlet private weak var showHistoryButton: UIButton!
    
    private var viewModel: CoinConverterViewModel = .init()
    private var coinUsed: Coin?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configDropDown()
        showHistoryButton.isHidden = viewModel.getHistoryExchange().count <= 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let coin = viewModel.coinHistory {
            dropDownTo.text = coin.code
            dropDownFrom.text = coin.codein
            valueTextField.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CoinConvertTableViewController {
            controller.viewModel = self.viewModel
        }
    }
    
    //MARK: - Private methods
    @IBAction private func converterButtonAction(_ sender: UIButton) {
        let error: String = validateFields()
        
        if error != String.empty() {
            self.view.showAlert(view: self, message: error)
        } else {
            let param1 = dropDownTo.text!
            let param2 = dropDownFrom.text!
            let param: String = "\(param1)-\(param2)"
            getCoins(param: param)
        }
    }
    
    @IBAction private func saveHistoryButtonAction(_ sender: UIButton) {
        let error: String = validateFields()
        
        if error != String.empty() {
            self.view.showAlert(view: self, message: error)
        } else {
            if let coin = coinUsed {
                viewModel.saveHistoryExchange(coin: coin) { message in
                    self.view.showAlert(view: self, message: message)
                }
            } else {
                self.view.showAlert(view: self, message: "Você precisa fazer a conversão primeiro, para depois salvar!")
            }
        }
        showHistoryButton.isHidden = viewModel.getHistoryExchange().count <= 0
    }
    
    @IBAction func showHistoryButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "history", sender: nil)
    }
    
    private func validateFields() -> String {
        var error: String = String.empty()
        
        if valueTextField.text == String.empty() {
            error = "Informe um valor a ser convertido"
        } else if dropDownTo.text == String.empty() || dropDownFrom.text == String.empty() {
            error = "Selecione as moedas a serem convertidas"
        } else if dropDownTo.text == dropDownFrom.text {
            error = "Selecione moedas diferentes"
        }
        return error
    }
    
    private func configDropDown() {
        dropDownTo.optionArray = viewModel.getCoinList()
        dropDownTo.arrowSize = 10
        dropDownTo.selectedRowColor = .gray
        
        dropDownFrom.optionArray = viewModel.getCoinList()
        dropDownFrom.arrowSize = 10
        dropDownFrom.selectedRowColor = .gray
    }
    
    private func getCoins(param: String) {
        viewModel.getCoins(with: param) { data, error in
            if let coins = data {
                DispatchQueue.main.async {
                    self.coinUsed = coins.first!.value
                    let value: NSNumber = self.viewModel.calculateCoins(
                        valueInfo: self.valueTextField.text,
                        valueCoin: self.coinUsed?.buyValue)
                    self.convertedValueLabel.text = "\(self.dropDownFrom.text!) \(value)"
                }
            }
        }
    }
}
