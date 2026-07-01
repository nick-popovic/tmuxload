#!/usr/bin/env bash
set -e

REPO="nick-popovic/tmuxload"

# Use ~/.local/bin as the standard user binary directory
DEFAULT_DIR="$HOME/.local/bin"
INSTALL_DIR="${1:-$DEFAULT_DIR}"

BIN_URL="https://github.com/$REPO/releases/latest/download/tml"
CHECKSUM_URL="https://github.com/$REPO/releases/latest/download/tml.sha256"

echo "Downloading tml from latest release..."
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

if ! curl -sLf "$BIN_URL" -o tml; then
    echo "Error: Failed to download tml. Make sure a release exists."
    cd - >/dev/null
    rm -rf "$TMP_DIR"
    exit 1
fi

echo "Downloading checksum file..."
if ! curl -sLf "$CHECKSUM_URL" -o tml.sha256; then
    echo "Error: Failed to download checksum file."
    cd - >/dev/null
    rm -rf "$TMP_DIR"
    exit 1
fi

echo "Verifying checksum..."
# Check if sha256sum is available
if ! command -v sha256sum >/dev/null 2>&1; then
    # Fallback to shasum on macOS if sha256sum is not available
    if command -v shasum >/dev/null 2>&1; then
        if ! shasum -a 256 -c tml.sha256 >/dev/null 2>&1; then
            echo "Error: Checksum verification failed!"
            cd - >/dev/null
            rm -rf "$TMP_DIR"
            exit 1
        fi
        echo "Checksum verified successfully."
    else
        echo "Warning: Neither sha256sum nor shasum found."
        echo "We cannot securely verify the downloaded binary."
        # Read from /dev/tty so this works even if the script is piped to bash
        read -p "Do you want to continue installation anyway? [y/N] " -r REPLY < /dev/tty || true
        if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
            echo "Installation aborted."
            cd - >/dev/null
            rm -rf "$TMP_DIR"
            exit 1
        fi
    fi
else
    if ! sha256sum -c tml.sha256 >/dev/null 2>&1; then
        echo "Error: Checksum verification failed!"
        cd - >/dev/null
        rm -rf "$TMP_DIR"
        exit 1
    fi
    echo "Checksum verified successfully."
fi

# Ensure installation directory exists
mkdir -p "$INSTALL_DIR"

# Move the binary and make it executable as 'tml'
mv tml "$INSTALL_DIR/tml"
chmod +x "$INSTALL_DIR/tml"

# Clean up
cd - >/dev/null
rm -rf "$TMP_DIR"

echo "======================================================="
echo " Successfully installed tml to:"
echo "   $INSTALL_DIR/tml"
echo "======================================================="

# Check if the install directory is in the user's PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo " Note: $INSTALL_DIR is not in your PATH."
    echo " You may need to add the following line to your ~/.bashrc or ~/.zshrc:"
    echo "   export PATH=\"\$PATH:$INSTALL_DIR\""
    echo ""
fi
