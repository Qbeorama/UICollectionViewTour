import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    let cellModelsCount = 4
    var switchedLayout = false

    override func viewDidLoad() {
        collectionView?.register(UINib(nibName: "SimpleCollectionViewCell", bundle: Bundle.main),
                                 forCellWithReuseIdentifier: "SimpleCollectionViewCell")
    }

    lazy var cellModels: [CellModel] = {
        var cellModels: [CellModel] = []
        for i in 1...cellModelsCount {
            let color = colors[i % colors.count]
            let cellModel: CellModel = CellModel(text: String(i), color: color)
            cellModels.append(cellModel)
        }
        return cellModels
    }()

    let colors: [UIColor] = [
        UIColor(red: 87/255.0, green: 17/255.0, blue: 74/255.0, alpha: 1.0),
        UIColor(red: 217/255.0, green: 0/255.0, blue: 155/255.0, alpha: 1.0),
        UIColor(red: 255/255.0, green: 45/255.0, blue: 0/255.0, alpha: 1.0),
        UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1.0),
        UIColor(red: 4/255.0, green: 117/255.0, blue: 111/255.0, alpha: 1.0)
    ]

    @IBAction func rearrangeItemsBad(_ button: UIButton) {
        collectionView.performBatchUpdates({

            let lastIndex = cellModels.count - 1
            guard lastIndex > 0 else {
                return
            }

            // Update last cell
            let cellModel = cellModels[lastIndex]
            cellModel.text = cellModel.text + " (u)"

            // Remove it before inserting at top
            cellModels.remove(at: lastIndex)

            // Delete "new last" cell
            cellModels.remove(at: lastIndex - 1)

            // Insert updated cell to top
            cellModels.insert(cellModel, at: 0)

            collectionView.reloadItems(at: [IndexPath(item: lastIndex)])
            collectionView.deleteItems(at: [IndexPath(item: lastIndex - 1)])
            collectionView.moveItem(at: IndexPath(item: lastIndex), to: IndexPath(item: 0))
        })
    }
    
    @IBAction func rearrangeItemsGood(_ button: UIButton) {
            // Reload cell first. Without animation.
            UIView.performWithoutAnimation {
                collectionView.performBatchUpdates({
                    // Update last cell
                    let cellModel = cellModels[3]
                    cellModel.text = cellModel.text + " (u)"
                    collectionView.reloadItems(at: [IndexPath(item:3)])
                })
            }

            // Do the rest of work with animation
            collectionView.performBatchUpdates({
                // Delete last to top, but keep reference
                let movedCell = cellModels[3]
                cellModels.remove(at: 3)

                // Delete previous-to-last
                cellModels.remove(at: 2)

                // Insert last to top
                cellModels.insert(movedCell, at: 0)

                // Update collectionView
                collectionView.deleteItems(at: [IndexPath(item:2)])
                collectionView.moveItem(at: IndexPath(item:3), to: IndexPath(item: 0))
            })
    }

    @IBAction func changeLayout(_ button: UIButton) {
        let newLayout = switchedLayout ? SimpleFlowLayout() : SimpleThreeColumnFlowLayout()
        switchedLayout = !switchedLayout
        collectionView.setCollectionViewLayout(newLayout, animated: true)
    }
}

extension ViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimpleCollectionViewCell", for: indexPath) as! SimpleCollectionViewCell
        let model = cellModels[indexPath.row]
        cell.label.text = model.text
        cell.backgroundColor = model.color
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
}
