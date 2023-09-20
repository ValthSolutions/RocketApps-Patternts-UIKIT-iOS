//
//  ViewController.swift
//  Texs
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit
import RocketComponents

class ViewController: UIViewController {
    
    let testButton = BaseButton(type: .system)
    let imageView = UIImageView()
    let baseLabel = BaseLabel()
    let pageControl = BasePageControl()
    let textView = BaseTextView()
    let switcher = BaseToggle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwitcher()
        view.backgroundColor = .gray
    }
}

extension ViewController {
    // MARK: Toggle
    private func setupSwitcher() {
        view.addSubview(switcher)
        switcher.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            switcher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switcher.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            switcher.widthAnchor.constraint(equalToConstant: 50),
            switcher.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        switcher.decorate(with: .init())
    }
    
    // MARK: Page Control
    private func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.numberOfPages = 5
        pageControl.currentPage = 2
        
        pageControl.decorate(with: Skeleton.PageControlStyles.defaultStyle)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: Label

    private func setupLabel() {
        view.addSubview(baseLabel)
        baseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            baseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        baseLabel.decorate(with: Skeleton.LabelStyles.title)
    }
    
    private func setupImageView_With_Blur() {
        imageView.image = UIImage(named: "unsplash")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        let blurredSquare = BaseBlurredView(effect: .light)
        view.addSubview(blurredSquare)
        
        blurredSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurredSquare.widthAnchor.constraint(equalToConstant: 300),
            blurredSquare.heightAnchor.constraint(equalToConstant: 300),
            blurredSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurredSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: BUTTON
extension ViewController {
    private func setup1stButton() {
        setupConstraints()
        testButton.setTitle("Test Button", for: .normal)

        testButton.decorate(with: Skeleton.ButtonStyles.primary)
    }
    
    private func setup2ndButton() {
        setupConstraints()
        testButton.setTitle("Test Button", for: .normal)
        
        testButton.decorate(with: Skeleton.ButtonStyles.secondary)
    }
    
    private func setupConstraints() {
        view.addSubview(testButton)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testButton.widthAnchor.constraint(equalToConstant: 200),
            testButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
