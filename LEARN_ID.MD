# Cara memahami project ini
<b>Perhatian, gunakan proyek ini hanya sebagai panduan, jangan mengandalkan copy paste!</b>

## Mengapa ada file 'custom_drawer.dart'?
Kamu bisa baca di sini: https://www.dicoding.com/academies/199/tutorials/19832.
hasil akhir dari kursus tersebut akan menjadi seperti ini:
<p align="center">
    <img src="https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/academy/dos:3418aae7e5130f925d085a8a601f812d20210921110424.gif" width="500">
</p>

## Apa itu injection.dart yang ada di dalam direktori lib?

Silakan baca lebih lengkap di: https://www.dicoding.com/academies/199/tutorials/19357
>Dependency Injection (DI) adalah pola desain yang digunakan untuk mengimplementasikan Inversion of Control. Ini memungkinkan pembuatan objek dependen di luar kelas dan menyediakan objek tersebut ke kelas melalui berbagai cara. Menggunakan DI, kami memindahkan pembuatan dan pengikatan objek dependen di luar kelas yang bergantung padanya. Ini membawa tingkat fleksibilitas yang lebih tinggi, decoupling, dan pengujian yang lebih mudah.

## Mengapa harus menggunakan metode injeksi?
- Memudahkan testing
- Menghindari ketergantungan berlebihan pada kelas.


## Cara membuat project sebagai modular

info selengkapnya ada di:
- https://www.dicoding.com/academies/199/tutorials/19862
- https://medium.com/flutter-community/mastering-flutter-modularization-in-several-ways-f5bced19101a

## Apa itu modularisasi
> Pemrograman modular adalah teknik desain perangkat lunak untuk memisahkan fungsionalitas menjadi modul independen yang dapat dipertukarkan, sehingga masing-masing berisi semua yang diperlukan untuk menjalankan fungsionalitas tertentu.

<p align="center">
<img src="https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/academy/dos:7ffe87c509effa2964ae6dbeb41f461520210921141751.jpeg" height=200/>
</p>

Untuk memulai modularisasi pada flutter, silakan ikuti langkah-langkahnya [disini](https://www.dicoding.com/academies/199/tutorials/19877).

dasar perintah modularisasi adalah:
```bash
flutter create --template=package name_of_module
```

sebagai contoh:
```bash
# more info on: https://www.dicoding.com/academies/199/tutorials/19877
flutter create --template=package about
```

