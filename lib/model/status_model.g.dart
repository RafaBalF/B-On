// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatusModel on _StatusModelBase, Store {
  late final _$canceladoPorAtom =
      Atom(name: '_StatusModelBase.canceladoPor', context: context);

  @override
  String get canceladoPor {
    _$canceladoPorAtom.reportRead();
    return super.canceladoPor;
  }

  @override
  set canceladoPor(String value) {
    _$canceladoPorAtom.reportWrite(value, super.canceladoPor, () {
      super.canceladoPor = value;
    });
  }

  late final _$obsAtom = Atom(name: '_StatusModelBase.obs', context: context);

  @override
  String get obs {
    _$obsAtom.reportRead();
    return super.obs;
  }

  @override
  set obs(String value) {
    _$obsAtom.reportWrite(value, super.obs, () {
      super.obs = value;
    });
  }

  late final _$dataPedidoAtom =
      Atom(name: '_StatusModelBase.dataPedido', context: context);

  @override
  DateTime get dataPedido {
    _$dataPedidoAtom.reportRead();
    return super.dataPedido;
  }

  @override
  set dataPedido(DateTime value) {
    _$dataPedidoAtom.reportWrite(value, super.dataPedido, () {
      super.dataPedido = value;
    });
  }

  late final _$dataCanceladoAtom =
      Atom(name: '_StatusModelBase.dataCancelado', context: context);

  @override
  DateTime get dataCancelado {
    _$dataCanceladoAtom.reportRead();
    return super.dataCancelado;
  }

  @override
  set dataCancelado(DateTime value) {
    _$dataCanceladoAtom.reportWrite(value, super.dataCancelado, () {
      super.dataCancelado = value;
    });
  }

  late final _$_StatusModelBaseActionController =
      ActionController(name: '_StatusModelBase', context: context);

  @override
  dynamic setCanceladoPor(String value) {
    final _$actionInfo = _$_StatusModelBaseActionController.startAction(
        name: '_StatusModelBase.setCanceladoPor');
    try {
      return super.setCanceladoPor(value);
    } finally {
      _$_StatusModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setObs(String value) {
    final _$actionInfo = _$_StatusModelBaseActionController.startAction(
        name: '_StatusModelBase.setObs');
    try {
      return super.setObs(value);
    } finally {
      _$_StatusModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDatPedido(DateTime value) {
    final _$actionInfo = _$_StatusModelBaseActionController.startAction(
        name: '_StatusModelBase.setDatPedido');
    try {
      return super.setDatPedido(value);
    } finally {
      _$_StatusModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDataCancelado(DateTime value) {
    final _$actionInfo = _$_StatusModelBaseActionController.startAction(
        name: '_StatusModelBase.setDataCancelado');
    try {
      return super.setDataCancelado(value);
    } finally {
      _$_StatusModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
canceladoPor: ${canceladoPor},
obs: ${obs},
dataPedido: ${dataPedido},
dataCancelado: ${dataCancelado}
    ''';
  }
}
