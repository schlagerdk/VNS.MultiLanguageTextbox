#!/bin/bash

# VNS.MultiLanguageTextbox Publish Script
# Dette script bygger projektet og forbereder det til distribution

set -e

echo "🔨 Building VNS.MultiLanguageTextbox..."

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
