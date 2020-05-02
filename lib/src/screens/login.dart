import 'package:flutter/material.dart';
import 'package:ilm/models/http_exception.dart';
import 'package:ilm/providers/auth.dart';
import 'package:provider/provider.dart';


enum AuthMode { Signup, Login }


class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/afrique.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: null /* add child content here */,
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

  //Pour afficher un message d'erreur
  void _showErrorDialog(String message){
    showDialog(context: context, builder: (ctx) =>AlertDialog(
      title: Text("Une erreur est survenue"),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: (){
            Navigator.of(ctx).pop();
          },
        )
      ],
    ));
  }

  //Soumettre le formulaire
  Future<void> _submit() async{
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      try {
        // Log user in
        await Provider.of<Auth>(context,listen: false ).login(
            _authData['email'],
            _authData['password']
        );
        Navigator.of(context).pushReplacementNamed(('/accueil'));
      } on  HttpException catch(error){
        var errorMessage = "Authentification echoué";
        if(error.toString().contains("EMAIL_EXISTS")){
            errorMessage = "Cet email existe déjà";
        }else if(error.toString().contains("INVALID_EMAIL")){
          errorMessage = "Cet email est invalide";
        }else if(error.toString().contains("WEAK_PASSWORD")){
          errorMessage = "Mot de passe trop faible!";
        } else if(error.toString().contains("EMAIL_NOT_FOUND")){
          errorMessage = "Cet email n'existe pas!";
        }else if(error.toString().contains("INVALID_PASSWORD")){
          errorMessage = "Mot de passe invalid!";
        }
        _showErrorDialog(errorMessage);
      }catch (error){
        print(error);
        var errorMessage = "Impossible de ce connecté pour le moment, veuillez réessayer!";
        _showErrorDialog(errorMessage);
      }
    } else {
      // Sign user up
      try {
        await Provider.of<Auth>(context,listen: false ).signup(
            _authData['email'],
            _authData['password']
        );
        Navigator.of(context).pushReplacementNamed(('/accueilcour'));
      } on  HttpException catch(error){
        var errorMessage = "Authentification echoué";
        if(error.toString().contains("EMAIL_EXISTS")){
          errorMessage = "Cet email existe déjà";
        }else if(error.toString().contains("INVALID_EMAIL")){
          errorMessage = "Cet email est invalide";
        }else if(error.toString().contains("WEAK_PASSWORD")){
          errorMessage = "Mot de passe trop faible!";
        } else if(error.toString().contains("EMAIL_NOT_FOUND")){
          errorMessage = "Cet email n'existe pas!";
        }else if(error.toString().contains("INVALID_PASSWORD")){
          errorMessage = "Mot de passe invalid!";
        }
        _showErrorDialog(errorMessage);
      }catch (error){
        print(error);
        var errorMessage = "Impossible de ce connecté pour le moment, veuillez réessayer!";
        _showErrorDialog(errorMessage);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  //Changer de mode (login ou signup)
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 410 : 250,
        constraints:
        BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 400 : 350),
        width: deviceSize.width * 0.8,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.asset(
                      "assets/images/LOGO.png" ,
                      width: 100,
                      height: 40,
                    )
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 05, top: 05),
                  child: TextFormField(
                    cursorColor: Colors.orange,
                    decoration: new InputDecoration(
                        labelText: 'E-Mail',
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        )),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Votre email est invalid!';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 05, ),
                  child: TextFormField(
                      decoration: new InputDecoration(
                          labelText: 'Password',
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),

                        )),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Mot de passe trop court!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  Container(
                    margin: EdgeInsets.only(bottom: 05, ),
                    child:      TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: new InputDecoration(
                          labelText: 'Confirm Password',
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),

                          )),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                        if (value != _passwordController.text) {
                          return 'Mot de passe invalide!';
                        }
                      }
                          : null,
                    ),
                  ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                    Text(_authMode == AuthMode.Login ? 'Connexion' : 'Créer mon compte', style: TextStyle(color: Colors.white),),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                    color: Colors.orange,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? ' Créer un compte' : 'J\'ai déjà un compte'} '),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Colors.teal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
