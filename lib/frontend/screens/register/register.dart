import 'package:flutter/material.dart';
import 'package:guitarchords/backend/firebase/userregister.dart';
import 'package:guitarchords/frontend/screens/register/registercomplete.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

final fullname = TextEditingController();
final email = TextEditingController();
final password = TextEditingController();
final confirmpassword = TextEditingController();

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create your free account',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Do you already have an account? ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    child: const Text(
                      'sign in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 238, 20, 83),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: fullname,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(75, 224, 224, 224),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter your full name',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(99, 158, 158, 158)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Email address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(75, 224, 224, 224),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter your email',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(99, 158, 158, 158)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(75, 224, 224, 224),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter your password',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(99, 158, 158, 158)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: confirmpassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(75, 224, 224, 224),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Confirm your password',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(99, 158, 158, 158)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    activeColor: const Color.fromARGB(255, 238, 20, 83),
                    checkColor: Colors.white,
                    value: true,
                    onChanged: (value) {},
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: BorderSide(
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 182, 180, 181),
                    ),
                  ),
                  const Text(
                    'I agree to the ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    child: const Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 238, 20, 83),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? const Color.fromARGB(255, 238, 20, 83)
                            : const Color.fromARGB(255, 238, 20, 83),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    registerAccount(
                      context,
                      email: email.text,
                      password: password.text,
                      fullname: fullname.text,
                    ).then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterComplete(),
                        ),
                      );
                    }).whenComplete(
                      () => clearfeilds(),
                    );
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

clearfeilds() {
  fullname.clear();
  email.clear();
  password.clear();
  confirmpassword.clear();
}
