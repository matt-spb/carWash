//
//  EditComentVCViewController.swift
//  Carwash
//
//  Created by matt_spb on 09.02.2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import UIKit

protocol EditComentDelegate: class {
    func editViewControllerDidShow()
    func editViewControllerDidDisapear()
    func editViewControllerDidSave(comment: Comment)
}

class EditComentVC: UIViewController {
    
    let saveButton = UIButton()
    let nameLabel = UILabel()
    let commentTextView = UITextView()
    
    var comment: Comment?
    
    weak var delegate: EditComentDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupLayouts()
        configureLabel()
        configureTextView()
        configureButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.editViewControllerDidShow()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.editViewControllerDidDisapear()
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    convenience init(comment: Comment) {
        self.init()
        self.comment = comment
    }
    
    
    private func setupLayouts() {
        
        // MARK: - Setup Label
        self.view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])

        // MARK: - Setup textView
        self.view.addSubview(commentTextView)
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            commentTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            commentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // MARK: - Setup Button
        self.view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func configureLabel() {
        nameLabel.textAlignment = .center
        nameLabel.font          = UIFont.systemFont(ofSize: 25, weight: .bold)
        nameLabel.text          = comment?.name ?? "Нет данных"
        
    }
    
    // сделать сворачивание клавы по нажатию на return (опционально: по нажатию на вью, дернуть из дринкапа)
    fileprivate func configureTextView() {
        commentTextView.delegate = self
        commentTextView.text = comment?.text ?? "Пусто"
        commentTextView.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        commentTextView.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        commentTextView.returnKeyType = .done
        
        commentTextView.layer.cornerRadius = 10
        commentTextView.layer.borderWidth = 2
        commentTextView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    fileprivate func configureButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .black
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        
    }
    
    @objc func didTapSave() {
        guard var comment = comment else { return }
        comment.text = commentTextView.text
        
        delegate?.editViewControllerDidSave(comment: comment)
        self.dismiss(animated: true, completion: nil)
    }
}


extension EditComentVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentTextView.becomeFirstResponder()
    }

    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            view.endEditing(true)
            didTapSave()
        }
        return true
    }
}
