
import UIKit
import Photos

private let reuseIdentifier = "Cell"
private let headerIdentifier = "headerCell"

class PhotoController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    var latestPhotoAssetsFetched: PHFetchResult<PHAsset>? = nil
    var selectedAsset = 0
    var images = [UIImage]()
    var headerImage:PhotoHeaderCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(PhotoHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        addBarButton()
        self.latestPhotoAssetsFetched = self.fetchLatestPhotos(forCount: 40)
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
    //Fetch users photos
    func requestHeaderImages()
    {
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = .highQualityFormat
        // Get the latest asset
        guard let asset = self.latestPhotoAssetsFetched?[selectedAsset] else {
            print("couldn't return assets", selectedAsset)
            return
        }
        headerImage?.representedAssetIdentifier = asset.localIdentifier
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: CGSize(width: 600, height: 600),
                                              contentMode: .aspectFill,
                                              options: requestOptions) { (image, _) in
            
            if self.headerImage?.representedAssetIdentifier == asset.localIdentifier
            {
                guard let image = image else {return}
                DispatchQueue.main.async {
                    self.headerImage?.photoHeader.image = image
                }
            }
        }
       
    }
    
    func addBarButton()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(shareOpt))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func shareOpt ()
    {
        let vc = SharePhotoViewController()
        vc.imageSetter = headerImage?.photoHeader.image
        navigationController?.pushViewController(vc, animated: true)
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
        self.headerImage = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as? PhotoHeaderCell
        
        requestHeaderImages()
        
        
//        DispatchQueue.main.async {
//            self.headerImage?.photoHeader.image = self.images[0]
//        }
        return headerImage!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectedAsset = indexPath.item
        requestHeaderImages()
        collectionView.setContentOffset(CGPoint(x:0,y: -90), animated: true)
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
                                              contentMode: .default,
                                              options: requestOptions) { (image, _) in
            
            if cell!.representedAssetIdentifier == asset.localIdentifier
            {
                cell?.photoView.image = image
            }
        }
        
        return cell!
    }
}
