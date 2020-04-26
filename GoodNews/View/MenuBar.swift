

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        return cv
    }()
    var categoryNames: [String] = ["Top", "Media", "Sports", "Tech", "World"]
    let cellId = "cellId"
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
//        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
//        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //US, World, Media, sports, technology, politics
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.backgroundColor = .white
       
        cell.label.text = categoryNames[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height)
    }
}

class MenuCell: UICollectionViewCell {
    var tapped = false
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "GillSans-Bold", size: 20)
        label.sizeToFit()
        return label
    }()
    
    @objc func tappedLabel() {
        print("tapped")
        switch label.text {
        case "Top":
            print("Top")
            clicked = true
            query = "a"
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        case "Sports":
            print("Sports")
            clicked = true
            query = "sports+nba+mlb+nhl+nfl+football+baseball+basketball"
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        case "Media":
            query = "celebrities+movies"
            clicked = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        case "Tech":
            print("Tech")
            clicked = true
            query = "technology+iphone+samsung+tesla+tech+computer+laptop"
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        case "World":
            print("World")
            clicked = true
            query = "world+government+UK+japan+korea+china+africa+russia+canada+mexico+australia"
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        default:
            print("Default")
        }
            
    }
    
//    override var isHighlighted: Bool {
//        didSet {
//            label.textColor = isHighlighted ?  lightBlue : .black
////            let textRange = NSMakeRange(0, label.text!.count)
////            let attributedText = NSMutableAttributedString(string: label.text!)
////            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
////            // Add other attributes if needed
////            label.attributedText = attributedText
//        }
//    }
//    override var isSelected: Bool {
//        didSet {
//            label.textColor = isSelected ?  lightBlue : .black
////            self.isUserInteractionEnabled = isSelected ? false : true
//        }
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedLabel))
        label.addGestureRecognizer(tap)
    }
}
