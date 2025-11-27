# Bookstar

Bookstar adalah aplikasi toko buku berbasis Flutter. Repo ini berisi source code untuk mobile & web (Flutter). README ini membantu menjalankan, membuild, dan mendeploy versi web (Netlify) serta menjalankan aplikasi di Android Studio.

## Fitur
- Tampilan katalog buku
- Halaman detail buku
- Responsif untuk web & mobile
- Clean architecture 
- Deployable ke Netlify / hosting static lain

## Demo
- Production (Netlify): https://bookstar-app.netlify.app/
- Download App : https://drive.google.com/drive/folders/1MtffvZL_3uTiBFwpQSe4ErJM7YhofPBJ?usp=sharing

## API
- https://bukuacak.vercel.app/api

## Design
- https://www.figma.com/design/v8xQnFgz0fjgGRMztjICtF/Slicing?node-id=5013-125&t=7VxICfrdAmGuWLa0-1

---

## Tech stack & dependencies
- Flutter (Dart) — UI framework utama
- Dart SDK (bundled with Flutter)
- Web output: HTML / JS (main.dart.js, flutter_bootstrap.js)
- Hosting: Netlify (static site hosting)
- State management : Getx

---

## Prasyarat (lokal) — versi yang direkomendasikan
- Flutter SDK (stable) - gunakan latest stable release
  - Install: https://flutter.dev/docs/get-started/install
- Android Studio (recommended) — untuk menjalankan/men-debug aplikasi Android
  - Android SDK & platform-tools (via SDK Manager)
  - Java JDK 11+ (disarankan JDK 11 atau JDK 17)
- Github
  
---

## Menjalankan aplikasi (development)

### Jalankan di VS Code / Terminal
- Jalankan di perangkat/emulator:
  ```bash
  flutter pub get
  flutter run
  ```
- Jalankan di Emulator (app):
  ```bash
  flutter emulators --launch <emulatorId>
  ```
- Jalankan di Chrome (web):
  ```bash
  flutter run -d chrome
  ```

---

## Build untuk Web (lokal)
1. Clean & ambil dependency:
   ```bash
   flutter clean
   flutter pub get
   ```
2. Build web (direkomendasikan menggunakan HTML renderer jika ada masalah Wasm/CanvasKit):
   ```bash
   # Rekomendasi: pakai html renderer untuk kompatibilitas lebih luas
   flutter build web --release --web-renderer html
   # atau default release build
   flutter build web --release
   ```
3. Output akan ada di `build/web`:
   - `index.html`
   - `flutter_bootstrap.js`
   - `main.dart.js`
   - `manifest.json`
   - `assets/`

4. Test lokal (jangan buka file://):
   ```bash
   cd build/web
   python -m http.server 8000
   # buka http://localhost:8000 di browser
   ```

---

## Deploy ke Netlify (direkomendasikan: upload hasil build lokal)

Deploy manual via Netlify CLI
1. Build web secara lokal (lihat bagian Build untuk Web).
2. Install & login Netlify CLI (jika belum):
   ```bash
   npm i -g netlify-cli
   netlify login
   ```
3. Deploy:
   ```bash
   cd build/web
   netlify deploy --dir=.
   # untuk produksi:
   netlify deploy --prod --dir=.
   ```
Note: Jika ingin menggunakan cara lain dapat mencari step-by-step melalui youtube/sumber lainnya.

## Troubleshooting (umum)
- Blank page / Unexpected token '<':
  - Biasanya karena file JS (main.dart.js / flutter_bootstrap.js) tidak tersedia dan server mengembalikan index.html (rewrite error) → pastikan deploy upload file-file di `build/web`.
  - Pastikan redirect `_redirects` benar (Netlify) dan file statis tersedia.
- manifest.json 401:
  - Pastikan site Netlify bersifat publik (Site settings → Access control).
- Service Worker cache:
  - Buka DevTools → Application → Service Workers → Unregister, lalu hard refresh (Ctrl+Shift+R) atau buka incognito.
- Jika build gagal di CI (flutter: command not found):
  - Pastikan build command meng-clone Flutter dan men-setup PATH di satu shell, atau preferensi: build lokal & upload static.

---
