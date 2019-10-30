//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Anthony Gonzalez on 10/29/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

import UserNotifications

class ViewController: UIViewController {
    
    //MARK: -- Properties
    lazy var timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    lazy var messageField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message here..."
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.backgroundColor = #colorLiteral(red: 0.9393832684, green: 0.9337988496, blue: 0.9436758161, alpha: 1)
        return textField
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    lazy var hourLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hours"
        label.textColor = .black
        return label
    }()
    
    lazy var minuteLabel: UILabel = {
        let label = UILabel()
      
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "min"
        label.textColor = .black
        return label
    }()
    
    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "sec"
        label.textColor = .black
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add Timer"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    var hours = Double()
    var minutes = Double()
    var seconds = Double()
    
    //MARK: -- Methods
    
    @objc func addButtonPressed() {
        if messageField.text == "" {
            presentAlert()
        } else {
           MakeNotification.configureNotifications(title: messageField.text!, body: "", time: hours + seconds + minutes)
        }
    }
    
    @objc private func editButtonPressed() {
        let destVC = ManageViewController()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    private func presentAlert(){
        let alert = UIAlertController(title: nil, message: "You must enter a message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sry daddy :(", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func addSubviews() {
        [timePicker, messageField, addButton, hourLabel, minuteLabel, secondLabel,titleLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        let UIElements = [timePicker, messageField, addButton, titleLabel, hourLabel, minuteLabel, secondLabel]
        for UIElement in UIElements {
            view.addSubview(UIElement)
        }
    }
    
    //MARK: -- Constraints
    private func setConstraints() {
        setTextFieldConstraints()
        setDatePickerConstraints()
        setButtonConstraints()
        setTitleTextConstraints()
        setTimeLabelConstraints()
    }
    
    private func setTitleTextConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setTextFieldConstraints() {
        NSLayoutConstraint.activate([
            messageField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            messageField.widthAnchor.constraint(equalToConstant: 300),
            messageField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setDatePickerConstraints() {
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: messageField.bottomAnchor, constant: 30),
            timePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setButtonConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 75),
            addButton.centerXAnchor.constraint(equalTo: timePicker.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 350),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.centerXAnchor.constraint(equalTo: timePicker.centerXAnchor, constant: -65),
            hourLabel.centerYAnchor.constraint(equalTo: timePicker.centerYAnchor),
            
            minuteLabel.centerXAnchor.constraint(equalTo: timePicker.centerXAnchor, constant: 40),
            minuteLabel.centerYAnchor.constraint(equalTo: timePicker.centerYAnchor),
            
            secondLabel.centerXAnchor.constraint(equalTo: timePicker.centerXAnchor, constant: 150),
            secondLabel.centerYAnchor.constraint(equalTo: timePicker.centerYAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.963120997, blue: 0.9150300026, alpha: 1)
        addSubviews()
        setConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
    }
}

//MARK: -- PickerView Extension
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return 25
            
        case 1,2: return 60
            
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hours = Double(row) * 3600
        case 1:
            minutes = Double(row) * 60
        case 2:
            seconds = Double(row)
        default:
            break;
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

