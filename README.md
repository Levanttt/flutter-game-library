# flutter_game_library

> **Status: In Development** — fitur masih aktif dikerjakan, belum production-ready.

Personal game backlog tracker dibangun dengan Flutter. Track game yang sedang dimainkan dan antrian game berikutnya.

## Tech Stack

- Flutter (Dart)
- SharedPreferences untuk local storage
- Assets lokal untuk cover art

## Struktur Halaman

- **List Page** — grid game berdasarkan status (On Going / Next Up)
- **Detail Page** — info lengkap game, tap cover untuk lihat full-size
- **Avatar Page** — cover art full-size, tombol kembali langsung ke List Page

## Flow Navigasi

```
Splash Screen
    ↓
Onboarding (hanya pertama kali)
    ↓
Login
    ↓
Home (List Page)
```

Tombol "Kembali ke Daftar" di Avatar Page menggunakan `Navigator.popUntil` untuk skip Detail Page dan kembali langsung ke List Page.

## Fitur yang Akan Datang

- [ ] History page untuk game yang sudah ditamatkan
- [ ] Add game page, user bisa tambah game sendiri lewat tombol + di bottom nav
- [ ] Persistent data untuk game yang ditambah user, saat ini data game masih hardcode di kode
- [ ] Integrasi API eksternal seperti RAWG atau IGDB untuk ambil data game, cover art, genre, dan tahun rilis secara otomatis, sehingga user cukup cari judul game dan data terisi sendiri tanpa perlu input manual

## Cara Run

```bash
flutter pub get
flutter run
```

Credentials login sementara: `admin` / `1234`

## Testing Onboarding

Onboarding hanya muncul sekali saat pertama kali app diinstall. Untuk test ulang onboarding, hapus data app dulu di HP:

**Settings → Apps → flutter_game_library → Storage → Clear Data**

Setelah clear data, buka app lagi dan onboarding akan muncul kembali dari awal.
