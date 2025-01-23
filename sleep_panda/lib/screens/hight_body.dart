import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/screens/weight_body.dart';

class HeightBodyScreen extends StatefulWidget {
  const HeightBodyScreen({super.key});

  @override
  State<HeightBodyScreen> createState() => _HeightBodyScreenState();
}

class _HeightBodyScreenState extends State<HeightBodyScreen> {
  int _height = 150; // Default height
  late Box box; // Box untuk menyimpan data

  @override
  void initState() {
    super.initState();
    loadHive();
  }

  loadHive() async {
    box = await Hive.openBox('data'); // Buka Hive Box
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () async {
          await box.put('tinggi', _height);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeightBodyScreen(),
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
              'Selanjutnya',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Berapa tinggi badan mu?',
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0), // Adding padding to the sides
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100, // Adjust width to match the text size
                          child: CupertinoPicker(
                            diameterRatio:
                                1.1, // Slightly adjusted for a better look
                            itemExtent:
                                40, // Increased item size for better visibility
                            useMagnifier:
                                true, // Make selected item larger for better focus
                            magnification:
                                1.3, // Adjust the size of the selected item
                            onSelectedItemChanged: (int index) {
                              setState(() {
                                _height =
                                    100 + index; // Start from 100 cm to 250 cm
                              });
                            },
                            children: List.generate(151, (index) {
                              return Center(
                                child: Text(
                                  '${100 + index}', // Added 'cm' to make it clearer
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        22, // Increased font size for readability
                                    fontWeight: index ==
                                            _height -
                                                100 // Highlight the selected item
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        Text(
                          'Cm',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
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
