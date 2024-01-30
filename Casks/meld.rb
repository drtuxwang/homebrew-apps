cask "meld" do
  version "3.21.0.osx4"
  sha256 "8e5fd029278fb858c8d5804d1725160f80ccb86beaf92dab7dc057c846b81065"

  url "https://github.com/yousseb/meld/releases/download/osx-20/meldmerge.dmg",
      verified: "github.com/yousseb/meld/"
  name "Meld for OSX"
  desc "Visual diff and merge tool"
  homepage "https://yousseb.github.io/meld/"

  depends_on macos: ">= :high_sierra"

  app "Meld.app"
  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/meld.wrapper.sh"
  binary shimscript, target: "meld"

  preflight do
    File.write shimscript, <<~EOS
      #!/bin/sh
      exec '#{appdir}/Meld.app/Contents/MacOS/Meld' "$@"
    EOS
  end

  zap trash: [
    "~/.local/share/meld",
    "~/Library/Preferences/org.gnome.meld.plist",
    "~/Library/Saved Application State/org.gnome.meld.savedState/",
  ]

  caveats do
    discontinued
  end
end
