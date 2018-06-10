import UIKit

class SimpleFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }

        let availableWidth = collectionView.bounds.insetBy(dx: collectionView.layoutMargins.left + collectionView.layoutMargins.right,
                                                           dy: 0).size.width
        let availableHeight: CGFloat = 50
        itemSize = CGSize(width: availableWidth, height: availableHeight)
    }

//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        // IMPORTANT: Must be quick, fires not only for size change, but for also for origin change.
//        print("I will be checking invalidation layout for \(newBounds).")
//        guard let collectionView = collectionView else { return false }
//        return !newBounds.size.equalTo(collectionView.bounds.size)
//    }
}
