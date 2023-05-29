// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:ped/app/modules/login/login_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pedido/pedido_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  var loginStore = LoginStore();
  String? token;

  _textFieldLogin({
    String? labelText,
    onChanged,
    String? errorText,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        // errorText: errorText == null ? null : errorText,
      ),
      validator: (value) {
                if (value == '' || value!.isEmpty) {
      return "Por favor insira seu login";
    } else if (!value.contains('@') ) {
      return "E-mail inválido";
    }
    return null;}
      
    );
  }

  bool senhaVisivel = true;

  // @override
  // void initState() {
  //   super.initState();
  //   senhaVisivel = true;
  // }

  _textFieldSenha({
    String? labelText,
    onChanged,
    String? errorText,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: senhaVisivel,
      enableSuggestions: false,
      autocorrect: false,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        // errorText: errorText == null ? null : errorText,
        suffixIcon: IconButton(
          icon: Icon(senhaVisivel
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined),
          onPressed: (() {
            setState(() {
              senhaVisivel = !senhaVisivel;
            });
          }),
        ),
      ),
      validator: (value) {
                if (value == '' || value!.isEmpty) {
      return "Por favor insira sua senha";
    } else if (value.length < 6) {
      return "sua senha precisa ter mais de 5 caracteres";
    }
    return null;
  }
    );
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
  }

  autoLogin() async {
    await getToken();
    // print('getLologin$token');
    if (token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PedidoPage(title: 'Pedidos'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    autoLogin();
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //circleImage(),

                  Lottie.asset(
                    'assets/131431-bebidas.json',
                    repeat: false,
                  ),
                  // SizedBox(
                  //   height: 100,
                  //   width: 100,
                  //   child: Lottie.asset('assets/131430-bebidas.json', repeat: false),
                  // ),

                  const SizedBox(
                    height: 100,
                  ),
                  Observer(
                    builder: (_) {
                      return _textFieldLogin(
                          errorText: loginStore.validateLogin(),
                          labelText: "login",
                          onChanged: loginStore.client.chaLogin);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Observer(
                    builder: (_) {
                      return _textFieldSenha(
                          errorText: loginStore.validateSenha(),
                          labelText: "Senha",
                          onChanged: loginStore.client.chaSenha);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Observer(builder: (_) {
                    return ElevatedButton(
                      onPressed: loginStore.isValid
                          ? () {
                              loginStore.onCLick(context);
                            }
                          : null,
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Entrar'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.login,
                              size: 20,
                            )
                          ]),
                    );
                    // icon: Icon(Icons.login, size: 30),
                    // label: const Text('Entrar'));
                  }),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(this.context).size.width - 316,
            height: MediaQuery.of(this.context).size.height,
            child: Image(
              image: AssetImage('assets/banner_b_on.PNG'),
              width: MediaQuery.of(this.context).size.width - 316,
              height: MediaQuery.of(this.context).size.height,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
