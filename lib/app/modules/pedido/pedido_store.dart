//ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_conditional_assignment, unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:ped/api.dart';
import 'package:ped/model/paginator_model.dart';
import 'package:ped/model/pedidos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pedido_store.g.dart';

class PedidoStore = _PedidoStoreBase with _$PedidoStore;

abstract class _PedidoStoreBase with Store {
  final play = AudioPlayer();
  final paginator = PaginatorModel();

  int? total;

  @observable
  late ObservableList pedidoList = [].asObservable();
  @action
  addTodosPedido1(PedidosModel ped) {
    pedidoList.add(ped);
  }

  @observable
  late int? pageTotal = 1;

  @action
  setPageTotal(int? value) => pageTotal = value;

  Future<dynamic> getPedidos(String? token, context, int page) async {
    var headers = {'Authorization': 'Bearer $token'};

    var url = Uri.parse('$API_URL/orders?page=$page');
    var request = http.MultipartRequest('GET', url);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var listaResponse = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      if (pedidoList.isEmpty) {
        for (var ped in listaResponse['orders']['data']) {
          PedidosModel pedido = PedidosModel.fromJson(ped);

          getActionButtons(pedido);

          getFlagMotoqueiroChamado(pedido);

          getDadosPedidoCancelado(pedido);

          setFlag(pedido);

          addTodosPedido1(pedido);
          setPageTotal(listaResponse['orders']['last_page']);
        }
      } else if (pedidoList.isNotEmpty) {
        pedidoList.removeRange(0, pedidoList.length);
        for (var ped in listaResponse['orders']['data']) {
          PedidosModel pedido = PedidosModel.fromJson(ped);

          getActionButtons(pedido);

          getFlagMotoqueiroChamado(pedido);

          getDadosPedidoCancelado(pedido);

          setFlag(pedido);

          addTodosPedido1(pedido);
          setPageTotal(listaResponse['orders']['last_page']);
        }
      }

      if (total == null) {
        total = listaResponse['orders']['total'];
      } else if (total != listaResponse['orders']['total']) {
        total = listaResponse['orders']['total'];
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            play.play(AssetSource("Mud_Lonely_This_Christmas.mp3"));
            return AlertDialog(
              title: Text('Obaa! Novo pedido'),
              content: Text('Você tem um novo pedido'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    play.stop();
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      }

      PaginatorModel pag = PaginatorModel.fromJson(listaResponse['orders']);

      paginator.setTotalPages(pag.totalPages);
      paginator.setCurrentPage(pag.currentPage);
      return listaResponse;
    }

    return listaResponse;
  }

  updatePedido(String? token, String action, String? pedidoUuid) async {
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.MultipartRequest(
        'POST', Uri.parse('$API_URL/orders/update/$pedidoUuid/$action'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    jsonDecode(await response.stream.bytesToString());

    getPedidos(token, context, 1);

    debugPrint('ping update');
  }

  getDadosPedidoCancelado(pedido) {
    if (pedido.situation == 'C') {
      pedido.dadosPedidoCancelado = dadosPedidoCancelado(pedido, true);
    } else {
      pedido.dadosPedidoCancelado = dadosPedidoCancelado(pedido, false);
    }
  }

  getFlagMotoqueiroChamado(pedido) {
    if (pedido.orderDelivery == null) {
      pedido.motoqueiroChamado = bannerMotoqueiroChamado(false);
    } else {
      pedido.motoqueiroChamado = bannerMotoqueiroChamado(true);
    }
  }

  setFlag(pedido) {
    switch (pedido.situation) {
      case 'W':
        return pedido.marcador = marcador(Colors.grey);
      case 'A':
        return pedido.marcador = marcador(Colors.blue);
      case 'R':
        return pedido.marcador = marcador(Colors.red);
      case 'C':
        return pedido.marcador = marcador(Colors.red);
      case 'D':
        return pedido.marcador = marcador(Colors.purple);
      default:
        return pedido.marcador = marcador(Colors.black);
    }
  }

  getActionButtons(pedido) async {
    String? token = '';

    getToken() async {
      final prefs = await SharedPreferences.getInstance();

      token = prefs.getString('token');
    }

    updatePedidoAction(String? pedido, action) async {
      await getToken();

      await updatePedido(token, action, pedido);
    }

    updatePedidoReject(String? pedido) async {
      await getToken();

      await updatePedido(token, 'reject', pedido);
    }

    switch (pedido.situation) {
      case 'W':
        return pedido.setButtons(Row(
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint('ping botao');
                // pedidoList[0];
                updatePedidoAction(pedido.uuid, 'accept');
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.green, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
              child: Icon(Icons.thumb_up_rounded),
            ),
            // button(Colors.green, Icon(Icons.thumb_up_rounded), () {
            //   updatePedidoAction(pedido.uuid, 'accept');
            // }),
            SizedBox(
              width: 2,
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint('ping botao');
                // pedidoList[0];
                updatePedidoReject(pedido.uuid);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.red, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
              child: Icon(Icons.cancel_rounded),
            ),
            // button(Colors.red, Icon(Icons.cancel_rounded), () {
            //   updatePedidoReject(pedido.uuid);
            // }),
            SizedBox(
              width: 2,
            ),
          ],
        ));
      case 'A':
        return pedido.setButtons(Row(
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint('ping botao');
                // pedidoList[0];
                updatePedidoAction(pedido.uuid, 'delivery');
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.blue, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
              child: Icon(Icons.delivery_dining),
            ),
            // button(Colors.blue, Icon(Icons.delivery_dining), () {
            //   updatePedidoAction(pedido.uuid, 'delivery');
            // }),
            SizedBox(
              width: 2,
            ),
          ],
        ));
      case 'D':
        return pedido.botoes = Row(
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint('ping botao');
                // pedidoList[0];
                updatePedidoAction(pedido.uuid, 'finish');
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.green, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
              child: Icon(Icons.check),
            ),
            // button(Colors.green, Icon(Icons.check), () {
            //   updatePedidoAction(pedido.uuid, 'finish');
            // }),
            SizedBox(
              width: 2,
            )
          ],
        );
      default:
        return pedido.botoes = Row();
    }
  }

  //=================================================

  Visibility dadosPedidoCancelado(pedido, vis) {
    return Visibility(
      visible: vis,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Cancelado por: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${pedido.canceladoPor}'),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'OBS: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${pedido.obs}'),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Pedido feito em: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${pedido.pedidoFeitoEm}'),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Pedido cancelado em: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${pedido.pedidoCanceladoEm}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container marcador(corBolinha) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: corBolinha,
      ),
    );
  }

  // Row botoes(visibilityBotao, visibilityBotaoReject, context, pedido, action,
  //     pedidoList) {
  //   // var pedidoStore = PedidoStore();
  //   String? token = '';

  //   getToken() async {
  //     final prefs = await SharedPreferences.getInstance();

  //     token = prefs.getString('token');
  //   }

  //   updatePedidoAction(PedidosModel pedido, action) async {
  //     await getToken();

  //     await pedidoStoreController.updatePedido(token, action, pedido);
  //   }

  //   updatePedidoReject(PedidosModel pedido) async {
  //     await getToken();

  //     await pedidoStoreController.updatePedido(token, 'reject', pedido);
  //   }

  //   return Row(
  //     children: [
  //       Row(
  //         children: [
  //           Visibility(
  //             visible: visibilityBotao,
  //             child: button(Colors.green, Icon(Icons.check), () {
  //               updatePedidoAction(pedido, action);
  //             }),
  //           ),
  //           Visibility(
  //             visible: visibilityBotao,
  //             child: button(Colors.green, Icon(Icons.check), () {
  //               updatePedidoAction(pedido, action);
  //             }),
  //           ),
  //           Visibility(
  //             visible: visibilityBotao,
  //             child: button(Colors.green, Icon(Icons.check), () {
  //               updatePedidoAction(pedido, action);
  //             }),
  //           ),
  //           Visibility(
  //             visible: visibilityBotao,
  //             child: button(Colors.green, Icon(Icons.check), () {
  //               updatePedidoAction(pedido, action);
  //             }),
  //           ),
  //           SizedBox(
  //             width: 2,
  //           ),
  //           Visibility(
  //             visible: visibilityBotaoReject,
  //             child: button(Colors.red, Icon(Icons.cancel_rounded), () {
  //               updatePedidoReject(pedido);
  //             }),
  //           ),
  //           SizedBox(
  //             width: 2,
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }

  ElevatedButton button(Color? cor, Icon icone, Function funcao) {
    return ElevatedButton(
      onPressed: () {
        debugPrint('ping botao');
        // pedidoList[0];
        funcao;
      },
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        backgroundColor: cor, // <-- Button color
        foregroundColor: Colors.white, // <-- Splash color
      ),
      child: icone,
    );
  }
}

PedidoStore _singleton = PedidoStore();
PedidoStore get pedidoStoreController => _singleton;

class Paginate {
  Paginate({
    required this.currentPage,
    required this.lastPage,
  });
  late final int currentPage;
  late final int lastPage;

  Paginate.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['last_page'] = lastPage;
    return _data;
  }
}

Visibility bannerMotoqueiroChamado(vis) {
  return Visibility(
    visible: vis,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text('Entrega solicitada'),
      ),
    ),
  );
}
