//
//  EmptyStateView.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 08/02/22.
//

import UIKit

class EmptyStateView: UIView {

    @IBOutlet var viewContent: UIView!
    @IBOutlet weak var ivEmptyState: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    var textTitle: String {
        get { return "" }
        set { labelTitle.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        showUI()
    }
    
    private func showUI() {
        Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)
        addSubview(viewContent)
        viewContent.frame = self.bounds
        viewContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        labelTitle.font = UIFont.preferredFont(forTextStyle: .title2).bold()
    }
}
