#!/bin/bash

# VNS.MultiLanguageTextbox Publish Script
# Dette script bygger projektet og forbereder det til distribution

set -e

# Get current version from package.json
CURRENT_VERSION=$(grep -o '"version": "[^"]*"' package.json | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')

echo "🔨 Building VNS.MultiLanguageTextbox..."
echo "Current version: $CURRENT_VERSION"
echo ""
read -p "Enter new version (or press Enter to keep $CURRENT_VERSION): " NEW_VERSION

# Update version if provided
if [ ! -z "$NEW_VERSION" ]; then
    # Validate semantic version format
    if ! [[ $NEW_VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Error: Version must be in semantic version format (e.g., 1.0.1)"
        exit 1
    fi
    
    echo "🔄 Updating version to $NEW_VERSION..."
    
    # Update package.json
    if command -v jq &> /dev/null; then
        jq --arg ver "$NEW_VERSION" '.version = $ver' package.json > package.json.tmp && mv package.json.tmp package.json
    else
        sed -i '' "s/\"version\": \".*\"/\"version\": \"$NEW_VERSION\"/" package.json
    fi
    
    # Update .csproj
    sed -i '' "s/<Version>.*<\/Version>/<Version>$NEW_VERSION<\/Version>/" VNS.MultiLanguageTextbox.csproj
    
    # Update umbraco-package.json
    if command -v jq &> /dev/null; then
        jq --arg ver "$NEW_VERSION" '.version = $ver' umbraco-package.json > umbraco-package.json.tmp && mv umbraco-package.json.tmp umbraco-package.json
    else
        sed -i '' "s/\"version\": \".*\"/\"version\": \"$NEW_VERSION\"/" umbraco-package.json
    fi
    
    echo "✅ Version updated to $NEW_VERSION"
    echo ""
fi

# Clean previous build
if [ -d "dist" ]; then
    echo "🧹 Cleaning previous build..."
    rm -rf dist
fi

# Build with Vite
echo "📦 Running Vite build..."
npm run build

# Copy umbraco-package.json to dist
echo "📋 Copying umbraco-package.json..."
cp umbraco-package.json dist/VNS.MultiLanguageTextbox/

echo "✅ Build completed successfully!"
echo "📁 Distribution files are in: dist/VNS.MultiLanguageTextbox/"
echo ""
echo "Files ready for deployment:"
ls -la dist/VNS.MultiLanguageTextbox/

# Build NuGet package if .csproj exists
if [ -f "VNS.MultiLanguageTextbox.csproj" ]; then
    echo ""
    echo "📦 Building NuGet package..."
    dotnet pack VNS.MultiLanguageTextbox.csproj -c Release -o ./nupkg
    echo "✅ NuGet package created in: nupkg/"
    
    # Clean up bin folder after build
    if [ -d "bin" ]; then
        echo "🧹 Cleaning bin folder..."
        rm -rf bin
    fi
fi
