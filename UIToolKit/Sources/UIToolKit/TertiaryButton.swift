//
//  TertiaryButton.swift
//
//
//  Created by Zain Ul Abe Din on 01/11/2024.
//

import UIKit

public final class TertiaryButton: UIButton {
    // MARK: - Properties
    public var icon: UIImage? { didSet { setup() } }
    public var title: String? { didSet { setup() } }
    public var alignment: UIButton.Configuration.TitleAlignment = .center { didSet { setup() } }
    public var theme: Theme = .primary { didSet { setup() } }
    public var contentInsets: NSDirectionalEdgeInsets = .zero { didSet { setup() } }
    public override var isEnabled: Bool { didSet { setup() } }
    public var attributes: [NSAttributedString.Key: Any] = Constant.attributes { didSet { setup() } }
    public var imagePadding: CGFloat = .small { didSet { setup() }}
    public override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.transform = (self?.isHighlighted ?? false) ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            })
        }
    }

    // MARK: - Constants
    private enum Constant {
        static let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.bodyMedium
        ]
    }
    
    // MARK: Theme
    public enum Theme {
        case primary
        case blue
    }
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setup()
    }
}

// MARK: - Setup
private extension TertiaryButton {
    func setup() {
        var config = UIButton.Configuration.borderless()
        config.title = title
        config.image = icon?.withRenderingMode(.alwaysTemplate)
        config.imagePadding = imagePadding
        config.baseBackgroundColor = .clear
        config.titleAlignment = alignment
        config.contentInsets = contentInsets
        switch theme {
        case .primary: config.baseForegroundColor = isEnabled ? .blue400 : .blue200
        case .blue: config.baseForegroundColor = .blue400
        }
        
        if let title = title {
            config.attributedTitle = AttributedString(title, attributes: AttributeContainer(attributes))
        }
        
        configuration = config
        backgroundColor = .clear
    }
}
