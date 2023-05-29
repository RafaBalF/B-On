// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ped/app/modules/pedido/loja_store.dart';
import 'package:ped/app/modules/pedido/pedido_single_store.dart';
import 'package:ped/model/pedido_single_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'banner_controle_loja.dart';

class PedidoSinglePage extends StatefulWidget {
  const PedidoSinglePage({super.key, required this.title, required this.uuid});

  final String title;
  final String uuid;

  @override
  State<PedidoSinglePage> createState() => _PedidoSinglePageState();
}

class _PedidoSinglePageState extends State<PedidoSinglePage> {
  var pedidoSingleStore = PedidoSingleStore();
  var pedidoSingleModel = PedidoSingleModel();
  // var pedidoStore = PedidoStore();
  var lojaStore = LojaStore();
  // var pedPage = PedidoPage(title: '');

  String? token = '';
  int timerTest = 0;

  // bool ligaDesligaLoja = false;
  // bool ligaDesligaChamadaDePedido = false;

  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
  }

  pedidoSingleCall(uuid) async {
    await getToken();

    await pedidoSingleModel.getPedidoByUuid(token, uuid);
  }

  verificaLojaOnline() async {
    await getToken();

    await lojaStore.verificaLojaOnlineApi(token);
  }

  @override
  Widget build(BuildContext context) {
    pedidoSingleCall(widget.uuid);
    verificaLojaOnline();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2.5,
                      ),
                      BannerControleLoja(),
                    ],
                  ),
                  Observer(builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'VISUALIZAR PEDIDO',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    statusENumeroPedido(pedidoSingleModel),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    botaoChamadaMotoqueiro(
                                        pedidoSingleModel,
                                        pedidoSingleStore,
                                        context,
                                        token,
                                        widget.uuid),
                                    bannerMotoqueiroChamado(pedidoSingleModel),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    divisoria1(context),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          dadosDaCompany(pedidoSingleModel),
                                          dadosDoClienteEDoPEdido(
                                            pedidoSingleModel,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    tabelaProdutosDoPedido(
                                        pedidoSingleModel, context),
                                    SizedBox(
                                      height: 70,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        precosEFormaDePagamento(pedidoSingleModel),
                                      ],
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    );
                  })
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}








Column precosEFormaDePagamento(pedidoSingleModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text('Subtotal: R\$${pedidoSingleModel.subTotal?.toStringAsFixed(2)}'),
      Text(
          'Taxa de entrega: R\$${pedidoSingleModel.deliveryFee?.toStringAsFixed(2)}'),
      SizedBox(
        height: 20,
      ),
      SizedBox(
        height: 1,
        width: 170,
        child: Container(
          color: Colors.grey,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            'Total: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('R\$${pedidoSingleModel.orderTotal}')
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Text(
          'Forma de pagamento: ${pedidoSingleModel.methodPaymentName}(${pedidoSingleModel.methodPaymentType})')
    ],
  );
}

Center tabelaProdutosDoPedido(pedidoSingleModel, context) {
  return Center(
    child: DataTable(
      columns: [
        DataColumn(label: Text('Qtde')),
        DataColumn(label: Text('Produto')),
        DataColumn(label: Text('Preço unit.')),
        DataColumn(label: Text('total')),
      ],
      rows: List<DataRow>.generate(
        pedidoSingleModel.orderProducts.length,
        (index) => DataRow(
          cells: <DataCell>[
            DataCell(
                Text('${pedidoSingleModel.orderProducts[index]?.quantity}')),
            DataCell(SizedBox(
                width: 300,
                child: Text(
                    '${pedidoSingleModel.orderProducts[index]?.productName}'))),
            DataCell(SizedBox(
                width: 100,
                child: Text(
                    'R\$${pedidoSingleModel.orderProducts[index]?.unitPrice.toStringAsFixed(2)}'))),
            DataCell(Text(
                'R\$${pedidoSingleModel.orderProducts[index]?.finalPrice}')),
          ],
        ),
      ),
      columnSpacing: (MediaQuery.of(context).size.width - 350) / 4,
    ),
  );
}

Column dadosDoClienteEDoPEdido(pedidoSingleModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        '${pedidoSingleModel.nameCliente}',
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Text(
          '${pedidoSingleModel.addressClient}, ${pedidoSingleModel.numberClient}'),
      Text('${pedidoSingleModel.neighborhoodClient}'),
      Text(
          '${pedidoSingleModel.cityClient} - ${pedidoSingleModel.stateClient} - ${pedidoSingleModel.cepClient}'),
      Text('${pedidoSingleModel.complementClient}'),
      Text('${pedidoSingleModel.reference}'),
      SizedBox(height: 10),
      Text(
        'CPF na nota: ${pedidoSingleModel.cpfNota}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Text(
        '${pedidoSingleModel.phoneClient}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 15),
      Text(
        'Pedido feito em:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Icon(Icons.calendar_month),
          Text('${pedidoSingleModel.dateOrder}'),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Observação da entrega:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('${pedidoSingleModel.obs}')
    ],
  );
}

Column dadosDaCompany(pedidoSingleModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          text: '${pedidoSingleModel.nameCompany}',
          style: TextStyle(
              fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 10),
      Text(
          '${pedidoSingleModel.addressCompany}, ${pedidoSingleModel.numberCompany}'),
      Text('${pedidoSingleModel.neighborhoodCompany},'),
      Text(
          '${pedidoSingleModel.cityCompany} - ${pedidoSingleModel.cepCompany}'),
      SizedBox(height: 10),
      Text(
        'Telefones',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 200,
        height: 100,
        child: Expanded(
          child: ListView.builder(
            itemCount: pedidoSingleModel.phoneCompany.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pedidoSingleModel.phoneCompany[index]!.phone.toString()),
                ],
              );
            },
          ),
        ),
      )
    ],
  );
}

SizedBox divisoria1(context) {
  return SizedBox(
    height: 1,
    width: MediaQuery.of(context).size.width,
    child: Container(
      color: Colors.grey,
    ),
  );
}

Visibility bannerMotoqueiroChamado(pedidoSingleModel) {
  return Visibility(
    visible: pedidoSingleModel.visibilityCallMotoqueiroMessage,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Entrega solicitada'),
      ),
    ),
  );
}

Visibility botaoChamadaMotoqueiro(
    pedidoSingleModel, pedidoSingleStore, context, token, uuid) {
  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
  }

  motoqueiroCall(token, uuid) async {
    pedidoSingleModel.setVisibilityCallMotoqueiroButton(false);
    pedidoSingleModel.setVisibilityCallMotoqueiroMessage(true);

    await getToken();

    await pedidoSingleStore.callMotoqueiro(token, uuid, context);
  }

  return Visibility(
    visible: pedidoSingleModel.visibilityCallMotoqueiroButton,
    child: ElevatedButton(
      onPressed: () {
        // pedidoSingleModel.setVisibilityCallMotoqueiro(false);
        motoqueiroCall(token, uuid);
      },
      child: Text('Solicitar Motoqueiro'),
    ),
  );
}

Row statusENumeroPedido(pedidoSingleModel) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'PEDIDO - ${pedidoSingleModel.situation}',
        style: TextStyle(fontSize: 20),
      ),
      Text(
        '#${pedidoSingleModel.codigo}',
        style: TextStyle(fontSize: 20),
      ),
    ],
  );
}
