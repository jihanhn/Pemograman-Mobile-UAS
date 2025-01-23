import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/screens/hight_body.dart'; // Import intl package for date formatting

class DateBirthScreen extends StatefulWidget {
  const DateBirthScreen({super.key});

  @override
  State<DateBirthScreen> createState() => _DateBirthScreenState();
}

class _DateBirthScreenState extends State<DateBirthScreen> {
  late Box box;
  final TextEditingController _dateController =
      TextEditingController(); // Controller for the Date Form Field

  @override
  void initState() {
    super.initState();
    loadName(); // Load any data from Hive if necessary
  }

  // Function to load any data from Hive Box
  Future<void> loadName() async {
    box = await Hive.openBox('data');
  }

  // Function to show the date picker and update the date field
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Format the selected date
      final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      _dateController.text =
          formattedDate; // Update the TextField with the selected date
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          box.put('date', _dateController.text);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HeightBodyScreen(),
          ));
        },
        color: Colors.white,
        icon: const Icon(
          Icons.navigate_next_sharp,
        ),
      ),
      backgroundColor: baseColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Terimakasih!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sekarang, Kapan tanggal lahir mu?',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _selectDate(context); // Show the date picker when clicked
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _dateController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Tanggal Lahir',
                          alignLabelWithHint: true,
                          hintStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xff272E49),
                          filled: true,
                        ),
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
