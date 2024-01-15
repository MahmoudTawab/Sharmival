//
//  CardsCollectionViewLayout.swift
//  SHARMIVAL
//
//  Created by Emojiios on 15/09/2022.
//

import UIKit

protocol ParallaxCardCell {
    func setShadeOpacity(progress: CGFloat)
    func setZoom(progress: CGFloat)
}

@objc protocol CardsLayoutDelegate: AnyObject {
    func transition(between currentIndex: Int, and nextIndex: Int, progress: CGFloat)
}


open class CardsCollectionViewLayout: UICollectionViewLayout {

  @IBOutlet private weak var delegate: CardsLayoutDelegate!
    
  // MARK: - Layout configuration
 public var itemSize: CGSize = CGSize(width: UIScreen.main.bounds.width - ControlX(100) ,height: UIScreen.main.bounds.height - ControlY(300)) {
    didSet{
      invalidateLayout()
    }
  }

  public var spacing: CGFloat = 40.0 {
    didSet{
      invalidateLayout()
    }
  }

  public var visibleItemsCount: Int = 4 {
    didSet{
      invalidateLayout()
    }
  }
    
    public var minScale: CGFloat = 0.9 {
    didSet { invalidateLayout() }
    }

  // MARK: UICollectionViewLayout
  override open var collectionView: UICollectionView {
    return super.collectionView!
  }

  override open var collectionViewContentSize: CGSize {
    let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
    return CGSize(width: collectionView.bounds.width * itemsCount,
                  height: collectionView.bounds.height)
  }

  override open func prepare() {
    super.prepare()
    assert(collectionView.numberOfSections == 1, "Multiple sections aren't supported!")
  }

  override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let totalItemsCount = collectionView.numberOfItems(inSection: 0)

    let minVisibleIndex = max(Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width), 0)
    let maxVisibleIndex = min(minVisibleIndex + visibleItemsCount, totalItemsCount)

    let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)

    let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)

    let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width

    let visibleIndices = stride(from: minVisibleIndex, to: maxVisibleIndex, by: 1)

    let attributes: [UICollectionViewLayoutAttributes] = visibleIndices.map { index in
      let indexPath = IndexPath(item: index, section: 0)
      return computeLayoutAttributesForItem(indexPath: indexPath,
                                     minVisibleIndex: minVisibleIndex,
                                     contentCenterX: contentCenterX,
                                     deltaOffset: CGFloat(deltaOffset),
                                     percentageDeltaOffset: percentageDeltaOffset)
    }

    return attributes
  }

  override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
    let minVisibleIndex = Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width)
    let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
    let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
    return computeLayoutAttributesForItem(indexPath: indexPath,
                                   minVisibleIndex: minVisibleIndex,
                                   contentCenterX: contentCenterX,
                                   deltaOffset: CGFloat(deltaOffset),
                                   percentageDeltaOffset: percentageDeltaOffset)
  }

  override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}


// MARK: - Layout computations
fileprivate extension CardsCollectionViewLayout {

  private func scale(at index: Int) -> CGFloat {
    let translatedCoefficient = CGFloat(index) - CGFloat(self.visibleItemsCount) / 2
    return CGFloat(pow(1, translatedCoefficient))
  }

  private func transform(atCurrentVisibleIndex visibleIndex: Int, percentageOffset: CGFloat) -> CGAffineTransform {
    var rawScale = visibleIndex < visibleItemsCount ? scale(at: visibleIndex) : 1.0

    if visibleIndex != 0 {
      let previousScale = scale(at: visibleIndex - 1)
      let delta = (previousScale - rawScale) * percentageOffset
      rawScale += delta
    }
    return CGAffineTransform(scaleX: rawScale, y: rawScale)
  }

    func computeLayoutAttributesForItem(indexPath: IndexPath,
                                       minVisibleIndex: Int,
                                       contentCenterX: CGFloat,
                                       deltaOffset: CGFloat,
                                       percentageDeltaOffset: CGFloat) -> UICollectionViewLayoutAttributes {
    let attributes = UICollectionViewLayoutAttributes(forCellWith:indexPath)
    let visibleIndex = indexPath.row - minVisibleIndex
    attributes.size = itemSize
    let midY = self.collectionView.bounds.midY
    attributes.center = CGPoint(x: contentCenterX + spacing * CGFloat(visibleIndex),
                                y: midY )
    attributes.zIndex = visibleItemsCount - visibleIndex

    attributes.transform = transform(atCurrentVisibleIndex: visibleIndex,
                                          percentageOffset: percentageDeltaOffset)
        
    let scale = parallaxProgress(for: visibleIndex, percentageDeltaOffset, minScale)
    attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        
    let cell = collectionView.cellForItem(at: indexPath) as? ParallaxCardCell
    cell?.setZoom(progress: scale)
    let progress = parallaxProgress(for: visibleIndex, percentageDeltaOffset)
    cell?.setShadeOpacity(progress: progress)
        
    switch visibleIndex {
    case 0:
      attributes.center.x -= deltaOffset
      break
    case 1..<visibleItemsCount:
      attributes.center.x -= spacing * percentageDeltaOffset
    cell?.setShadeOpacity(progress: 1)

      if visibleIndex == visibleItemsCount - 1 {
        attributes.alpha = percentageDeltaOffset
      }
      break
    default:
      attributes.alpha = 0
      break
    }
    return attributes
  }
    
    private func parallaxProgress(for visibleIndex: Int, _ offsetProgress: CGFloat, _ minimum: CGFloat = 0) -> CGFloat {
    let step = -(1.0 - minimum) / CGFloat(visibleItemsCount)
    return 1.0 - CGFloat(visibleItemsCount - visibleIndex) * step - step * offsetProgress
    }
}
