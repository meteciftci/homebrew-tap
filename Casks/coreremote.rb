cask "coreremote" do
  version "1.3.2"
  sha256 "f628d9a2ff2bb6688c45d348943fcca1d24c8fecaf08e3fb1d3b31e3a5784088"

  url "https://github.com/meteciftci/core-remote/releases/download/v#{version}/CoreRemote-#{version}.zip"
  name "CoreRemote"
  desc "SSH and RDP connection manager"
  homepage "https://github.com/meteciftci/core-remote"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "CoreRemote.app"

  # CoreRemote is ad-hoc signed, not notarized. Installing from this tap is the
  # opt-in, so the quarantine flag is removed and Gatekeeper doesn't block it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/CoreRemote.app"]
  end

  uninstall quit: "com.meteciftci.CoreRemote"

  zap trash: [
    "~/Library/Application Support/CoreRemote",
    "~/Library/Logs/CoreRemote",
    "~/Library/Preferences/com.meteciftci.CoreRemote.plist",
    "~/Library/Saved Application State/com.meteciftci.CoreRemote.savedState",
  ]
end
