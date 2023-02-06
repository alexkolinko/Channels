//
//  RootViewController.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

final class RootViewController: UIViewController, StoryboardInitializable {
    
    // - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // - Internal properties
    var presenter: RootPresenter!
    
    // - Private Properties
    private lazy var dataSource = makeDataSource()
    private let disposeBag = DisposeBag()
    
    // - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<RootPresenter.ChannelSectionModel, Program>
    typealias Snapshot = NSDiffableDataSourceSnapshot<RootPresenter.ChannelSectionModel, Program>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
        binding()
    }
}

// MARK: - RootViewController + Private
private extension RootViewController {
    
    func binding() {
        self.presenter.viewContent
            .subscribe(onNext: { [weak self] sections in
                self?.applySnapshot(sections: sections)
            })
            .disposed(by: self.disposeBag)
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, program) ->
                UICollectionViewCell? in
                
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProgramCell.reuseIdentifier,
                    for: indexPath) as? ProgramCell
                cell?.isHidden = false
                cell?.configure(with: program)
                return cell
            })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let section = self.dataSource.snapshot()
                .sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeader.reuseIdentifier,
                for: indexPath) as? SectionHeader
            view?.titleLabel.text = section.title
            return view
        }
        return dataSource
    }
    
    func applySnapshot(sections: [RootPresenter.ChannelSectionModel] ,animatingDifferences: Bool = true) {
        
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.programs, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}


// MARK: - Layout Handling
extension RootViewController {
    private func configureLayout() {
        collectionView.register(
            SectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeader.reuseIdentifier
        )
        collectionView.register(ProgramCell.self, forCellWithReuseIdentifier: ProgramCell.reuseIdentifier)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
            
            
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(200),
                                                         heightDimension: .estimated(88))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .continuous
            layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 12, bottom: 0, trailing: 12)
            
            let header = self.createSectionHeader()
            layoutSection.boundarySupplementaryItems = [header]
            
            return layoutSection
        })
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHEaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHEaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return layoutSectionHeader
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}
