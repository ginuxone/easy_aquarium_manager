import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  bool obscurePW;
  Icon icon;
  @override
  void initState() {
    super.initState();
    obscurePW=true;
    icon=Icon(Icons.remove_red_eye);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        shrinkWrap: true,
        children:[
          Container(
            height: 200,
            child: Image.asset("assets/logo/logoNB.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text("Easy Aquarium Manager",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          Divider(),
          Card(
            margin: EdgeInsets.all(10.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction, 
              child:Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15,top: 15),
                    child: Text("Login",style: TextStyle(fontSize:18),),
                  ),
                  Divider(),
                  TextFormField(
                    controller:usernameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "username@something.com",
                      suffixIcon: Icon(Icons.alternate_email)
                    ),
                    validator: (value){
                      if(value.isEmpty)
                        return "SomethingWroung";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller:passwordController,
                    obscureText: obscurePW,
                    obscuringCharacter: "*",
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "******",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: (){
                          setState(() {
                            obscurePW=!obscurePW;
                            icon=Icon(Icons.remove_red_eye_outlined);
                          });
                        }
                      ),
                    ),
                    validator: (value){
                      if(value.isEmpty)
                        return "SomethingWroung";
                      return null;
                    },
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        color: Colors.red,
                        child: Text("Cancel"),
                        onPressed: (){
                          setState(() {
                            usernameController.clear();
                            passwordController.clear();
                          });
                        }
                      ),
                      RaisedButton(
                        color: Colors.green,
                        child: Text("Login"),
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            print("awesome");
                          }
                        }
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),
          
          Divider(color: Colors.grey,),
          Text("You dont have an account? Register"),
          RaisedButton(
            color: Colors.lightBlue,
            child: Text("Register"),
            onPressed: (){
              Navigator.pushNamed(context,'Register');
            }
          ),
        ]
      ),
    );
  }
}
            