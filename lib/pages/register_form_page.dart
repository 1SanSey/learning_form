import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/user.dart';
import 'user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  User newUser = User();

  bool _hidePass = true;
  bool _hideConfirmPass = true;

  final List<String> _countries = [
    'Russia',
    'Ukraine',
    'USA',
    'Germany',
    'Select your Country'
  ];
  String _selectedCountry = 'Select your Country';

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _lsController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _lsController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              validator: _validateName,
              onSaved: (value) => newUser.name = value!,
              decoration: InputDecoration(
                label: const Text('Full Name *'),
                hintText: 'What is your name?',
                helperText: 'Enter your name',
                prefixIcon: const Icon(
                  Icons.person_outlined,
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                suffixIcon: GestureDetector(
                    onTap: _nameController.clear,
                    child: Icon(Icons.delete_outlined,
                        color: Colors.amber.shade900)),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onSaved: (value) => newUser.phone = value!,
              decoration: InputDecoration(
                labelText: 'Phone Number *',
                hintText: 'What is your phone number?',
                helperText: 'Enter your phone number',
                prefixIcon: const Icon(Icons.phone_outlined),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                suffixIcon: GestureDetector(
                    onTap: _phoneController.clear,
                    child: Icon(Icons.delete_outlined,
                        color: Colors.amber.shade900)),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              //validator: _validateEmail,
              onSaved: (value) => newUser.email = value!,
              decoration: InputDecoration(
                labelText: 'Email Adress',
                hintText: 'What is your email?',
                helperText: 'Enter your email adress',
                icon: const Icon(Icons.mail_outline),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                suffixIcon: GestureDetector(
                    onTap: _emailController.clear,
                    child: Icon(Icons.delete_outlined,
                        color: Colors.amber.shade900)),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: 'Select your Country',
              ),
              icon: const Icon(Icons.location_on),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (country) {
                print(country);
                setState(() {
                  _selectedCountry = country as String;
                  newUser.country = country;
                });
              },
              value: _selectedCountry,
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              controller: _lsController,
              inputFormatters: [LengthLimitingTextInputFormatter(120)],
              onSaved: (value) => newUser.story = value!,
              decoration: InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell us about yourself',
                helperText: 'Tell us about yourself',
                icon: const Icon(Icons.edit),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                suffixIcon: GestureDetector(
                    onTap: _lsController.clear,
                    child: Icon(Icons.delete_outlined,
                        color: Colors.amber.shade900)),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              focusNode: _passFocus,
              obscureText: _hidePass,
              maxLength: 8,
              controller: _passController,
              validator: _validatePassword,
              decoration: InputDecoration(
                labelText: 'Password *',
                hintText: 'Enter your password',
                helperText: 'Come up with a password max of 8 characters',
                icon: const Icon(Icons.lock_outline),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: _hideConfirmPass,
              maxLength: 8,
              controller: _confirmPassController,
              validator: (value) {
                if (value != _passController.text) {
                  return 'The entered passwords do not match';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: 'Confirm your password *',
                hintText: 'Repeat your password',
                helperText: 'The characters entered must match',
                icon: const Icon(Icons.check_box_outlined),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _hideConfirmPass = !_hideConfirmPass;
                      });
                    },
                    icon: Icon(_hideConfirmPass
                        ? Icons.visibility
                        : Icons.visibility_off)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Submit Form'),
              onPressed: () {
                _submitForm();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Country: ${_selectedCountry}');
      print('Life story: ${_lsController.text}');
    } else {
      _showMessage(message: 'Form is not valid!');
    }
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value!.isEmpty) {
      return 'Name is required!';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter aphabetical chracters!';
    } else {
      return null;
    }
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email can not be empty!';
    } else if (!value.contains('@')) {
      return 'Invalid email adress!';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password can not be empty!';
    } else if (value.length != 8) {
      return '8 characters required for a password!';
    } else {
      return null;
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Registration successful',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: Text(
            '$name is now a verified register form',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage(
                      userInfo: newUser,
                    ),
                  ),
                );
              },
              child: const Text(
                'Verified',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
