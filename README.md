# Lab Activity 2 - State Management

Repositori ini berisi dua proyek Flutter untuk mempelajari dan membandingkan dua pendekatan manajemen state:
1. **Ephemeral State Management** menggunakan `StatefulWidget`.
2. **App State Management** menggunakan paket `scoped_model`.

---

## Tujuan
- Memahami cara kerja **Ephemeral State Management** untuk mengelola state lokal di dalam widget tertentu.
- Mempelajari **App State Management** untuk mengelola state di seluruh aplikasi.
- Mengetahui perbedaan, kelebihan, dan kapan menggunakan masing-masing pendekatan.

---

## Struktur Proyek
Repositori ini terdiri dari dua folder utama:
- **ephemeral_state_codelab**: Contoh manajemen state lokal menggunakan `StatefulWidget`.
- **app_state_codelab**: Contoh manajemen state aplikasi menggunakan `scoped_model`.

---

## Penjelasan Proyek

### 1. **Ephemeral State Management (ephemeral_state_codelab)**
Proyek ini menunjukkan bagaimana menggunakan `StatefulWidget` untuk mengelola state lokal dalam aplikasi sederhana. Pendekatan ini cocok untuk widget yang tidak berbagi state dengan bagian lain dari aplikasi.

#### **Fitur Utama**:
- Menggunakan `StatefulWidget` untuk memanipulasi state lokal.
- Proyek sederhana, cocok untuk kebutuhan state yang terbatas.

#### **Kode Utama**:
```dart
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter Value: $_counter'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}
```
Untuk menjalankan aplikasi **Ephemeral State Management**, ikuti langkah-langkah berikut:
1. Jalankan aplikasi dengan perintah:
  ```bash
  flutter run
  ```

### 2. **App State Management (Scoped Model)**

Proyek ini menunjukkan bagaimana menggunakan paket `scoped_model` untuk mengelola state di seluruh aplikasi. Pendekatan ini lebih cocok untuk aplikasi kompleks yang membutuhkan state yang dapat diakses dari banyak widget atau layar.

---

## Fitur Utama
1. **Manajemen State Global**: Menggunakan `scoped_model` untuk menyimpan state aplikasi secara global.
2. **Akses State yang Mudah**: State dapat diakses dan dimodifikasi dari banyak widget tanpa perlu mempassing data secara manual.
3. **Notifikasi Perubahan State Otomatis**: UI diperbarui secara otomatis saat state berubah.

---

## Kode Utama
```dart
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final CounterModel model = CounterModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: model,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Scoped Model Example')),
          body: CounterWidget(),
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
      builder: (context, child, model) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter Value: ${model.counter}'),
            ElevatedButton(
              onPressed: () {
                model.increment();
              },
              child: Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () {
                model.decrement();
              },
              child: Text('Decrement'),
            ),
          ],
        ),
      ),
    );
  }
}
```
Untuk menjalankan aplikasi **App State Management**, ikuti langkah-langkah berikut:
1. Pastikan dependensi diunduh dengan menjalankan:
   ```bash
   flutter pub get
   ```
2. Jalankan aplikasi dengan perintah:
   ```bash
    flutter run
   ```

# Mengelola State di Flutter: Perbedaan dan Keunggulan App State Management  

## Pengantar  
Dalam pengembangan aplikasi menggunakan Flutter, pengelolaan state adalah bagian penting yang menentukan cara data diproses dan ditampilkan di aplikasi. Untuk aplikasi sederhana, menggunakan **Ephemeral State Management** berbasis `StatefulWidget` sudah mencukupi. Namun, aplikasi yang lebih kompleks membutuhkan pendekatan **App State Management** agar pengelolaan state lebih terorganisir dan efisien.  

---

## Perbandingan Antara Ephemeral dan App State Management  

| **Aspek**              | **Ephemeral State**                      | **App State Management**                   |
|-------------------------|------------------------------------------|---------------------------------------------|
| **Cakupan**            | Hanya berlaku dalam widget tertentu.     | Berlaku di seluruh aplikasi.               |
| **Cara Memperbarui UI** | Menggunakan `setState()`.                | Menggunakan mekanisme seperti `notifyListeners()`. |
| **Kemudahan Akses**     | Sulit untuk diteruskan ke widget lain.   | State dapat diakses dari mana saja.         |
| **Kompleksitas**        | Sederhana, cocok untuk aplikasi kecil.   | Lebih kompleks, cocok untuk aplikasi besar. |

---

## Mengapa Memilih App State Management?  

### 1. Pengelolaan State yang Terpusat  
- Semua state disimpan di satu tempat, sehingga pengelolaan menjadi lebih mudah.  
- **Contoh**: Dalam sistem login, status pengguna seperti **login** atau **logout** dapat dikelola dengan satu model, meminimalkan inkonsistensi.  

### 2. Berbagi Data dengan Mudah  
- State dapat digunakan oleh berbagai bagian aplikasi tanpa perlu meneruskan data secara manual antar-widget.  
- **Contoh**: Dalam aplikasi keranjang belanja, halaman produk, keranjang, dan checkout dapat mengakses informasi yang sama tanpa redundansi data.  

### 3. Performa yang Lebih Baik  
- Dengan menggunakan solusi seperti **scoped_model**, hanya bagian aplikasi yang memerlukan data tertentu yang akan diperbarui.  
- **Contoh**: Jika pengguna menambahkan produk ke keranjang, hanya ikon keranjang di header yang diperbarui, tanpa memengaruhi halaman produk.  

### 4. Solusi untuk Aplikasi Besar  
Pendekatan ini sangat membantu untuk aplikasi dengan banyak fitur atau kebutuhan data global, seperti:  
- **Otentikasi pengguna**: Memantau status login dan akses pengguna.  
- **Keranjang belanja**: Menyimpan dan memperbarui informasi barang di seluruh aplikasi.  
- **Notifikasi real-time**: Menyampaikan pesan atau pembaruan secara instan ke seluruh aplikasi.  

---

## Contoh Penggunaan App State Management  

### 1. Sistem Login  
State yang mengelola status login dan informasi pengguna disimpan di model global:  
- Halaman login dapat memperbarui status pengguna setelah berhasil masuk.  
- Halaman lain, seperti profil atau dashboard, langsung menggunakan informasi dari model tanpa memuat ulang data.  

### 2. Aplikasi Keranjang Belanja  
State yang menyimpan informasi keranjang meliputi:  
- Daftar barang yang ditambahkan.  
- Jumlah barang per produk.  
- Total harga pembelian.  
Semua bagian aplikasi, seperti halaman produk dan checkout, dapat menggunakan data yang sama untuk memastikan konsistensi.  

---

## Kesimpulan  
**App State Management** adalah pilihan terbaik untuk aplikasi kompleks dengan kebutuhan pengelolaan state global. Pendekatan ini cocok untuk:  
- Aplikasi e-commerce dengan fitur seperti keranjang belanja dan checkout.  
- Aplikasi multi-user dengan sistem login dan manajemen akses.  
- Aplikasi real-time yang membutuhkan pembaruan data secara cepat dan efisien.  

Menggunakan App State Management membantu pengembang menciptakan aplikasi yang lebih terstruktur, skalabel, dan mudah untuk dikembangkan di masa mendatang.
