import UIKit
import SnapKit

extension UITableView {

    // @link https://stackoverflow.com/a/28102175

    func setAndLayout(headerView: UIView) {
        tableHeaderView = headerView
        headerView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
        }

        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
