import 'package:flutter/material.dart';

class Forms extends StatelessWidget {
  const Forms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forms")),
      body: Column(children: [Form1()]),
    );
  }
}

class Form1 extends StatelessWidget {
  const Form1({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              // initialValue: 'Name',
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email, abc@mail.com';
                }
                return null;
              },
              decoration: InputDecoration(
                hint: Text(
                  'Enter your email',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              onTap: () {
                print('Email field tapped');
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(onPressed: (){
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Processing Data')),
                );
              }else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Text Validation Failed')),
                );
              }
            }, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
