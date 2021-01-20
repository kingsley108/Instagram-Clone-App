
import UIKit
import Photos

private let reuseIdentifier = "Cell"
private let headerIdentifier = "headerCell"

class PhotoController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    var latestPhotoAssetsFetched: PHFetchResult<PHAsset>? = nil
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        
        // Register cell classes
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        addBarButton()
        self.latestPhotoAssetsFetched = self.fetchLatestPhotos(forCount: 10)
        
    }
    
    
    func fetchLatestPhotos(forCount count: Int?) -> PHFetchResult<PHAsset> {
        // Create fetch options.
        let options = PHFetchOptions()
        
        
        // If count limit is specified.
        if let count = count { options.fetchLimit = count }
        
        // Add sortDescriptor so the lastest photos will be returned.
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        options.sortDescriptors = [sortDescriptor]
        
        // Fetch the photos.
        return PHAsset.fetchAssets(with: .image, options: options)
    }
    
    
    func addBarButton()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func nextClicked ()
    {
        print("next clicked")
        
    }
    
    @objc func cancelClicked ()
    {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return latestPhotoAssetsFetched!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        let size = (view.frame.width)
        return CGSize(width: size, height: size)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = (view.frame.width - 3)/4
        return CGSize(width: size, height: size)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath)
        
        header.backgroundColor = .red
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell
        let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = .highQualityFormat
        
        // Get the latest asset
        guard let asset = self.latestPhotoAssetsFetched?[indexPath.item] else {
            print("couldn't return assets", indexPath.item)
            return cell!
        }
        cell!.representedAssetIdentifier = asset.localIdentifier
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: CGSize(width: 200, height: 200),
                                              contentMode: .aspectFill,
                                              options: requestOptions) { (image, _) in
            
            if cell!.representedAssetIdentifier == asset.localIdentifier
            {
                cell?.photoView.image = image
            }
        }
        
        return cell!
    }
}
