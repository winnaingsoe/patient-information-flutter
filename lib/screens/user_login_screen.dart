import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_information/models/user.dart';
import 'package:patient_information/provider/user_provider.dart';
import 'package:patient_information/screens/home_screen.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  late UserProvider userLoginProvider;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isSuccess = false;

  Future userLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var user = User(
        name: _nameController.text,
        password: _passwordController.text,
      );
      isSuccess = await userLoginProvider.login(user);
      debugPrint("isSucces $isSuccess");
      if (isSuccess) {
        setState(() {});
      } else {
        Fluttertoast.showToast(
            msg: 'Something went Wrong!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    }
  }

  @override
  void initState() {
    userLoginProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name'),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter your name';
                    }
                    return null;
                  },
                ),
                const Text('Password'),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                  ),
                  maxLength: 8,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter your password';
                    } else if (value.length > 8) {
                      return '*Please enter your password at least 8 chracters';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      await userLogin(context);
                      if (isSuccess) {
                        Fluttertoast.showToast(
                            msg: 'Success Login',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.black,
                            textColor: Colors.white);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      }
                    },
                    child: const Text('Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
