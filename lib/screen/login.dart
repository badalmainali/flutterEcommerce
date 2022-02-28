import 'package:ecommerce/auth_methods/Login.dart';
import 'package:ecommerce/model/user.dart';
import 'package:ecommerce/screen/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class login extends StatefulWidget {
  @override
  static const routeName = '/login';

  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final mainColor = Color.fromRGBO(87, 87, 243, 1);
  bool _showsee = true;
  bool _notshowsee = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _submit() {
    if (!_formKey.currentState.validate()) {
      return false;
    }
    _formKey.currentState.save();
    Navigator.of(context).pushNamed(Home.routeName);
    return true;
  }

  Widget _buildLogo() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image.network(
                "https://c.top4top.io/p_18045nrfk1.png",
                height: MediaQuery.of(context).size.height / 3,
              ))
        ],
      ),
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: mainColor,
            ),
            labelText: 'E-mail'),
        validator: (value) {
          if (value.isEmpty || !value.contains('@')) {
            return 'Invalid email!';
          }else{
            return null;
          }
        },
        onSaved: (_) {},
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: _passwordController,
        keyboardType: TextInputType.text,
        obscureText: _showsee,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Password',
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
        onSaved: (_) {},
      ),
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: ()async{
             try{
               if(_submit()) {
                 User user = User(email: _emailController.text,password: _passwordController.text);
                 var token = await loginUser(user);
                 if(token != null){
                   SharedPreferences prefs = await SharedPreferences.getInstance();
                   prefs.setString("token",token['token']);
                   print('the new sign in token is ${prefs.getString("token")}');
                   Navigator.of(context).pushReplacementNamed(Home.routeName);
                 }
               }else{
                 _scaffoldKey.currentState.showSnackBar(SnackBar(
                   content: Text("Login failed"),
                 ));
               }
             }catch(ex){
               print(ex);
             }
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            '- OR -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSocialBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: mainColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0)
              ],
            ),
            child: Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
          ),
        )
      ],
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
                height: MediaQuery.of(context).size.height * 0.5,
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
                        _buildEmailRow(),
                        _buildPasswordRow(),
                        _buildLoginButton(),
                         _buildOrRow(),
                         _buildSocialBtnRow(),
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
          padding: EdgeInsets.only(top: 15),
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(sigup.routeName);
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
                  text: 'Sign Up',
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
        
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
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
