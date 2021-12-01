import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:students_check/auth/auth_provider.dart';
import 'package:students_check/components/rounded_button.dart';
import 'package:students_check/constants.dart';
import 'package:students_check/pages/profile.dart';
import 'package:students_check/services/handle_error.dart';
import 'package:flutter_svg/flutter_svg.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Login extends StatefulWidget {

  static const String id = 'login';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

enum authProblems {
  userNotFound,
  userExist,
  passwordNotValid,
  networkError,
  tooManyRequests
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool showSpinner = false;
  final DateTime timestamp = DateTime.now();
  // authProblems errorType;
  ErrorHandler errorHandler = ErrorHandler();
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        color: kColor,
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    _showTitle(),
                    const SizedBox(height: 60.0),
                    _showImage(),
                    const SizedBox(height: 15.0),
                    _showEmailInput(),
                    const SizedBox(height: 15.0),
                    _showPasswordInput(),
                    _showButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showTitle(){
    return Text('Students Check', style: Theme.of(context).textTheme.headline3);
  }

  Widget _showImage() {
    return SvgPicture.asset('assets/images/login_img.svg', height: 260.0);
  }

  Widget _showEmailInput(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onSaved: (value) => _email = value!.trim(),
        validator: (value) => value!.isEmpty ? 'يرجى ادخال الايميل' : null,
        keyboardType: TextInputType.emailAddress,
        decoration: kTextFieldDecoration.copyWith(
            prefixIcon: const Icon(Icons.email),
            hintText: 'الايميل',
            labelText: 'الايميل'
        ),
        style: const TextStyle(
            height: 1.0,
            color: kColor
        ),
      ),
    );
  }

  Widget _showPasswordInput(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onSaved: (value) => _password = value!,
        validator: (value) => value!.isEmpty ? 'يرجى ادخال الباسوورد' : null,
        decoration: kTextFieldDecoration.copyWith(
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: GestureDetector(
              child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onTap: (){
                 setState(() {
                 _obscureText = !_obscureText;
                 });
              },
            ),
            hintText: 'الباسوورد',
            labelText: 'الباسوورد'
        ),
        obscureText: _obscureText,
        style: const TextStyle(
            height: 1.0,
            color: kColor
        ),
      ),
    );
  }

  Widget _showButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RoundedButton(
        title: 'الدخول',
        colour: kColor,
        onPressed: validateAndSubmit,
        size: 0,
      ),
    );
  }


  bool validateAndSave(){
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  validateAndSubmit() async {
    if(validateAndSave()){
      setState(() {
        showSpinner = true;
      });
      try{
        var auth = AuthProvider.of(context)!.auth;
          String user = await auth.signInWithEmailAndPassword(_email, _password).catchError((e){
            errorHandler.handleLoginError(context, e);
            print(e);
            setState(() {
              showSpinner = false;
            });
          });
          print(user);

        setState(() {
          showSpinner = false;
        });
        Navigator.of(context).pushNamed(Profile.id);

      }catch(e){
        print('Error: $e');
      }
    }
    else{
      print('Fail, email: $_email, password: $_password');
    }
  }
}

