
import UIKit
import Photos

private let reuseIdentifier = "Cell"
private let headerIdentifier = "headerCell"

class PhotoController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    var latestPhotoAssetsFetched: PHFetchResult<PHAsset>? = nil
    var selectedAsset = 0
    //var cellImages = [UIImage]()
    //var headerImages = [UIImage]()
    var headerImage:PhotoHeaderCell?
    let count = 40
    var assets = [PHAsset]()
    let requestOptions = PHImageRequestOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.latestPhotoAssetsFetched = self.fetchLatestPhotos(forCount: self.count)
                self.requestImages()
                print("Found assets")
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                // Should not see this when requesting
                print("Not determined yet")
            case .limited:
                print("Not determined yet")
            @unknown default:
                print("Not determined yet")
            }
        }
       
        // Register cell classes
        collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(PhotoHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        addBarButton()
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
    func requestImages()
    {
        requestOptions.deliveryMode = .highQualityFormat
        // Get the latest asset
        for number in 0...count-1
        {
            guard let asset = self.latestPhotoAssetsFetched?[number] else {
                print("couldn't return assets", selectedAsset)
                return
            }
            assets.append(asset)
           
        }
        DispatchQueue.main.async
        {
            self.collectionView.reloadData()
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
        return assets.count
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
         
        if assets.count != 0
        {
            let asset = assets[indexPath.item]
            
            headerImage?.representedAssetIdentifier = asset.localIdentifier
            PHImageManager.default().requestImage(for: asset,
                                                  targetSize: CGSize(width: 600, height: 600),
                                                  contentMode: .default,
                                                  options: requestOptions) { (image, _) in
                
                if self.headerImage?.representedAssetIdentifier == asset.localIdentifier
                {
                    print("dne")
                    self.headerImage?.photoHeader.image = image
                }
            }
        }
      
        return headerImage!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
     selectedAsset = indexPath.item
        let asset = assets[selectedAsset]
        
        headerImage?.representedAssetIdentifier = asset.localIdentifier
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: CGSize(width: 600, height: 600),
                                              contentMode: .default,
                                              options: requestOptions) { (image, _) in
            
            if self.headerImage?.representedAssetIdentifier == asset.localIdentifier
            {
                print("dne selected")
                self.headerImage?.photoHeader.image = image
            }
        }
        collectionView.setContentOffset(CGPoint(x:0,y: -90), animated: true)
    
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell
        
        let asset = assets[indexPath.item]
        
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
