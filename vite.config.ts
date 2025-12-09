import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    lib: {
      entry: "src/vns-multilanguagetextbox-property-editor-ui.element.ts",
      formats: ["es"],
      fileName: "vns-multilanguagetextbox",
    },
    outDir: "dist/VNS.MultiLanguageTextbox",
    emptyOutDir: true,
    sourcemap: false,
    rollupOptions: {
      external: [/^@umbraco/],
    },
  },
  base: "/App_Plugins/VNS.MultiLanguageTextbox/",
});
