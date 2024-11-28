import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propertyapp/login.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late final String name;
  late final String fathername;
  late final String contact;
  late final String email;
  late final String password;
  late final String confirmpassword;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController fathernamecontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  bool isObscure = true;

  // Future<void> AddUsers() {
  //   return users
  //       .add({
  //         'name': namecontroller.text,
  //         'fathername': fathernamecontroller.text,
  //         'contact': contactcontroller.text,
  //         'email': emailcontroller.text,
  //         'password': passwordcontroller.text,
  //         'confirmpassword': confirmpasswordcontroller.text,
  //       })
  //       .then(
  //         (value) => ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('User Registered'),
  //             backgroundColor: Colors.blue,
  //           ),
  //         ),
  //       )
  //       .catchError(
  //         (error) => ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Exception has Occured'),
  //             backgroundColor: Colors.red,
  //           ),
  //         ),
  //       );
  // }

  // CollectionReference users =
  //     FirebaseFirestore.instance.collection('Register_Users');
  Future<void> RegisterUser() async {
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );

      await FirebaseFirestore.instance
          .collection('Register_Users')
          .doc(userCredential.user!.uid)
          .set({
        'name': namecontroller.text,
        'fathername': fathernamecontroller.text,
        'contact': contactcontroller.text,
        'email': emailcontroller.text,
        'password': passwordcontroller.text,
        'confirmpassword': confirmpasswordcontroller.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful'),
          backgroundColor: Colors.blue,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: namecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        label: const Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Mulish',
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Eg. Burhan Ali',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: fathernamecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        label: const Text(
                          'Father Name',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Mulish',
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Enter your Father Name',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: contactcontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.call),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        label: const Text(
                          'Contact',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Mulish',
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Eg: 0311-12345678',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailcontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        label: const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Mulish',
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Eg: abc@gmail.com',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordcontroller,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        label: const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Mulish',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: confirmpasswordcontroller,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        label: const Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Mulish',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        RegisterUser();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 15, fontFamily: 'Mulish'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Aleady have an account?',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
