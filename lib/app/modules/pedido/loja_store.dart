// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:ped/api.dart';

part 'loja_store.g.dart';

class LojaStore = _LojaStoreBase with _$LojaStore;

abstract class _LojaStoreBase with Store {


  @observable
  String? lojaOpenCloseMensage = 'Seu estabelecimento está Offline.';
  @action
  changeLojaOpenCloseMensage(String? value) => lojaOpenCloseMensage = value;


  @observable
  bool? isOpen;
  @action
  setIsOpen(bool? value) => isOpen = value;


  @observable
  var corBotao;
  @action
  setCorBotao(var value) => corBotao = value;

  @observable
  var corContainer;
  @action
  setCorContainer(var value) => corContainer = value;


  @observable
  bool? pingApi;
  @action
  setPingApi(bool? value) => pingApi = value;


  verificaLojaOnlineApi(String? token) async {
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.Request('GET',
        Uri.parse('$API_URL/company/verifyCompanyOpenClose'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var dados = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      setIsOpen(dados['isOpen']);
      if (isOpen == true) {
        setCorBotao(Colors.red);
        setCorContainer(Colors.green);
        changeLojaOpenCloseMensage('Seu estabelecimento está Online.');
      } else {
        setCorBotao(Colors.green);
        setCorContainer(Colors.red);
        changeLojaOpenCloseMensage('Seu estabelecimento está Offline.');
      }
    }
  }

  ligaDesligaLojaApi(String? token, bool openClose) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.Request(
        'POST', Uri.parse('$API_URL/company/makeCompanyOnlineOffline'));
    request.body = json.encode({"status": openClose});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var dados = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      setIsOpen(dados['CompanyStatus']);

      if (isOpen == true) {
        setCorBotao(Colors.red);
        setCorContainer(Colors.green);
        changeLojaOpenCloseMensage('Seu estabelecimento está Online.');
      } else {
        setCorBotao(Colors.green);
        setCorContainer(Colors.red);
        changeLojaOpenCloseMensage('Seu estabelecimento está Offline.');
      }

      return dados;
    }

    return dados;
  }
}

LojaStore _singleton = LojaStore();
LojaStore get lojaStoreController => _singleton;
