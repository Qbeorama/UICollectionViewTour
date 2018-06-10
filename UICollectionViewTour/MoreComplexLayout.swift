import UIKit

// 1 cellka zabiera połowę ekranu, pozostałe dwie po 25%, i od nowa
class MoreComplexLayout: UICollectionViewLayout {

    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    var contentBounds: CGRect = .zero

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)

//        createAttributes()
    }

    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter({
            return rect.intersects($0.frame)
        })
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.row]
    }

//    func createAttributes() {
//        // Assume just 1 section.
//        guard let collectionView = collectionView else { return }
//        let numberOfItems = collectionView.numberOfItems(inSection: 0)
//        let maxWidth = contentBounds.size.width - collectionView.layoutMargins.left - collectionView.layoutMargins.right
//
//        var currentRow = 0
//        var currentColumn = 0
//
//        let height: CGFloat = 40
//
//        for i in 0...numberOfItems {
//
//            // Create attribute
//
//            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: i))
//
//            let width = i % 3 == 0 ? contentBounds.size.width / 2 : contentBounds.size.width / 4
//
//            // Calculate origin point
//            currentRow += width + 8.0
//
//// Calculate size
//
//            attributes.frame = CGRect.init(origin: CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>),
//                                           size: CGSize(width: width, height: height))
//        }
//
//    }
}
