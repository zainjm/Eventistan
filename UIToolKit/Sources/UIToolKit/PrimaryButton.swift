//
//  PrimaryButton.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 31/03/2025.
//

import Foundation
import UIKit

public final class PrimaryButton: UIButton {
    // MARK: - Properties
    public var renderingMode: UIImage.RenderingMode = .alwaysTemplate
    public var icon: UIImage? { didSet { setup() } }
    public var title: String? { didSet { setup() } }
    public var alignment: UIButton.Configuration.TitleAlignment = .center { didSet { setup() } }
    public override var isEnabled: Bool { didSet { setup() } }
    public var customForegroundColor: UIColor? { didSet { setup() } }
    public var customBackgroundColor: UIColor? { didSet { setup() } }
    public var attributes: [NSAttributedString.Key: Any] = Constant.attributes { didSet { setup() } }
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
            .font: UIFont.bodyMedium,
        ]
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
private extension PrimaryButton {
    private func setup() {
        var config = UIButton.Configuration.filled()
        config.image = icon?.withRenderingMode(renderingMode)
        config.imagePadding = .little
        config.baseBackgroundColor = customBackgroundColor ?? (isEnabled ? .primaryLabel : .secondaryLabel)
        config.titleAlignment = alignment
        
        if let title = title {
            config.attributedTitle = AttributedString(title, attributes: AttributeContainer(attributes))
        }
        config.cornerStyle = .large
        configuration = config
        backgroundColor = .clear
        layer.cornerRadius = 24
        layer.masksToBounds = true
    }
}
