# NuGet Package Guide

## Creating the NuGet Package

### Prerequisites
1. .NET SDK 8.0 or higher installed
2. Build the project first: `npm run publish`

### Build NuGet Package

```bash
# Build the NuGet package
dotnet pack VNS.MultiLanguageTextbox.csproj -c Release -o ./nupkg
```

Or use the publish script which will build both the dist files and NuGet package:

```bash
./publish.sh
```

The NuGet package will be created in the `nupkg/` folder.

## Package Documentation Files

All NuGet package documentation files are stored in the `docs/` folder:

- `docs/icon.png` - Package logo/icon (128x128+ pixels, up to 1MB)
- `docs/README.md` - Package documentation (shown on NuGet.org)
- `docs/LICENSE.md` - License file

The .csproj file is configured to include these files in the NuGet package.

## Publishing to NuGet.org

### First Time Setup

```bash
# Set your NuGet API key (get it from nuget.org)
dotnet nuget push nupkg/VNS.MultiLanguageTextbox.1.0.0.nupkg --api-key YOUR_API_KEY --source https://api.nuget.org/v3/index.json
```

### Update Version

1. Use the version script to update version everywhere:
   ```bash
   ./set-version.sh 1.0.1
   ```

2. Rebuild and push:
   ```bash
   ./publish.sh
   dotnet nuget push nupkg/VNS.MultiLanguageTextbox.*.nupkg --api-key YOUR_API_KEY --source https://api.nuget.org/v3/index.json
   ```

## Testing Locally

You can test the package locally before publishing:

```bash
# Add local package source
dotnet nuget add source /Users/mhs/Library/CloudStorage/Dropbox/!Source/Systems/VNS.MultiLanguageTextbox/nupkg -n VNSLocal

# In your Umbraco project
dotnet add package VNS.MultiLanguageTextbox --source VNSLocal
```

## Package Contents

The NuGet package will include:
- All files from `dist/VNS.MultiLanguageTextbox/` → automatically placed in `wwwroot/App_Plugins/VNS.MultiLanguageTextbox/`
- `docs/README.md` → package documentation (shown on NuGet.org)
- `docs/LICENSE.md` → license file
- `docs/icon.png` → package branding/logo

## Versioning

Follow semantic versioning:
- **Major** (1.x.x): Breaking changes
- **Minor** (x.1.x): New features, backwards compatible
- **Patch** (x.x.1): Bug fixes, backwards compatible
