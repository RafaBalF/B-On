import 'package:ped/app/modules/pedido/pedido_page.dart';
import 'package:ped/app/modules/pedido/pedido_single_page.dart';
import 'package:ped/app/modules/pedido/pedido_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PedidoModule extends Module {
  @override
  final List<Bind> binds = [Bind.singleton((i) => PedidoStore())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => const PedidoSinglePage(title: 'Visualizar Pedido', uuid: '34323sfsdf')),
  ];
}
