//
//  LYKAutoScrollView.swift
//  LYKAutoShow
//
//  Created by 陆遗坤 on 2020/5/31.
//  Copyright © 2020 陆遗坤. All rights reserved.
//

import UIKit

@objc protocol LYKAutoScrollViewDelegate {
    @objc optional func didSelectItem(index:IndexPath) -> Void
}
class LYKAutoScrollView: UIView {
    weak var delegate:LYKAutoScrollViewDelegate?
    
    var timer:Timer?
    
    var dataSoures:Array<UIImage>?
    
    let identifier = "CELLID"
    var itemsDataArray:Array<UIImage> = []
    
    var currentIndex:Int = 0{
        willSet{
        }
        didSet{
            page.currentPage = currentIndex-1
        }
    }
    var contentOffsetWillBeginDragging:CGFloat = 0.0
    var contentOffsetDidEndDragging:CGFloat = 0.0

    
    lazy var collectionViewLayout:AutoShowFlowLayout = {
        let collectionViewLayout = AutoShowFlowLayout.init()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.itemSize = self.bounds.size

        return collectionViewLayout
    }()

    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView.init(frame: self.frame, collectionViewLayout: self.collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AutoScrollViewCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        collectionView.contentOffset.x = self.bounds.width
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var page:UIPageControl = {
        let page = UIPageControl.init(frame: CGRect(x:  self.bounds.width-110, y: self.bounds.height-10, width: 100, height: 20))
//        page.center = CGPoint(x: self.center.x, y: page.center.y)
        page.currentPage = 1
        page.pageIndicatorTintColor = .gray
        page.numberOfPages = self.itemsDataArray.count-2
        page.currentPageIndicatorTintColor = .orange
        return page
    }()
    
    
    
    init(frame: CGRect,dataSoures:Array<UIImage>) {
        super.init(frame: frame)
        
        self.dataSoures = dataSoures
        
        creatUIOfCollectionView()
        
        setTimer()
        
        loadData()
        
        creatUIOfPage()
    }
    func creatUIOfPage(){
        self.addSubview(page)
    }
    func setTimer(){
        self.setInvalidate() // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
        let timer = Timer.init(timeInterval: 2.0, target: self, selector: #selector(didTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .default)
        self.timer = timer
    }
    func setInvalidate(){
       
        self.timer?.invalidate()
         self.timer = nil

    }
    
    @objc func didTimer(){
      
        scrollOfCurrentIndexTimerToRight()
    }
    
    func scrollOfCurrentIndexTimerToRight(){
        currentIndex += 1
        let index = IndexPath(row: currentIndex, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        
        if currentIndex >= itemsDataArray.count-1{
            collectionView.contentOffset.x = 0
            currentIndex = 1
        }
        
    }
    
    func loadData(){
        
        guard let dataSoures = dataSoures else {return}
        
      
        itemsDataArray = dataSoures

        itemsDataArray.insert(dataSoures.last!, at: 0)//最前面添加最后一张
        itemsDataArray.append(dataSoures.first!)//最后面添加第一张

        collectionView.reloadData()
    }
    func creatUIOfCollectionView(){
        self.addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        /** 不用的时候记得释放 */
        self.setInvalidate()
    }
    
}
///MARK - UIScrollViewDelegate
extension LYKAutoScrollView{

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.setInvalidate()
      
        let result = Int(scrollView.contentOffset.x / self.bounds.width)
        if result == itemsDataArray.count - 1{
            collectionView.contentOffset.x = self.bounds.width
            currentIndex = 1

        }else if result == 0{
            collectionView.contentOffset.x = self.bounds.width * CGFloat((itemsDataArray.count - 2))
            currentIndex = itemsDataArray.count - 2

        }
   
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / self.bounds.width)

        self.setTimer()
    }
   
}

///MARK - UICollectionViewDelegate
extension LYKAutoScrollView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("选中：\(indexPath.row)")
        let index:IndexPath = IndexPath(row: indexPath.row-1, section: 0)
        delegate?.didSelectItem?(index: index)
    }
}
///MARK - UICollectionViewDataSource
extension LYKAutoScrollView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:AutoScrollViewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AutoScrollViewCollectionViewCell
        cell.imageview.image = itemsDataArray[indexPath.row]
       
        return cell
        
    }
    
}
