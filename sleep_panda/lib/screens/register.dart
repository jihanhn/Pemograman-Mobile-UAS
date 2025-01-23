import 'package:flutter/material.dart';
import 'package:sleep_panda/api/user.dart';
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/screens/login.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final _key = GlobalKey<FormState>();

  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/logo.png',
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Daftar menggunakan email yang valid',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  return null;
                },
                controller: _emailC,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color(0xff272E49),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    filled: true),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                  return null;
                },
                controller: _passC,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color(0xff272E49),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    filled: true),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: second,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        print('register');
                        var res = await register(_emailC.text, _passC.text);
                        if (res) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Berhasil registrasi, silahklan login!',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: second,
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Gagal registrasi',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Daftar')),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah Memiliki Akun?',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Masuk Sekarang',
                      style: TextStyle(color: second),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
