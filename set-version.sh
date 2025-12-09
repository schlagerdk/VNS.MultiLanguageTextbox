#!/bin/bash

# VNS.MultiLanguageTextbox Version Management Script
# Updates version in all relevant files

if [ -z "$1" ]; then
    echo "Usage: ./set-version.sh <version>"
    echo "Example: ./set-version.sh 1.0.1"
    exit 1
fi

VERSION=$1

# Validate semantic version format
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Version must be in semantic version format (e.g., 1.0.1)"
    exit 1
fi

echo "🔄 Updating version to $VERSION..."

# Update package.json
if command -v jq &> /dev/null; then
    # Use jq if available (more reliable)
    jq --arg ver "$VERSION" '.version = $ver' package.json > package.json.tmp && mv package.json.tmp package.json
    echo "✅ Updated package.json"
else
    # Fallback to sed
    sed -i '' "s/\"version\": \".*\"/\"version\": \"$VERSION\"/" package.json
    echo "✅ Updated package.json (using sed)"
fi

# Update .csproj
sed -i '' "s/<Version>.*<\/Version>/<Version>$VERSION<\/Version>/" VNS.MultiLanguageTextbox.csproj
echo "✅ Updated VNS.MultiLanguageTextbox.csproj"

echo ""
echo "✅ Version updated to $VERSION in all files!"
echo ""
echo "Next steps:"
echo "1. Review changes: git diff"
echo "2. Build and test: ./publish.sh"
echo "3. Commit: git commit -am 'Bump version to $VERSION'"
echo "4. Tag: git tag v$VERSION"
echo "5. Push: git push && git push --tags"
