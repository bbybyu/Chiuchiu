import AppKit

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private var petWindowController: PetWindowController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        let controller = PetWindowController()
        petWindowController = controller
        controller.showPet()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
