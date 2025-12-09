# VNS.MultiLanguageTextbox

An Umbraco 14+ property editor plugin for handling multi-language text content.

> **Compatibility:** Umbraco 14, 15, 16, 17+

## Features

- 🌍 **Multi-language support** - Supports all languages configured in Umbraco
- ✏️ **Flexible input** - Choose between text input or textarea
- 🔒 **Required languages** - Make specific languages mandatory
- 🎨 **Modern technology** - Built with Lit/TypeScript
- 📦 **Easy installation** - Simple App_Plugins structure
- 💾 **JSON based** - Data stored as structured JSON
- 🤝 **Works great with [VNS.Umbraco](https://www.nuget.org/packages/VNS.Umbraco)** - Seamless integration with the VNS.Umbraco package

## Installation

### Method 1: From pre-built files (recommended)

1. **Download the latest release** from GitHub
2. **Copy the folder** `dist/App_Plugins/VNS.MultiLanguageTextbox` to your Umbraco installation's `wwwroot/App_Plugins/` folder
3. **Restart your Umbraco** application

### Method 2: Build from source

If you want to build the plugin yourself:

```bash
# 1. Clone or download the repository
git clone https://github.com/yourusername/VNS.MultiLanguageTextbox.git
cd VNS.MultiLanguageTextbox

# 2. Install dependencies
npm install

# 3. Build the project
npm run publish

# 4. Copy dist/App_Plugins/VNS.MultiLanguageTextbox to your Umbraco installation
cp -r dist/App_Plugins/VNS.MultiLanguageTextbox /path/to/umbraco/wwwroot/App_Plugins/
```

### Development with watch mode

For automatic rebuilding during development:

```bash
npm run watch
```

## Usage in Umbraco

### 1. Create a Data Type

1. Go to **Settings** → **Data Types** in Umbraco backoffice
2. Click **Create** → **New Data Type**
3. Select **VNS Multi Language Textbox** as property editor
4. Configure as needed:
   - **Use text area**: Use textarea instead of text input
   - **Make mandatory language(s) required**: Make mandatory languages required
5. Save the data type with an appropriate name

### 2. Add to Document Type

1. Open your Document Type
2. Click **Add property**
3. Select the data type you created in step 1
4. Save Document Type

### 3. Edit content

When editing content in the backoffice, you will see:
- A text box (or textarea) for each language configured in Umbraco
- The language name displayed next to each box
- Automatic saving of all languages simultaneously

## Usage in Templates/Views (C#)

The property editor stores data as JSON, but Umbraco automatically handles returning the correct language variant:

```csharp
@Model.Value<string>("propertyAlias")
```

With ModelsBuilder:

```csharp
@Model.YourPropertyName
```

### Using with VNS.Umbraco

If you're using the [VNS.Umbraco](https://www.nuget.org/packages/VNS.Umbraco) package, you can use the convenient `GetCultureText` utility method to extract culture-specific text from the JSON data:

```csharp
@using VNS.Umbraco

@{
    // Get text for current culture - no need to cast or check for null
    var text = Util.GetCultureText(Model.Value("propertyAlias"));
    
    // Or get text for a specific culture
    var danishText = Util.GetCultureText(Model.Value("propertyAlias"), "da-DK");
    var englishText = Util.GetCultureText(Model.Value("propertyAlias"), "en-US");
}

<p>@text</p>
```

### Manual parsing

To get values for all languages without VNS.Umbraco:

```csharp
@{
    var allLanguages = Model.Value<IEnumerable<dynamic>>("propertyAlias");
    foreach (var lang in allLanguages)
    {
        <p>@lang.culture: @lang.text</p>
    }
}
```

## Project Structure

```
VNS.MultiLanguageTextbox/
├── src/
│   └── multilanguage-textbox-property-editor-ui.element.ts
├── dist/                           (generated at build)
│   └── App_Plugins/
│       └── VNS.MultiLanguageTextbox/
│           ├── vns.multilanguagetextbox.js
│           └── umbraco-package.json
├── umbraco-package.json
├── package.json
├── tsconfig.json
├── vite.config.ts
├── publish.sh
├── .gitignore
├── LICENSE
└── README.md
```

## Data Format

Data is stored in the Umbraco database as JSON with the following structure:

```json
[
  {
    "culture": "da-DK",
    "text": "Dansk tekst"
  },
  {
    "culture": "en-US",
    "text": "English text"
  }
]
```

## Development & Contributing

### Build the project

```bash
# Install dependencies
npm install

# Development build with watch
npm run watch

# Production build
npm run build

# Build and prepare distribution
npm run publish
# or
./publish.sh
```

### Project Requirements

- Node.js 16+ and npm
- TypeScript 5.3+
- Vite 5.0+
- Umbraco 14+ for testing

### Customization

Main files that can be customized:
- **UI Component**: `src/multilanguage-textbox-property-editor-ui.element.ts`
- **Package Definition**: `umbraco-package.json`
- **Build Config**: `vite.config.ts`

## Technologies

- **TypeScript 5.3+** - Type-safe development
- **Lit** - Lightweight web components
- **Vite 5.0+** - Modern build tool
- **Umbraco 14+ Backoffice APIs** - Native integration

## Compatibility

| Umbraco Version | Status |
|----------------|---------|
| Umbraco 14     | ✅ Supported |
| Umbraco 15     | ✅ Supported |
| Umbraco 16     | ✅ Supported |
| Umbraco 17+    | ✅ Supported |
| Umbraco 13 or older | ❌ Not supported |

## Support & Contributing

- 🐛 **Bug reports**: Create an issue on GitHub
- 💡 **Feature requests**: Create an issue with label "enhancement"
- 🔀 **Pull requests**: Contributions are welcome!

## License

MIT License

## Author

Vital New Software Aps
Martin H. Schläger

---

**Made with ❤️ for the Umbraco community**
