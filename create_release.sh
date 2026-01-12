#!/usr/bin/env bash

set -e

echo "==================================="
echo "9Launcher Release Creator"
echo "==================================="
echo ""

# Get current version from CMakeLists.txt or ask user
echo "Enter the new version number (e.g., 0.0.3):"
read -r VERSION

# Validate version format
if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Version must be in format X.Y.Z (e.g., 0.0.3)"
    exit 1
fi

TAG="v${VERSION}"

# Check if tag already exists
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo "Error: Tag $TAG already exists!"
    exit 1
fi

echo ""
echo "Enter release title (press Enter to use default: '9Launcher ${VERSION}'):"
read -r RELEASE_TITLE
if [ -z "$RELEASE_TITLE" ]; then
    RELEASE_TITLE="9Launcher ${VERSION}"
fi

echo ""
echo "Would you like to create custom release notes? (y/n)"
read -r CREATE_NOTES

if [[ "$CREATE_NOTES" =~ ^[Yy]$ ]]; then
    echo ""
    echo "Opening editor for release notes..."
    echo "# Release Notes for ${TAG}" > RELEASE_NOTES.md
    echo "" >> RELEASE_NOTES.md
    echo "## What's Changed" >> RELEASE_NOTES.md
    echo "" >> RELEASE_NOTES.md
    echo "### New Features" >> RELEASE_NOTES.md
    echo "- " >> RELEASE_NOTES.md
    echo "" >> RELEASE_NOTES.md
    echo "### Bug Fixes" >> RELEASE_NOTES.md
    echo "- " >> RELEASE_NOTES.md
    echo "" >> RELEASE_NOTES.md
    echo "### Other Changes" >> RELEASE_NOTES.md
    echo "- " >> RELEASE_NOTES.md
    echo "" >> RELEASE_NOTES.md
    echo "## Download" >> RELEASE_NOTES.md
    echo "Choose the appropriate file for your platform below." >> RELEASE_NOTES.md
    
    # Open in editor (try various editors)
    if command -v "${EDITOR:-nano}" &> /dev/null; then
        "${EDITOR:-nano}" RELEASE_NOTES.md
    elif command -v nano &> /dev/null; then
        nano RELEASE_NOTES.md
    elif command -v vim &> /dev/null; then
        vim RELEASE_NOTES.md
    elif command -v vi &> /dev/null; then
        vi RELEASE_NOTES.md
    else
        echo "No suitable editor found. Please edit RELEASE_NOTES.md manually."
        exit 1
    fi
    
    echo ""
    echo "Release notes saved to RELEASE_NOTES.md"
    
    # Ask if user wants to commit the release notes
    echo ""
    echo "Commit RELEASE_NOTES.md? (y/n)"
    read -r COMMIT_NOTES
    if [[ "$COMMIT_NOTES" =~ ^[Yy]$ ]]; then
        git add RELEASE_NOTES.md
        git commit -m "Add release notes for ${TAG}"
    fi
else
    # Remove RELEASE_NOTES.md if it exists to use auto-generated notes
    if [ -f "RELEASE_NOTES.md" ]; then
        rm RELEASE_NOTES.md
    fi
    echo "Using auto-generated release notes"
fi

echo ""
echo "==================================="
echo "Summary:"
echo "  Version: ${VERSION}"
echo "  Tag: ${TAG}"
echo "  Title: ${RELEASE_TITLE}"
if [ -f "RELEASE_NOTES.md" ]; then
    echo "  Notes: Custom (RELEASE_NOTES.md)"
else
    echo "  Notes: Auto-generated"
fi
echo "==================================="
echo ""
echo "Ready to create release. This will:"
echo "  1. Create and push tag ${TAG}"
echo "  2. Trigger GitHub Actions to build artifacts"
echo "  3. Create GitHub release with artifacts"
echo ""
echo "Continue? (y/n)"
read -r CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

# Create and push tag
echo ""
echo "Creating tag ${TAG}..."
git tag -a "$TAG" -m "$RELEASE_TITLE"

echo "Pushing tag to origin..."
git push origin "$TAG"

echo ""
echo "==================================="
echo "Release ${TAG} created!"
echo "==================================="
echo ""
echo "GitHub Actions will now build the artifacts and create the release."
echo "You can monitor the progress at:"
echo "https://github.com/$(git config --get remote.origin.url | sed 's/.*://;s/.git$//')/actions"
echo ""
echo "After the build completes, the release will be available at:"
echo "https://github.com/$(git config --get remote.origin.url | sed 's/.*://;s/.git$//')/releases/tag/${TAG}"
