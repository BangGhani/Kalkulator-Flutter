import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

// Aplikasi utama yang menjalankan kalkulator
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator iPhone', // Judul aplikasi
      theme: ThemeData(
        primaryColor: Colors.black, // Warna utama aplikasi
        scaffoldBackgroundColor: Colors.black, // Warna latar belakang
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Warna teks putih
        ),
      ),
      home: const Calculator(), // Menampilkan halaman kalkulator
    );
  }
}

// Widget kalkulator yang bisa mengubah nilai
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

// Status kalkulator, tempat kita mengelola perhitungan dan tampilan
class _CalculatorState extends State<Calculator> {
  String output = "0"; // Menyimpan nilai yang akan ditampilkan di layar

  // Fungsi untuk menangani tombol yang ditekan
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0"; // Reset kalkulator jika tombol C ditekan
      } else if (buttonText == "=") {
        // Jika tombol "=" ditekan, hitung hasilnya
        try {
          // Mengganti simbol 'x' dengan '*' dan '÷' dengan '/' untuk menghitung
          String formattedOutput = output.replaceAll("x", "*").replaceAll("÷", "/");
          output = evaluateExpression(formattedOutput); // Hitung hasil ekspresi
        } catch (e) {
          output = "Error"; // Jika ada kesalahan, tampilkan Error
        }
      } else if (output == "0") {
        output = buttonText; // Ganti angka 0 dengan angka yang ditekan
      } else {
        output += buttonText; // Tambahkan angka yang ditekan ke output
      }
    });
  }

  // Fungsi untuk menghitung ekspresi matematika
  String evaluateExpression(String expression) {
    final parsedExpression = Expression.parse(expression); // Parsing ekspresi
    const evaluator = ExpressionEvaluator(); // Evaluator untuk menghitung
    final result = evaluator.eval(parsedExpression, {});
    return result.toString(); // Kembalikan hasilnya
  }

  // Membuat tombol kalkulator
  Widget buildButton(String buttonText, Color color, {double widthFactor = 1.0}) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 22), // Menambah padding
            backgroundColor: color, // Warna tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0), // Membuat sudut tombol melengkung
            ),
            elevation: 0, // Menghapus bayangan tombol
          ),
          onPressed: () => buttonPressed(buttonText), // Fungsi saat tombol ditekan
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 28, // Ukuran font pada tombol
              fontWeight: FontWeight.w400,
              color: Colors.white, // Warna teks tombol
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Menampilkan output kalkulator
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 24, bottom: 24),
              alignment: Alignment.bottomRight,
              child: Text(
                output, // Tampilkan hasil kalkulasi atau input
                style: const TextStyle(fontSize: 80, color: Colors.white),
              ),
            ),
          ),
          // Grid tombol kalkulator
          Column(
            children: [
              Row(
                children: [
                  buildButton("C", Colors.grey.shade600),
                  buildButton("+/-", Colors.grey.shade600),
                  buildButton("%", Colors.grey.shade600),
                  buildButton("÷", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("7", Colors.grey.shade600),
                  buildButton("8", Colors.grey.shade600),
                  buildButton("9", Colors.grey.shade600),
                  buildButton("x", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.grey.shade600),
                  buildButton("5", Colors.grey.shade600),
                  buildButton("6", Colors.grey.shade600),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.grey.shade600),
                  buildButton("2", Colors.grey.shade600),
                  buildButton("3", Colors.grey.shade600),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0", Colors.grey.shade600, widthFactor: 2),
                  buildButton(".", Colors.grey.shade600),
                  buildButton("=", Colors.orange),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
