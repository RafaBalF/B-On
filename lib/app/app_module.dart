import 'package:flutter_modular/flutter_modular.dart';
import 'package:ped/app/modules/login/login_module.dart';
import 'package:ped/app/modules/pedido/pedido_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: LoginModule())
  ];
}
