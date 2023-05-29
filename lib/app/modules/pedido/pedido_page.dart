// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ped/app/modules/pedido/banner_controle_loja.dart';
import 'package:ped/app/modules/pedido/loja_store.dart';
import 'package:ped/app/modules/pedido/pedido_single_page.dart';
import 'package:ped/app/modules/pedido/pedido_store.dart';
import 'package:ped/app/modules/pedido/timer_controle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_page.dart';

class PedidoPage extends StatefulWidget {
  PedidoPage({super.key, required this.title});

  final String title;

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  // var pedidoStore = PedidoStore();
  var lojaStore = LojaStore();

  String? token = '';
  var perPage = 1;
  int indexText = 1;

  // bool ligaDesligaLoja = false;
  // bool ligaDesligaChamadaDePedido = false;

  final NumberPaginatorController _controller = NumberPaginatorController();
  final ScrollController _scrollController = ScrollController();

  int timerTest = 0;

  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
  }

  pedidoCall() async {
    await getToken();

    await pedidoStoreController.getPedidos(token, context, perPage);
  }

  // PageController page = PageController();

  // chamadaApi(chamadaApiOnOff) {
  //   Timer.periodic(
  //     Duration(seconds: 5),
  //     (timerx) {
  //       if(chamadaApiOnOff == false) {
  //         timerx.cancel();
  //       }
  //       else if (chamadaApiOnOff == true) {
  //         pedidoCall();
  //       // verificaLojaOnline();
  //       timerTest = timerTest + 1;
  //       debugPrint('Timer teeest $timerTest');
  //       }
  //     },
  //   );
  // }

  verificaLojaOnline() async {
    await getToken();

    await lojaStoreController.verificaLojaOnlineApi(token);
  }
  

  @override
  Widget build(BuildContext context) {
    pedidoCall();
    verificaLojaOnline();
    

    var timer = timerController.chamadaApi(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: [
          logOutController(context, token, lojaStore),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 2.5,
                    ),
                    BannerControleLoja(),
                    SizedBox(
                      height: 30,
                    ),
                    tabelaDeDados(pedidoStoreController, context),
                    Observer(builder: (_) {
                      return NumberPaginator(
                        controller: _controller,
                        numberPages: pedidoStoreController.pageTotal!.toInt(),
                        onPageChange: (int indexPag) {
                          perPage = indexPag + 1;
                          setState(() {
                            indexText = indexText++;
                          });
                          debugPrint(
                              'current page in page ${pedidoStoreController.pageTotal}');
                          pedidoCall();
                          _scrollController.animateTo(
                            _scrollController.position.minScrollExtent,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        initialPage: 0,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Padding logOutController(context, token, lojaStore) {
  logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');

    // Navigator.of(context, rootNavigator: true).pop();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(title: 'Login'),
      ),
    );
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
  }

  ligaDesligaLojaCall(bool openClose) async {
    await getToken();

    await lojaStoreController.ligaDesligaLojaApi(token, openClose);
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FloatingActionButton(
      heroTag: 'btnX',
      onPressed: () {
        // pedidoStoreController.
        // ligaDesligaChamadaDePedido = true;
        ligaDesligaLojaCall(false);
        logout();
      },
      backgroundColor: Colors.amber,
      elevation: 0,
      child: Icon(Icons.logout),
    ),
  );
}

Observer tabelaDeDados(pedidoStoreController, context) {
  return Observer(builder: (_) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Codigo')),
        DataColumn(label: Text('Cliente')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Data')),
        DataColumn(label: Text('Valor')),
        DataColumn(label: Text(''))
      ],
      rows: List<DataRow>.generate(
        pedidoStoreController.pedidoList.length,
        (index) => DataRow(
          // onLongPress: () {setttere();},
          cells: <DataCell>[
            DataCell(SizedBox(
              width: ((MediaQuery.of(context).size.width) / 6) - 150,
              child: Text(pedidoStoreController.pedidoList[index].codigo.toString()),
            )),
            DataCell(SizedBox(
              width: ((MediaQuery.of(context).size.width) / 6) - 120,
              child: Text(pedidoStoreController.pedidoList[index].cliente.toString()),
            )),
            DataCell(SizedBox(
              width: ((MediaQuery.of(context).size.width) / 6) + 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    pedidoStoreController.pedidoList[index].marcador,
                    SizedBox(width: 5,),
                    Text(pedidoStoreController.pedidoList[index].status.toString())
                  ]),
                  SizedBox(
                    height: 5,
                  ),
                  pedidoStoreController.pedidoList[index].motoqueiroChamado,
                  SizedBox(
                    height: 15,
                  ),
                  pedidoStoreController.pedidoList[index].dadosPedidoCancelado
                ],
              ),
              // child: 
              //   Text(pedidoStoreController.pedidoList[index].status.toString())
              
            )),
            DataCell(SizedBox(
              width: ((MediaQuery.of(context).size.width) / 6) - 100,
              child: Text(pedidoStoreController.pedidoList[index].data.toString()),
            )),
            DataCell(SizedBox(
              width: ((MediaQuery.of(context).size.width ) / 6) - 150,
              child: Text(pedidoStoreController.pedidoList[index].valor.toString()),
            )),
            DataCell(
              // onTap: () {setttere();},
              SizedBox(
                width: ((MediaQuery.of(context).size.width ) / 6) - 000,
                child: Row(
                  children: [
                    pedidoStoreController.pedidoList[index].botoes,
                    // pedidoStoreController.getActionButtons(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PedidoSinglePage(
                              title: 'Pedidos',
                              uuid: pedidoStoreController.pedidoList[index].uuid,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.white, // <-- Button color
                        foregroundColor: Colors.blue,
                        // <-- Splash color
                      ),
                      child: Icon(Icons.visibility_outlined),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      columnSpacing: 65,
      dataRowHeight: 150,
      horizontalMargin: 10,
      showCheckboxColumn: false,
    );
  });
}