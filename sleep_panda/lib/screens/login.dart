import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sleep_panda/api/user.dart';
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/screens/home.dart';
import 'package:sleep_panda/screens/register.dart';
import 'package:sleep_panda/screens/welcome_name.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _key = GlobalKey<FormState>();
  final _keyForgetPassword = GlobalKey<FormState>();

  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passC = TextEditingController();
  final TextEditingController _emailForgetPass = TextEditingController();

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
                'Masuk menggunakan email yang valid',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _emailC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
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
                controller: _passC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
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
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Color(0xff272E49),
                    builder: (context) {
                      return SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _keyForgetPassword,
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Lupa Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Instruksi untuk melakukan reset password akan dikirim melalui email yang kamu gunakan untuk mendaftar.',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'email tidak boleh kosong';
                                      }
                                      return null;
                                    },
                                    controller: _emailForgetPass,
                                    style: TextStyle(color: Color(0xff272E49)),
                                    decoration: InputDecoration(
                                        hintText: 'Email',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Color(0xff272E49),
                                        ),
                                        filled: true),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            backgroundColor: second,
                                            foregroundColor: Colors.white),
                                        onPressed: () async {
                                          if (_keyForgetPassword.currentState!
                                              .validate()) {
                                            var res = await sendOtp(
                                                _emailForgetPass.text);
                                            if (res) {
                                              SnackBar(
                                                content: Text(
                                                  'Berhasil Mengirim Kode OTP',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor: baseColor,
                                              );
                                            } else {
                                              SnackBar(
                                                content: Text(
                                                  'Gagal mengirim code OTP cek email kamu!',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor: Colors.red,
                                              );
                                            }
                                          }
                                        },
                                        child: Text('Reset Password')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  textAlign: TextAlign.end,
                  'Lupa Password',
                  style: TextStyle(color: second),
                ),
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
                        var response = await login(_emailC.text, _passC.text);
                        if (response) {
                          var box = Hive.box('data');
                          box.put('email', _emailC.text);
                          box.put('password', _passC.text);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Berhasil login',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: baseColor,
                            ),
                          );
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WelcomeName(),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Gagal login harap check email atau password anda',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Masuk')),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum Memiliki Akun?',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Daftar Sekarang',
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
