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

**Perbandingan: Ephemeral vs App State Management**
| **Fitur**              | **Ephemeral State**                          | **App State Management**                    |
|------------------------|---------------------------------------------|---------------------------------------------|
| **Ruang Lingkup**       | Terbatas pada widget tertentu               | Dapat diakses di seluruh aplikasi          |
| **Kompleksitas**        | Sederhana                                   | Lebih kompleks                             |
| **Kegunaan**            | State widget tunggal                        | State aplikasi global                      |
| **Skalabilitas**        | Rendah                                      | Tinggi                                      |
| **Kemudahan Pengujian**| Dasar                                       | Lebih mudah diuji                          |

Untuk menjalankan aplikasi **App State Management**, ikuti langkah-langkah berikut:

1. Pastikan dependensi diunduh dengan menjalankan:
   ```bash
   flutter pub get

