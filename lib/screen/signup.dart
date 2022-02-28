import 'package:ecommerce/auth_methods/Register.dart';
import 'package:ecommerce/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class sigup extends StatefulWidget {
  @override
  static const routeName = '/sigup';
  _sigupState createState() => _sigupState();
}

class _sigupState extends State<sigup> {
  final mainColor = Color.fromRGBO(87, 87, 243, 1);
  bool _showsee = true;
  bool _notshowsee = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _submit() {
    if (!_formKey.currentState.validate()) {
      return false;
    }
    _formKey.currentState.save();
//    Navigator.of(context).pushNamed(Home.routeName);
    return true;
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget _buildLogo() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image.network(
                "https://c.top4top.io/p_18045nrfk1.png",
                height: MediaQuery.of(context).size.height / 4,
              ))
        ],
      ),
    );
  }

  Widget _buildInfoRows(bool isEmail, TextEditingController controller,String label,IconData icon,TextInputType type) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: mainColor,
            ),
            labelText:label
        ),
        validator: (value) {
          if(isEmail == true){
            if (value.isEmpty || !value.contains('@')) {
              return 'Invalid email!';
            }else{
              return null;
            }
          }else{
            if (value.isEmpty) {
              return 'Name required';
            }else{
              return null;
            }
          }

        },
        onSaved: (_) {},
      ),
    );
  }

  Widget _buildPasswordRows(TextEditingController controller,String label) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        obscureText: _showsee,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: label,
          suffixIcon: _showsee
              ? IconButton(
                  icon: Icon(Icons.remove_red_eye, color: mainColor),
                  onPressed: () {
                    setState(() {
                      _showsee = _notshowsee;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.remove_red_eye_outlined, color: mainColor),
                  onPressed: () {
                    setState(() {
                      _showsee = true;
                    });
                  },
                ),
        ),
        validator: (value) {
          if (value.isEmpty || value.length < 5) {
            return 'Password is too short!';
          }else{
            return null;
          }
        },
        onSaved: (_) {
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 80,right: 80),
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color:mainColor)
        ),
        onPressed:()async{
          if(_submit()){
            try{
              if(_passwordController.text == _confirmPasswordController.text){
                User user = User(email: _emailController.text,password: _passwordController.text);
                 var token =await registerUser(user);
                 if(token !=null){
                   SharedPreferences prefs = await SharedPreferences.getInstance();
                   prefs.setString("token",token['token']);
                   print('the new token is ${prefs.getString("token")}');
                   Navigator.of(context).pushReplacementNamed(Home.routeName);
                 }
              }else{
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Passwords don't match"),
                ));
              }
            }catch(ex){
              print(ex);
            }
          }
        },
        child: Center(
          child: Text('Login',style: TextStyle(
            color: mainColor,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
        ),

      ),
    );
  }

  Widget _buildContainer() {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.555,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildInfoRows(true,_emailController, "Email",Icons.alternate_email, TextInputType.emailAddress),
                        _buildInfoRows(false,_nameController, "Name",Icons.person, TextInputType.text),
                        _buildPasswordRows(_passwordController, "Password"),
                        _buildPasswordRows(_confirmPasswordController, "Confirm Password"),
                        _buildLoginButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: FlatButton(
            onPressed: () {

            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Dont have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height / 35,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: MediaQuery.of(context).size.height / 35,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
       
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  _buildContainer(),
                  _buildSignUpBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}