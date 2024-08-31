import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController correctPassword=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.alternate_email),
                  labelText: "Email",
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null || value.isEmpty)
                    return "Please enter your mail";
                  return null;
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.lock),
                  labelText: "password",
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value ==null || value.isEmpty)
                    return "Please enter your password";
                  return null;
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.lock),
                  labelText: "Check password",
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value!=correctPassword.text)
                    return "Passwords should match";
                  return null;
                },
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text("Cancel"),
                    onPressed: (){

                    }
                  ),
                  ElevatedButton(
                    child: Text("Create Account"),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: username.text,
                          password: password.text,
                        ).then((value){
                          AlertDialog(
                            title: Text("Well Done"),
                            actions: [
                              TextButton.icon(
                                onPressed: (){
                                  FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: username.text,
                                    password: password.text,
                                  );
                                },
                                icon: Icon(Icons.label_important),
                                label: Text("Go to App"),
                              )
                            ],
                          );
                          }
                        );
                      }
                    }
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}