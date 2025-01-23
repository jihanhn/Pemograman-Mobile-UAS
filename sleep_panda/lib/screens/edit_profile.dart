import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sleep_panda/const.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Box box;

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() async {
    box = await Hive.openBox('data');
    setState(() {
      namaController.text = box.get('nama', defaultValue: '').toString();
      emailController.text = box.get('email', defaultValue: '').toString();
      genderController.text = box.get('gender', defaultValue: '').toString();
      dateOfBirthController.text = box.get('date', defaultValue: '').toString();
      heightController.text = box.get('tinggi', defaultValue: '').toString();
      weightController.text = box.get('berat', defaultValue: '').toString();
      profileImagePath = box.get('profileImagePath', defaultValue: null);
    });
  }

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImagePath = pickedFile.path;
      });
    }
  }

  void _saveProfileData() {
    box.put('nama', namaController.text);
    box.put('email', emailController.text);
    box.put('gender', genderController.text);
    box.put('date', dateOfBirthController.text);
    box.put('tinggi', heightController.text);
    box.put('berat', weightController.text);
    box.put('profileImagePath', profileImagePath);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile data saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipOval(
                    child: profileImagePath != null
                        ? Image.file(
                            File(profileImagePath!),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/default.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xffFFC754),
                      radius: 15,
                      child: IconButton(
                        onPressed: _pickProfileImage,
                        icon: const Icon(
                          Icons.edit,
                          color: baseColor,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildInputField(
              label: 'Nama',
              controller: namaController,
              prefixIcon: Icons.person_outline,
            ),
            _buildInputField(
              label: 'Email',
              controller: emailController,
              prefixIcon: Icons.email_outlined,
            ),
            _buildInputField(
              label: 'Gender',
              controller: genderController,
              prefixIcon: Icons.transgender,
              onTap: () => _selectGender(),
            ),
            _buildInputField(
              label: 'Date of Birth',
              controller: dateOfBirthController,
              prefixIcon: Icons.calendar_today,
              onTap: () => _selectDate(),
            ),
            _buildInputField(
              label: 'Height',
              controller: heightController,
              prefixIcon: Icons.height,
            ),
            _buildInputField(
              label: 'Weight',
              controller: weightController,
              prefixIcon: Icons.fitness_center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xff009090),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _saveProfileData,
                  child: const Text('Save'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData prefixIcon,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: controller,
              readOnly: onTap != null,
              onTap: onTap,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: const TextStyle(color: Colors.white),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                fillColor: const Color(0xff272E49),
                prefixIcon: Icon(prefixIcon, color: Colors.white),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        dateOfBirthController.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  void _selectGender() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Gender'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Pria'),
              onTap: () {
                setState(() {
                  genderController.text = 'Pria';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Wanita'),
              onTap: () {
                setState(() {
                  genderController.text = 'Wanita';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
