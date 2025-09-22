import UIKit

extension UITableView {

    // @link https://stackoverflow.com/a/28102175

    func setAndLayout(headerView: UIView) {
        tableHeaderView = headerView
        headerView.setupConstraints {
            [$0.widthAnchor.constraint(equalTo: widthAnchor)]
        }

        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
