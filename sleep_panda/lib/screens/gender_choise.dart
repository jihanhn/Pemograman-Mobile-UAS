import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/screens/date_birth.dart';

class GenderChoice extends StatefulWidget {
  const GenderChoice({super.key});

  @override
  State<GenderChoice> createState() => _GenderChoiceState();
}

class _GenderChoiceState extends State<GenderChoice> {
  late Box box; // Box untuk menyimpan data
  String name = "Nama Kamu"; // Default teks jika nama belum dimuat
  final TextEditingController _nameController =
      TextEditingController(); // Controller untuk TextFormField

  var selectedGender = ""; // Menyimpan gender yang dipilih

  @override
  void initState() {
    super.initState();
    loadName(); // Memuat nama saat inisialisasi
  }

  // Fungsi untuk memuat nama dari Hive Box
  Future<void> loadName() async {
    box = await Hive.openBox('data'); // Buka Hive Box
    final storedName = box.get('nama', defaultValue: "Nama Kamu");
    setState(() {
      name = storedName;
      _nameController.text = storedName; // Set nilai awal di TextFormField
    });
  }

  // Fungsi untuk menyimpan nama ke Hive Box
  Future<void> saveName() async {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      await box.put('nama', newName);
      setState(() {
        name = newName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          box.put('gender', selectedGender);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DateBirthScreen(),
          ));
        },
        color: Colors.white,
        icon: Icon(
          Icons.navigate_next_sharp,
        ),
      ),
      backgroundColor: baseColor, // Warna dasar untuk latar belakang
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              'Hi, $name!', // Tampilkan nama dari Hive Box
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pilih gender kamu, agar kami bisa mengenal kamu lebih baik.',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          selectedGender = 'Pria'; // Update gender yang dipilih
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff272E49),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                          side: BorderSide(
                            color: selectedGender == 'Pria'
                                ? Colors.green // Border hijau jika dipilih
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/young-man.png',
                            height: 30,
                          ),
                          const Text(
                            'Pria',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Container()
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tombol Wanita
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          selectedGender = 'Wanita';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff272E49),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                          side: BorderSide(
                            color: selectedGender == 'Wanita'
                                ? Colors.green // Border hijau jika dipilih
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/businesswoman.png',
                            height: 30,
                          ),
                          const Text(
                            'Wanita',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Container()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
