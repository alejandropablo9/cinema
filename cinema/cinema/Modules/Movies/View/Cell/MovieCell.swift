//
//  MovieCell.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
import Combine
final class MovieCell: UICollectionViewCell {
    @IBOutlet public weak var posterMovie: UIImageView!
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(poster: String) {
        cancellable = loadImage(for: poster).sink { [unowned self] image in
            self.showImage(image: image)
        }
    }
    private func showImage(image: UIImage?) {
        posterMovie.alpha = 0.0
        animator?.fractionComplete = 0.25
        animator?.stopAnimation(true)
        animator?.finishAnimation(at: .current)
        posterMovie.image = image
        posterMovie.contentMode = .scaleAspectFill
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.posterMovie.alpha = 1.0
        })
    }
    private func loadImage(for poster: String) -> AnyPublisher<UIImage?, Never> {
        return Just(poster)
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            let url = URL.init(string: poster)!
            return ImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
    }
}
