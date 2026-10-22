cask "coreremote" do
  version "1.3.1"
  sha256 "841fbea0c1e05a73cf1d0c97de4db5c610c35bc429db90695b7a1dbf1d50d7ab"

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
  ]
end
