//
//  UIViewController-Extensions.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/14/20.
//

import UIKit

extension UIViewController {
    
    static let plusImage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy, scale: .large))?.withTintColor(.darkBlue)
    
    func setupNavigationMenuStyle() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .navigationBarColor
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "DIN Condensed", size: 32)!]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "DIN Condensed", size: 32)!]
        
        addMenuButton()
    }
    
    func setupNavigationStyle() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .navigationBarColor
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "DIN Condensed", size: 32)!]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "DIN Condensed", size: 32)!]
    }
    
    func addMenuButton() {
        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy, scale: .large))?.withTintColor(.darkBlue)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(menuHandler))
    }
    
    func setupPlusIcon(_ selector: Selector) {
        let add = UIImage(systemName: "plus")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: selector)
    }
    
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal(){
        dismiss(animated: true, completion: nil)
    }
    
    static var menuOpen : Bool = false
    
    static var superView : UIView = {
        let view = UIView()
//        view.backgroundColor = .darkBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    static var menuView : UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
//    static var assetView : UITableView = {
//        let v = UITableView()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        return v
//    }()
    
    static var menuTable: MenuTableVC!
    
    func openMenu() {
        
        print(UIViewController.menuOpen)
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        let closeMenuGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        
        if UIViewController.menuOpen == false {
            UIViewController.menuOpen = true
            view.addSubview(UIViewController.menuTable.tableView)
            UIViewController.menuTable.tableView.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!).isActive = true
            UIViewController.menuTable.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            UIViewController.menuTable.tableView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.45).isActive = true
            UIViewController.menuTable.tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            
            UIViewController.superView.addGestureRecognizer(closeMenuGestureRecognizer)
//            navigationController?.navigationBar.addGestureRecognizer(closeMenuGestureRecognizer)
            
            view.addSubview(UIViewController.superView)
            UIViewController.superView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            UIViewController.superView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            UIViewController.superView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: self.view.frame.width * 0.45).isActive = true
            UIViewController.superView.leftAnchor.constraint(equalTo: UIViewController.menuTable.tableView.rightAnchor).isActive = true
        }
        else {
            UIViewController.menuOpen = false
            UIViewController.menuTable.tableView.removeFromSuperview()
            UIViewController.superView.gestureRecognizers?.forEach(UIViewController.superView.removeGestureRecognizer)
//            navigationController?.navigationBar?.gestureRecognizers?.forEach(navigationController?.navigationBar.removeGestureRecognizer)
            
            view.addSubview(UIViewController.superView)
            UIViewController.superView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            UIViewController.superView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            UIViewController.superView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            UIViewController.superView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        }
        
    }
    
    
    @objc func closeMenu() {
        print("Chose")
        openMenu()
    }
    
    @objc func menuHandler() {
        print("Chosen")
        openMenu()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func addKeyboardToolbar(cancel: Selector, done: Selector) -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.barStyle = .default
        toolbar.barTintColor = .black
        toolbar.backgroundColor = .white
        toolbar.isTranslucent = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: cancel)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: done)
        doneButton.tintColor = UIColor.white
        
        toolbar.items = [cancelButton, flexSpace, doneButton]
        
        return toolbar
    }
}

// MARK: - UIView Functions
extension UIViewController {
    
    func createDivider(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    
    func createLabel(string: String, font: UIFont!, color: UIColor, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = string
        label.font = font
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = alignment
        return label
    }
    
    func createButton(image: UIImage, target: Any?, action: Selector, event: UIControl.Event) -> UIButton {
        let button = UIButton();
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: event)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func createCurrencyField(placeholder: String, font: UIFont!, alignment: NSTextAlignment) -> CurrencyField {
        let field = CurrencyField();
        field.awakeFromNib();
        field.placeholder = placeholder
        field.font = font;
        field.textAlignment = alignment;
        field.translatesAutoresizingMaskIntoConstraints = false;
        return field
    }
    
    func createTextField(placeholder: String, font: UIFont!, alignment: NSTextAlignment, color: UIColor) -> UITextField {
        let field = UITextField();
        field.awakeFromNib();
        field.placeholder = placeholder
        field.textColor = color
        field.attributedPlaceholder = .init(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        field.font = font;
        field.textAlignment = alignment;
        field.translatesAutoresizingMaskIntoConstraints = false;
        return field
    }
    
    func createView (superView: UIView,
        top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, topC: CGFloat? = nil, marginTopActive: Bool,
        right: NSLayoutXAxisAnchor? = nil, rightC: CGFloat? = nil, trailingActive: Bool,
        left: NSLayoutXAxisAnchor? = nil, leftC: CGFloat? = nil, leadingActive: Bool,
        bot: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, botC: CGFloat? = nil, marginBotActive: Bool, botActive: Bool,
        height: CGFloat? = nil, heightActive: Bool,
        viewColor: UIColor, shadowRadius: CGFloat, cornerRadius: CGFloat,
        borderWidth: CGFloat , borderColor: CGColor) -> DesignableView {
//        let guide = self.view.safeAreaLayoutGuide
//        let leftAnchor = safeAreaLayoutGuide.leftAnchor
        
        
        let backgroundView : DesignableView = {
            let view = DesignableView()
            view.backgroundColor = viewColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.insetsLayoutMarginsFromSafeArea = true
            view.layer.cornerRadius = cornerRadius / 2
            view.layer.shadowRadius = shadowRadius
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = borderColor
            return view
        }()
        
        superView.addSubview(backgroundView)
        let margins = superView.layoutMarginsGuide
        
        if trailingActive == true {
            backgroundView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        }
        else if trailingActive == false {
            backgroundView.rightAnchor.constraint(equalTo: right!, constant: rightC!).isActive = true
        }
        
        if leadingActive == true {
            backgroundView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        }
        else if leadingActive == false {
            backgroundView.leftAnchor.constraint(equalTo: left!, constant: leftC!).isActive = true
        }
        
        if marginTopActive == true {
            backgroundView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        }
        else if marginTopActive == false {
            backgroundView.topAnchor.constraint(equalTo: top!, constant: topC!).isActive = true
        }
        
        if marginBotActive == true {
            backgroundView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        }
        if botActive == true {
            backgroundView.bottomAnchor.constraint(equalTo: bot!, constant: botC!).isActive = true
        }
        if heightActive == true {
            backgroundView.heightAnchor.constraint(equalToConstant: height!).isActive = true
        }
       
        return backgroundView
        
    }
}

// MARK: - Contstraint Functions
extension UIViewController {
    func setMarginC(subView: UIView, superView: UIView, margin: UILayoutGuide, heightC: CGFloat, C: CGFloat, top: Bool) {
        
        if top == true {
            subView.topAnchor.constraint(equalTo: superView.topAnchor, constant: C ).isActive = true
        }
        else if top == false {
            subView.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: C ).isActive = true
        }
        subView.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        subView.heightAnchor.constraint(equalToConstant: heightC).isActive = true
    }
    
    func setLC(subView: UIView, superView: UIView, margin: UILayoutGuide, heightC: CGFloat, C: CGFloat, widthC: CGFloat? = nil, top: Bool, width: Bool) {
        if top == true {
            subView.topAnchor.constraint(equalTo: superView.topAnchor, constant: C ).isActive = true
        }
        else if top == false {
            subView.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: C ).isActive = true
        }
        subView.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        
        if width == true {
            subView.widthAnchor.constraint(equalToConstant: widthC!).isActive = true
        }
        else if width == false {
            subView.rightAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        }
        subView.heightAnchor.constraint(equalToConstant: heightC).isActive = true
    }
    
    func setRC(subView: UIView, superView: UIView, margin: UILayoutGuide, heightC: CGFloat, C: CGFloat, widthC: CGFloat? = nil, top: Bool, width: Bool) {
        if top == true {
            subView.topAnchor.constraint(equalTo: superView.topAnchor, constant: C ).isActive = true
        }
        else if top == false {
            subView.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: C ).isActive = true
        }
        subView.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        if width == true {
            subView.widthAnchor.constraint(equalToConstant: widthC!).isActive = true
        }
        else if width == false {
            subView.leftAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        }
        subView.heightAnchor.constraint(equalToConstant: heightC).isActive = true
    }
}

extension UITableViewCell {
    
    func createDivider(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    
    func createLabel(string: String, font: UIFont!, color: UIColor, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = string
        label.font = font
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = alignment
        return label
    }
    
    func createButton(imagename: String, target: Any?, action: Selector, event: UIControl.Event) -> UIButton {
        let button = UIButton();
        let image = UIImage(named: imagename)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: event)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func createCurrencyField(placeholder: String, font: UIFont!, alignment: NSTextAlignment) -> CurrencyField {
        let field = CurrencyField();
        field.awakeFromNib();
        field.placeholder = placeholder
        field.font = font;
        field.textAlignment = alignment;
        field.translatesAutoresizingMaskIntoConstraints = false;
        return field
    }
    
    func createTextField(placeholder: String, font: UIFont!, alignment: NSTextAlignment, color: UIColor) -> UITextField {
        let field = UITextField();
        field.awakeFromNib();
        field.placeholder = placeholder
        field.textColor = color
        field.attributedPlaceholder = .init(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        field.font = font;
        field.textAlignment = alignment;
        field.translatesAutoresizingMaskIntoConstraints = false;
        return field
    }
    
    func createView (superView: UIView,
        top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, topC: CGFloat? = nil, marginTopActive: Bool,
        right: NSLayoutXAxisAnchor? = nil, rightC: CGFloat? = nil, trailingActive: Bool,
        left: NSLayoutXAxisAnchor? = nil, leftC: CGFloat? = nil, leadingActive: Bool,
        bot: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, botC: CGFloat? = nil, marginBotActive: Bool, botActive: Bool,
        height: CGFloat? = nil, heightActive: Bool,
        viewColor: UIColor, shadowRadius: CGFloat, cornerRadius: CGFloat,
        borderWidth: CGFloat , borderColor: CGColor) -> DesignableView {
//        let guide = self.view.safeAreaLayoutGuide
//        let leftAnchor = safeAreaLayoutGuide.leftAnchor
        
        
        let backgroundView : DesignableView = {
            let view = DesignableView()
            view.backgroundColor = viewColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.insetsLayoutMarginsFromSafeArea = true
            view.layer.cornerRadius = cornerRadius / 2
            view.layer.shadowRadius = shadowRadius
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = borderColor
            return view
        }()
        
        superView.addSubview(backgroundView)
        let margins = superView.layoutMarginsGuide
        
        if trailingActive == true {
            backgroundView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        }
        else if trailingActive == false {
            backgroundView.rightAnchor.constraint(equalTo: right!, constant: rightC!).isActive = true
        }
        
        if leadingActive == true {
            backgroundView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        }
        else if leadingActive == false {
            backgroundView.leftAnchor.constraint(equalTo: left!, constant: leftC!).isActive = true
        }
        
        if marginTopActive == true {
            backgroundView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        }
        else if marginTopActive == false {
            backgroundView.topAnchor.constraint(equalTo: top!, constant: topC!).isActive = true
        }
        
        if marginBotActive == true {
            backgroundView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        }
        if botActive == true {
            backgroundView.bottomAnchor.constraint(equalTo: bot!, constant: botC!).isActive = true
        }
        if heightActive == true {
            backgroundView.heightAnchor.constraint(equalToConstant: height!).isActive = true
        }
       
        return backgroundView
        
    }
}

// MARK: - Contstraint Functions
extension UITableViewCell {
    func setMarginC(subView: UIView, superView: UIView, margin: UILayoutGuide, heightC: CGFloat, C: CGFloat, top: Bool) {
        
        if top == true {
            subView.topAnchor.constraint(equalTo: superView.topAnchor, constant: C ).isActive = true
        }
        else if top == false {
            subView.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: C ).isActive = true
        }
        subView.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        subView.heightAnchor.constraint(equalToConstant: heightC).isActive = true
    }
    
    func setLC(subView: UIView, superView: UIView, margin: UILayoutGuide, heightC: CGFloat, C: CGFloat, widthC: CGFloat? = nil, top: Bool, width: Bool) {
        if top == true {
            subView.topAnchor.constraint(equalTo: superView.topAnchor, constant: C ).isActive = true
        }
        else if top == false {
            subView.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: C ).isActive = true
        }
        subView.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        
        if width == true {
            subView.widthAnchor.constraint(equalToConstant: widthC!).isActive = true
        }
        else if width == false {
            subView.rightAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        }
        subView.heightAnchor.constraint(equalToConstant: heightC).isActive = true
    }
    
    func setRC(subView: UIView, superView: UIView, margin: UILayoutGuide, heightC: CGFloat, C: CGFloat, widthC: CGFloat? = nil, top: Bool, width: Bool) {
        if top == true {
            subView.topAnchor.constraint(equalTo: superView.topAnchor, constant: C ).isActive = true
        }
        else if top == false {
            subView.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: C ).isActive = true
        }
        subView.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        if width == true {
            subView.widthAnchor.constraint(equalToConstant: widthC!).isActive = true
        }
        else if width == false {
            subView.leftAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        }
        subView.heightAnchor.constraint(equalToConstant: heightC).isActive = true
    }
    
}
