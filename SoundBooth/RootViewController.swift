//
//  RootViewController.swift
//  SoundBooth
//
//  Created by user on 2020/10/02.
//

import UIKit

class RootViewController: UIViewController {
    enum Section: Hashable {
        case navigation
        case playlistGroup(String)
    }
    
    enum Item: Hashable {
        case navigation(String)
        case playlist(String)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    lazy var dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
        switch identifier {
        case .navigation(let title):
            return collectionView.dequeueConfiguredReusableCell(using: self.configuredNavigationCell(), for: indexPath, item: identifier)
        case .playlist(let string):
            return collectionView.dequeueConfiguredReusableCell(using: self.configuredPlaylistCell(), for: indexPath, item: identifier)
        }
    }
    
    override func loadView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = dataSource
        view = collectionView
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: self.configuredTitleSupplementaryView(), for: indexPath)
        }
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([
            .navigation,
            .playlistGroup("SONGS"),
            .playlistGroup("GAME BGM"),
        ])
        snapshot.appendItems([
            .navigation("プレイリスト"),
            .navigation("ユニット"),
            .navigation("アイドル"),
            .navigation("作曲者"),
            .navigation("作詞者"),
        ], toSection: .navigation)
        snapshot.appendItems([
            .playlist("お願い！シンデレラ"),
            .playlist("CINDERELLA GIRLS"),
            .playlist("STARLIGHT STAGE"),
            .playlist("Solo Tracks"),
            .playlist("from Animation"),
            .playlist("ReArrange&ReMix"),
            .playlist("Special Tracks"),
        ], toSection: .playlistGroup("SONGS"))
        snapshot.appendItems([
            .playlist("STARLIGHT STAGE BGM"),
            .playlist("Arrange BGM"),
        ], toSection: .playlistGroup("GAME BGM"))
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Sound Booth"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func createCollectionViewLayout() -> some UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return .list(using: .init(appearance: .plain), layoutEnvironment: layoutEnvironment)
            }
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)),
                subitem: .init(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(1))),
                count: 2
            )
            group.interItemSpacing = .fixed(20)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 20
            section.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
            section.boundarySupplementaryItems = [.init(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)),
                elementKind: "header",
                alignment: .topLeading
            )]
            return section
        }
    }
    
    func configuredNavigationCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
        return .init { (cell, indexPath, item) in
            switch item {
            case .navigation(let name):
                var content = UIListContentConfiguration.cell()
                content.text = name
                content.image = UIImage(systemName: "questionmark.circle")
                cell.contentConfiguration = content
                cell.accessories = [.disclosureIndicator()]
                cell.separatorLayoutGuide.leadingAnchor.constraint(equalTo: cell.readableContentGuide.leadingAnchor).isActive = true
            case .playlist(_):
                fatalError("wtf")
            }
        }
    }
    
    func configuredPlaylistCell() -> UICollectionView.CellRegistration<SongCollectionViewCell, Item> {
        return .init { cell, indexPath, item in
            switch item {
            case .navigation(_):
                fatalError("wtf")
            case .playlist(let title):
                cell.label.text = title
                print("todo")
            }
        }
    }
    
    func configuredTitleSupplementaryView() -> UICollectionView.SupplementaryRegistration<HeaderTextSupplementaryView> {
        return .init(elementKind: "Header") { [weak self] (supplementaryView, string, indexPath) in
            guard let self = self else {
                return
            }
            guard case let .playlistGroup(title) = self.dataSource.snapshot().sectionIdentifiers[indexPath.section] else {
                return
            }
            supplementaryView.label.text = title
        }
    }
}
