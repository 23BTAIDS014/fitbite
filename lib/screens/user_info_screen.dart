import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import 'home_page.dart';

class UserInfoScreen extends StatefulWidget {
  final String name, email, password;
  const UserInfoScreen({
    required this.name,
    required this.email,
    required this.password,
    super.key,
  });

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey           = GlobalKey<FormState>();
  final ageCtrl            = TextEditingController();
  final heightCtrl         = TextEditingController();
  final weightCtrl         = TextEditingController();
  final allergiesCtrl      = TextEditingController();

  final _periods = ['Morning', 'Afternoon', 'Night'];
  String _period = 'Morning';
  TimeOfDay? _pickedTime;

  @override
  void dispose() {
    ageCtrl.dispose();
    heightCtrl.dispose();
    weightCtrl.dispose();
    allergiesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(context: context, initialTime: now);
    if (picked != null) setState(() => _pickedTime = picked);
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      if (_pickedTime == null) {
        Fluttertoast.showToast(
          msg: "Please select a time for $_period",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      final user = UserModel(
        name:      widget.name,
        email:     widget.email,
        password:  widget.password,
        age:       ageCtrl.text.trim(),
        height:    heightCtrl.text.trim(),
        weight:    weightCtrl.text.trim(),
        mealTime:  '$_period @ ${_pickedTime!.format(context)}',
        allergies: allergiesCtrl.text.trim(),
      );

      Fluttertoast.showToast(
        msg: "Profile saved!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(
          name:  user.name,
          email: user.email,
          password: user.password,
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf1f8e9), Color(0xFFdcedc8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Text('Tell us about you 🧑‍⚕️',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800)),
                  const SizedBox(height: 30),
                  _numField(ageCtrl,    'Age',        Icons.cake),
                  const SizedBox(height: 16),
                  _numField(heightCtrl, 'Height (cm)', Icons.height),
                  const SizedBox(height: 16),
                  _numField(weightCtrl, 'Weight (kg)', Icons.monitor_weight),
                  const SizedBox(height: 16),

                  /* Meal period dropdown */
                  DropdownButtonFormField<String>(
                    value: _period,
                    decoration: InputDecoration(
                      labelText: 'Usual Meal Period',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: _periods
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        _period = v!;
                        _pickedTime = null;      // reset old time
                      });
                      _pickTime();               // open clock picker
                    },
                  ),

                  if (_pickedTime != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text('Chosen time: ${_pickedTime!.format(context)}',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),

                  const SizedBox(height: 16),
                  _textField(allergiesCtrl, 'Any Allergies?', Icons.warning_amber_outlined,
                      optional: true),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Continue'),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* helpers */
  Widget _numField(TextEditingController c, String label, IconData icon) {
    return TextFormField(
      controller: c,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (v) =>
      (v == null || v.trim().isEmpty) ? 'Please enter your $label' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white.withAlpha(242),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _textField(TextEditingController c, String label, IconData icon,
      {bool optional = false}) {
    return TextFormField(
      controller: c,
      validator: (v) =>
      (!optional && (v == null || v.trim().isEmpty))
          ? 'Please enter your $label'
          : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white.withAlpha(242),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
