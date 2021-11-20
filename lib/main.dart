import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:postapi/provider.dart';
import 'package:postapi/repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
        ],
        child: MaterialApp(
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Image.asset('assets/images/mlogo.png'),
        SizedBox(
          height: 40,
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  controller: _phoneController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(hintText: 'Enter Phone'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Phone';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(hintText: 'Enter Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.pushNamed(context, '/'),
                    ),
                    ElevatedButton(
                      child: Text('Login'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, try to log in

                          login(context);
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    ));
  }

  void login(context) async {
    String phone = _phoneController.text;
    String password = _passwordController.text;
    await Provider.of<UserProvider>(context, listen: false)
        .login(phone, password);
    final userData = Provider.of<UserProvider>(context, listen: false);

    final currentUser = userData.getUser;
    final authToken = currentUser!.authToken;
    if (authToken != null) {
      print("login successful!");
    } else {
      print("login failed");
      //Display Error

    }
  }
}
