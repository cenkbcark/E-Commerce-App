//
//  HomePageViewController.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 7.11.2022.
//

import UIKit
import Firebase
final class HomePageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel: ProductViewModelInput
    private var sliderList: [SliderModel] = []
    private var advantageList: [ProductList] = []
    private var topSellList: [ProductList] = []
    private var tabList: [TabList] = []
    
    init(viewModel: ProductViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: "HomePageViewController", bundle: .main)
        self.viewModel.output = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerSliderCell()
        registerAdvantageCell()
        registerTopSellCell()
        setSliderData()
        viewModel.viewDidLoad()
    }
    private func registerSliderCell() {
        let cellIdentifier = String(describing: SliderTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    private func registerAdvantageCell() {
        let cellIdentifier = String(describing: AdvantageTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    private func registerTopSellCell() {
        let cellIdentifier = String(describing: TopSellTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    private func setSliderData() {
        var list : [SliderModel] = []
        list.append(SliderModel(image: UIImage(named: "1")!))
        list.append(SliderModel(image: UIImage(named: "2")!))
        list.append(SliderModel(image: UIImage(named: "3")!))
        list.append(SliderModel(image: UIImage(named: "4")!))
        list.append(SliderModel(image: UIImage(named: "5")!))
        list.append(SliderModel(image: UIImage(named: "6")!))
        tabList.append(.sliderList(list))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
extension HomePageViewController: ProductViewModelOutput {
    func home(_home viewModel: ProductViewModelInput, productList: [ProductList]) {
        tabList.append(.advantageList(productList.filter({ return $0.category == "smartphones"})))
        tabList.append(.topSellList(productList.filter({ return $0.category == "home-decoration"})))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tabList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabList[section] {
        case .sliderList(_):
            return 1
        case .advantageList(_):
            return 1
        case .topSellList(_):
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tabList[indexPath.section] {
        case .sliderList(let sliderList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderTableViewCell", for: indexPath) as! SliderTableViewCell
            cell.prepareCategory(with: sliderList)
            return cell
        case .advantageList(let advantageList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdvantageTableViewCell", for: indexPath) as! AdvantageTableViewCell
            cell.prepareCategory(with: advantageList)
            return cell
        case .topSellList(let topSellList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopSellTableViewCell", for: indexPath) as! TopSellTableViewCell
            cell.prepareCategory(with: topSellList)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tabList[indexPath.section] {
        case .sliderList(_):
            return 270
        case .advantageList(_):
            return 290
        case .topSellList(_):
            return 290
        }
    }
}

private enum TabList {
    case sliderList(_ model: [SliderModel])
    case advantageList(_ model: [ProductList])
    case topSellList(_ model: [ProductList])
}
