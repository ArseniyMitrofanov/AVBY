//
//  ViewController.swift
//  AVBY
//
//  Created by Арсений on 16.03.23.
//

import UIKit

enum Section {
    case section
}

class ViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate{
    var currentArrayCar: [Car]!
    let horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.placeholder = "Введите название авто"
        return view
    }()
    let createCarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
    let superSearchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
    var carsCollectionView: UICollectionView!
    var carsDataSourse: UICollectionViewDiffableDataSource<Section, Car>!
    override func viewDidLoad() {
        super.viewDidLoad()
        superSearchButton.addTarget(self, action: #selector(superSearchButtonTapped), for: .touchUpInside)
        createCarButton.addTarget(self, action: #selector(createCarButtonTapped), for: .touchUpInside)
        textField.delegate = self
        carsCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateCollectionViewLayout())
        carsCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        carsCollectionView.showsVerticalScrollIndicator = true
        carsCollectionView.delegate = self
        carsCollectionView.refreshControl = UIRefreshControl()
        carsCollectionView.refreshControl?.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        makeLayout()
        createDataSource()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if Singleton.shared.vcShouldSuperSearch {
            self.superSearchButton.setImage(UIImage(systemName: "multiply"), for: .normal)
            self.superSearchButton.backgroundColor = .red
            if Singleton.shared.arrayCars != nil{
                loadData(arrayCars: Singleton.shared.arrayCars!)
                currentArrayCar = Singleton.shared.arrayCars!
            }else{
                loadData(arrayCars: sortName(textToSort: nil))
                currentArrayCar = CarsService.open.fetchArrayCars()
                print("error!!!")
            }
        }else{
            loadData(arrayCars: sortName(textToSort: nil))
            currentArrayCar = CarsService.open.fetchArrayCars()
        }
    }
    
    func makeLayout(){
        self.view.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(superSearchButton)
        horizontalStackView.addArrangedSubview(textField)
        horizontalStackView.addArrangedSubview(createCarButton)
        self.view.addSubview(carsCollectionView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 5),
            horizontalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            superSearchButton.widthAnchor.constraint(equalToConstant: 70),
            createCarButton.widthAnchor.constraint(equalToConstant: 70),
            carsCollectionView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 10),
            carsCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 5),
            carsCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            carsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
    }
    func generateCollectionViewLayout() -> UICollectionViewLayout {
        let sectionProvider = {
            (int: Int, enviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
    }
    func createDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Car> { cell, indexPath, car in
            if !cell.subviews.isEmpty{
                cell.contentView.subviews.forEach {$0.removeFromSuperview()}
            }
            let ImageView = UIImageView(image: car.photo)
            ImageView.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.height, height: cell.contentView.frame.height)
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.frame = CGRect(x: cell.contentView.frame.height + 5, y: 0, width: (cell.contentView.frame.width - cell.contentView.frame.height - 5), height: cell.contentView.frame.height)
            stackView.distribution = .fillEqually
            let brandLabel = UILabel()
            brandLabel.text = car.brand
            brandLabel.font = .boldSystemFont(ofSize: 25)
            let nameLabel = UILabel()
            nameLabel.text = car.name
            nameLabel.font = .boldSystemFont(ofSize: 20)
            let yearMileageLabel = UILabel()
            yearMileageLabel.text = String(car.year) + ", " + String(car.mileage) + " км "
            let engineLabel = UILabel()
            engineLabel.text = ""
            switch car.engineType {
            case .disel:
                engineLabel.text?.append(String(car.volume) + " л. Дизель")
            case .petrol:
                engineLabel.text?.append(String(car.volume) + " л. Бензин")
            case .gas:
                engineLabel.text?.append(String(car.volume) + " л. Газ")
            case .electic:
                engineLabel.text?.append("электро")
            case .hybrid:
                engineLabel.text?.append(String(car.volume) + " л. Гибрид")
            }
            let priceLabel = UILabel()
            priceLabel.text = String(car.price) + " $"
            priceLabel.font = .systemFont(ofSize: 20)
            priceLabel.textColor = .red
            stackView.addArrangedSubview(brandLabel)
            stackView.addArrangedSubview(nameLabel)
            stackView.addArrangedSubview(yearMileageLabel)
            stackView.addArrangedSubview(engineLabel)
            stackView.addArrangedSubview(priceLabel)
            cell.contentView.addSubview(stackView)
            cell.contentView.addSubview(ImageView)
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            cell.contentView.layer.borderWidth = 1
        }
        
        carsDataSourse = UICollectionViewDiffableDataSource(collectionView: carsCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
            
        }
    }
    func sortName(textToSort: String?) -> [Car]{
        var arrayCars = CarsService.open.fetchArrayCars()
        if (textToSort != nil)&&(textToSort != "") {
            arrayCars = arrayCars.filter { car in
                car.brand.contains(textToSort!)||car.name.contains(textToSort!)
            }
        }
        return arrayCars
    }
    func loadData(arrayCars: [Car]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Car>()
        snapshot.appendSections([.section])
        snapshot.appendItems(arrayCars, toSection: .section)
        carsDataSourse.applySnapshotUsingReloadData(snapshot)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        loadData(arrayCars: sortName(textToSort: textField.text))
        currentArrayCar = sortName(textToSort: textField.text)
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CarViewController()
        vc.car = currentArrayCar[indexPath.row]
     present(vc, animated: true)
    }
    
    @objc func createCarButtonTapped(){
        let vc = CreateCarViewController()
        vc.view.backgroundColor = .white
        let backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func superSearchButtonTapped(){
        if Singleton.shared.vcShouldSuperSearch{
            Singleton.shared.vcShouldSuperSearch = false
            Singleton.shared.arrayCars = nil
            self.superSearchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            self.superSearchButton.backgroundColor = .systemBlue
            loadData(arrayCars: sortName(textToSort: nil))
        }else{
            let vc = SuperSearchViewController()
            vc.view.backgroundColor = .white
            let backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backBarButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func refreshCollectionView(){
        
        carsCollectionView.refreshControl?.endRefreshing()
    }
    
    
    
}


