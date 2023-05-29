// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PedidoStore on _PedidoStoreBase, Store {
  late final _$pedidoListAtom =
      Atom(name: '_PedidoStoreBase.pedidoList', context: context);

  @override
  ObservableList<dynamic> get pedidoList {
    _$pedidoListAtom.reportRead();
    return super.pedidoList;
  }

  @override
  set pedidoList(ObservableList<dynamic> value) {
    _$pedidoListAtom.reportWrite(value, super.pedidoList, () {
      super.pedidoList = value;
    });
  }

  late final _$pageTotalAtom =
      Atom(name: '_PedidoStoreBase.pageTotal', context: context);

  @override
  int? get pageTotal {
    _$pageTotalAtom.reportRead();
    return super.pageTotal;
  }

  @override
  set pageTotal(int? value) {
    _$pageTotalAtom.reportWrite(value, super.pageTotal, () {
      super.pageTotal = value;
    });
  }

  late final _$_PedidoStoreBaseActionController =
      ActionController(name: '_PedidoStoreBase', context: context);

  @override
  dynamic addTodosPedido1(PedidosModel ped) {
    final _$actionInfo = _$_PedidoStoreBaseActionController.startAction(
        name: '_PedidoStoreBase.addTodosPedido1');
    try {
      return super.addTodosPedido1(ped);
    } finally {
      _$_PedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPageTotal(int? value) {
    final _$actionInfo = _$_PedidoStoreBaseActionController.startAction(
        name: '_PedidoStoreBase.setPageTotal');
    try {
      return super.setPageTotal(value);
    } finally {
      _$_PedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pedidoList: ${pedidoList},
pageTotal: ${pageTotal}
    ''';
  }
}
