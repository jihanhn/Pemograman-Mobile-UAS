import 'package:flutter/material.dart';
import 'package:sleep_panda/const.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sleep_panda/screens/gender_choise.dart';

class WelcomeName extends StatefulWidget {
  const WelcomeName({super.key});

  @override
  State<WelcomeName> createState() => _WelcomeNameState();
}

class _WelcomeNameState extends State<WelcomeName> {
  late Box box; // Box untuk menyimpan data
  final TextEditingController _nameController =
      TextEditingController(); // Controller untuk TextFormField

  @override
  void initState() {
    super.initState();
    loadHive(); // Memuat Hive Box saat inisialisasi
  }

  // Fungsi untuk membuka Hive Box
  Future<void> loadHive() async {
    box = await Hive.openBox('data');
  }

  // Fungsi untuk menyimpan nama ke dalam Hive Box
  void saveName() {
    final name = _nameController.text;
    if (name.isNotEmpty) {
      box.put('nama', name);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama berhasil disimpan!')),
      );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GenderChoice(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tidak boleh kosong!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Selamat Datang di atas
            const Text(
              'Selamat datang di Sleepy Panda!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kita kenalan dulu yuk!, Siapa nama kamu?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(), // Spacer untuk mendorong elemen berikutnya ke tengah
            // Bagian TextFormField di tengah
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      onSaved: (newValue) {
                        saveName();
                      },
                      onFieldSubmitted: (value) {
                        saveName();
                      },
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Nama Kamu',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xff272E49),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const Spacer(), // Spacer untuk menjaga proporsi di bawah
          ],
        ),
      ),
    );
  }
}
