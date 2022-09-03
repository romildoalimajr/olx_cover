import 'package:flutter/material.dart';
import 'package:olx_cover/views/widgets/BotaoCustomizado.dart';
import 'package:olx_cover/views/widgets/InputCustomizado.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/Usuario.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController(text: "odlimor.sevla@gmail.com");
  TextEditingController _controllerSenha = TextEditingController(text: "rjr12345");

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _cadastrarUsuario(Usuario usuario){
   FirebaseAuth auth = FirebaseAuth.instance;

   auth.createUserWithEmailAndPassword(
       email: usuario.email,
       password: usuario.senha
   ).then((User){
     //redirecionar para tela principal
     Navigator.pushReplacementNamed(context, "/");
   });
  }
  _logarUsuario(Usuario usuario){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha
    ).then((User){
      //redirecionar para tela principal
      Navigator.pushReplacementNamed(context, "/");
    });
  }


  _validarCampos(){
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(email.isNotEmpty && email.contains("@")){
      if(senha.isNotEmpty && senha.length >= 8){
        //Configurar Usuário
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        // cadastrar ou logar usuário
        if(_cadastrar){
          //cadastrar
          _cadastrarUsuario(usuario);
        }else{
          //logar usuário
          _logarUsuario(usuario);
        }
      }else{
        setState(() {
          _mensagemErro = "Preencha a senha! A senha deve ter até 8 caracteres!";
        });
      }
    }else{
      setState(() {
        _mensagemErro = "Preencha um e-mail válido!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                      "images/logoOlx.png",
                    width: 200,
                      height: 150,
                  ),
                ),

                InputCustomizado(
                  controller: _controllerEmail,
                  hint: "E-mail",
                  autoFocus: true,
                  type: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                InputCustomizado(
                  controller: _controllerSenha,
                  hint: "Password",
                  obscure: true,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Logar"),
                    Switch(
                      value: _cadastrar,
                      onChanged: (bool valor){
                        setState(() {
                          _cadastrar = valor;
                          _textoBotao = "Entrar";
                          if(_cadastrar){
                            _textoBotao = "Cadastrar";
                          }
                        });
                      },
                    ),
                    Text("Cadastrar")
                  ],
                ),
                BotaoCustomizado(
                  texto: _textoBotao,
                  onPressed: (){
                    _validarCampos();
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(_mensagemErro, style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
