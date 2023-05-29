// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loja_store.dart';

class BannerControleLoja extends StatelessWidget {

  const BannerControleLoja({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = '';

    getToken() async {
      final prefs = await SharedPreferences.getInstance();

      token = prefs.getString('token');
    }

    ligaDesligaLojaCall(bool openClose) async {
      await getToken();

      await lojaStoreController.ligaDesligaLojaApi(token, openClose);
    }   

    return Observer(builder: (_) {
      return Container(
        margin: EdgeInsets.all(2.5),
        width: MediaQuery.of(context).size.width - 5,
        height: 150,
        color: lojaStoreController.corContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lojaStoreController.lojaOpenCloseMensage.toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              heroTag: 'btn',
              onPressed: () {
                if (lojaStoreController.isOpen == false) {
                  ligaDesligaLojaCall(true);
                  lojaStoreController.setIsOpen(true);
                } else {
                  ligaDesligaLojaCall(false);
                  lojaStoreController.setIsOpen(false);
                }
              },
              backgroundColor: lojaStoreController.corBotao,
              child: Icon(Icons.power_settings_new),
            ),
          ],
        ),
      );
    });
  }
}
