//
//  ViewController.swift
//  SampleGraph
//
//  Created by 高橋翼 on 2020/09/10.
//  Copyright © 2020 高橋翼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var graphCollectionView: UICollectionView! {
        didSet {
            graphCollectionView.dataSource = self
            graphCollectionView.delegate = self
            graphCollectionView.register(UINib(nibName: "LineCell", bundle: nil), forCellWithReuseIdentifier: "cell")
            graphCollectionView.collectionViewLayout = createLayout()
        }
    }
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    private let dammy: [Int] = {
        var d: [Int] = []
        for _ in 0...500 {
            d.append(Int.random(in: 0...100))
        }
        return d
    }()
    
    private var max = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        max = dammy.max() ?? -1
    }

    func createLayout() -> UICollectionViewLayout {
        //最小単位のアイテムのサイズ
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        //グループ内でのアイテムのレイアウト
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitem: item, count: 15)
        //セクションにグループのレイアウトを適応
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        //UIScrollViewDelegateが呼ばれないから苦肉の策
        section.visibleItemsInvalidationHandler = {visibleItems, point, environment in
            self.updateTotal()
        }
        //レイアウトを返す
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
        
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dammy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LineCell
        let ratio = CGFloat(dammy[indexPath.row]) / CGFloat(max)
        cell.setData(ratio: ratio)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectLabel.text = dammy[indexPath.row].description
    }
    private func updateTotal() {
        let indexes = graphCollectionView.indexPathsForVisibleItems
        var total = 0
        for index in indexes {
            total += dammy[index.row]
        }
        totalLabel.text = total.description
    }
}
