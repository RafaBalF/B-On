// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ped/api.dart';

class PedidoSingleStore {

  callMotoqueiro(String? token, uuid, context) async {
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.Request(
        'GET',
        Uri.parse(
            '$API_URL/orderDelivery/callDelivery/$uuid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Sucesso', style: TextStyle(color: Colors.green),),
            content: Text('Motoqueiro solicitado com suceso'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }

    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Falha', style: TextStyle(color: Colors.red)),
          content: Text('Falha ao solicitar motoqueiro'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
