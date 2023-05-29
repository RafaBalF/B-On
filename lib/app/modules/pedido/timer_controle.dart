import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ped/app/modules/pedido/pedido_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loja_store.dart';

class TimerCall {
  String? token = '';
  var perPage = 1;
  int timerTest = 0;

  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
  }

  pedidoCall(context) async {
    await getToken();

    await pedidoStoreController.getPedidos(token, context, perPage);
  }

  verificaLojaOnline() async {
    await getToken();

    await lojaStoreController.verificaLojaOnlineApi(token);
  }

  var timer;

  chamadaApi(context) {
    if (timer == null) {
      timer = Timer.periodic(
        Duration(seconds: 15),
        (timerx) {
          pedidoCall(context);
          verificaLojaOnline();
          timerTest = timerTest + 1;
          debugPrint('Timer teeest $timerTest');
        },
      );
      return timer;
    }
  }
}

TimerCall _singleton = TimerCall();
TimerCall get timerController => _singleton;
