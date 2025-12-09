# VNS.MultiLanguageTextbox

Et Umbraco 14+ property editor plugin til håndtering af flersproget tekstindhold.

> **Kompatibilitet:** Umbraco 14, 15, 16, 17+

## Funktioner

- 🌍 **Multi-sprog support** - Understøtter alle sprog konfigureret i Umbraco
- ✏️ **Fleksibel input** - Vælg mellem text input eller textarea
- 🔒 **Obligatoriske sprog** - Gør bestemte sprog påkrævet
- 🎨 **Moderne teknologi** - Bygget med Lit/TypeScript
- 📦 **Let installation** - Simpel App_Plugins struktur
- 💾 **JSON baseret** - Data gemmes som struktureret JSON

## Installation

### Metode 1: Fra færdigbyggede filer (anbefalet)

1. **Download seneste release** fra GitHub
2. **Kopier mappen** `dist/App_Plugins/VNS.MultiLanguageTextbox` til din Umbraco installations `wwwroot/App_Plugins/` mappe
3. **Genstart Umbraco** applikationen

### Metode 2: Byg fra kildekode

Hvis du vil bygge pluginet selv:

```bash
# 1. Clone eller download repository
git clone https://github.com/yourusername/VNS.MultiLanguageTextbox.git
cd VNS.MultiLanguageTextbox

# 2. Installer dependencies
npm install

# 3. Byg projektet
npm run publish

# 4. Kopier dist/App_Plugins/VNS.MultiLanguageTextbox til din Umbraco installation
cp -r dist/App_Plugins/VNS.MultiLanguageTextbox /path/to/umbraco/wwwroot/App_Plugins/
```

### Udvikling med watch mode

For automatisk rebuilding under udvikling:

```bash
npm run watch
```

## Brug i Umbraco

### 1. Opret en Data Type

1. Gå til **Settings** → **Data Types** i Umbraco backoffice
2. Klik på **Create** → **New Data Type**
3. Vælg **VNS Multi Language Textbox** som property editor
4. Konfigurer efter behov:
   - **Use text area**: Brug textarea i stedet for text input
   - **Make mandatory language(s) required**: Gør obligatoriske sprog påkrævet
5. Gem data typen med et passende navn

### 2. Tilføj til Document Type

1. Åbn din Document Type
2. Klik på **Add property**
3. Vælg den data type du oprettede i trin 1
4. Gem Document Type

### 3. Rediger indhold

Når du redigerer content i backoffice, vil du se:
- En tekstboks (eller textarea) for hvert sprog konfigureret i Umbraco
- Sprog navnet vist ved siden af hver boks
- Automatisk gem af alle sprog samtidigt

## Brug i Templates/Views (C#)

Property editoren gemmer data som JSON, men Umbraco håndterer automatisk at returnere den korrekte sprogvariant:

```csharp
@Model.Value<string>("propertyAlias")
```

Med ModelsBuilder:

```csharp
@Model.YourPropertyName
```

For at få værdier for alle sprog:

```csharp
@{
    var allLanguages = Model.Value<IEnumerable<dynamic>>("propertyAlias");
    foreach (var lang in allLanguages)
    {
        <p>@lang.culture: @lang.text</p>
    }
}
```

## Projekt Struktur

```
VNS.MultiLanguageTextbox/
├── src/
│   └── multilanguage-textbox-property-editor-ui.element.ts
├── dist/                           (genereret ved build)
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

Data gemmes i Umbraco database som JSON med følgende struktur:

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

## Udvikling & Bidrag

### Byg projektet

```bash
# Install dependencies
npm install

# Development build med watch
npm run watch

# Production build
npm run build

# Build og forbered distribution
npm run publish
# eller
./publish.sh
```

### Projekt Krav

- Node.js 16+ og npm
- TypeScript 5.3+
- Vite 5.0+
- Umbraco 14+ til test

### Tilpasning

Hovedfilen der kan tilpasses:
- **UI Component**: `src/multilanguage-textbox-property-editor-ui.element.ts`
- **Package Definition**: `umbraco-package.json`
- **Build Config**: `vite.config.ts`

## Teknologier

- **TypeScript 5.3+** - Type-safe udvikling
- **Lit** - Lightweight web components
- **Vite 5.0+** - Moderne build tool
- **Umbraco 14+ Backoffice APIs** - Native integration

## Kompatibilitet

| Umbraco Version | Status |
|----------------|---------|
| Umbraco 14     | ✅ Supported |
| Umbraco 15     | ✅ Supported |
| Umbraco 16     | ✅ Supported |
| Umbraco 17+    | ✅ Supported |
| Umbraco 13 eller ældre | ❌ Not supported |

## Support & Bidrag

- 🐛 **Bug reports**: Opret et issue på GitHub
- 💡 **Feature requests**: Opret et issue med label "enhancement"
- 🔀 **Pull requests**: Bidrag er velkomne!

## License

MIT License

## Author

Vital New Software Aps
Martin H. Schläger

---

**Lavet med ❤️ til Umbraco community**
