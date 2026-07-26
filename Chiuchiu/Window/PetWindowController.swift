import AppKit
import SwiftUI

@MainActor
final class PetWindowController: NSWindowController {
    private static let windowSize = NSSize(width: 360, height: 360)

    init() {
        let panel = PetPanel(
            contentRect: NSRect(origin: .zero, size: Self.windowSize)
        )
        let hostingController = NSHostingController(rootView: PetView())

        hostingController.view.wantsLayer = true
        hostingController.view.layer?.backgroundColor = NSColor.clear.cgColor

        panel.contentViewController = hostingController
        panel.setContentSize(Self.windowSize)

        super.init(window: panel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showPet() {
        guard let window else {
            return
        }

        window.center()
        window.orderFrontRegardless()
    }
}
