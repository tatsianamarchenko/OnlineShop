//
//  Cell.swift
//  SecondProject
//
//  Created by Tatsiana Marchanka on 8.02.22.
//

import UIKit

class Cell: UITableViewCell {

//  private lazy var title : UILabel = {
//    var title = UILabel()
//    title.translatesAutoresizingMaskIntoConstraints = false
//    title.font = UIFont.systemFont(ofSize: 20)
//    title.textColor = .label
//    return title
//  }()

	private lazy var mainCollection : UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = .horizontal
		var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collection.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.backgroundColor = .systemPink
		collection.clipsToBounds = true
		return collection
	}()

  static var cellIdentifier = "Cell"

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  //  contentView.addSubview(title)
	  contentView.backgroundColor = .systemBlue
	  contentView.addSubview(mainCollection)
	  mainCollection.delegate = self
	  mainCollection.dataSource = self
	  NSLayoutConstraint.activate([
//		title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//		title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),

		mainCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
		mainCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		mainCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
		mainCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
	  ])
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

  func config() {
 //   title.text = "model.title"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension Cell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
	  return 10
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
	return 1
  }



  func collectionView(_ collectionView: UICollectionView,
					  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	  guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
															ItemCollectionViewCell.identifier, for: indexPath)
				as? ItemCollectionViewCell else {
					return UICollectionViewCell()
				}
	  cell.placeLabel.text = "shbd"
	  cell.photoOfProduct.layer.cornerRadius = 10
	  cell.photoOfProduct.image = UIImage(named: "lol")
		  //.downloadedFrom(url: CategoriesViewController.contentArray[indexPath.row].image)
	  cell.clipsToBounds = true
	  return cell
  }

  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  sizeForItemAt indexPath: IndexPath) -> CGSize {
	return CGSize(width: 200, height: 300)
  }

  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
	return 1
  }
  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  minimumLineSpacingForSectionAt section: Int) -> CGFloat {
	return 20
  }

  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  insetForSectionAt section: Int) -> UIEdgeInsets {
	return UIEdgeInsets(top: 110, left: 10, bottom: 130, right: 10)
  }
}
