// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loja_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LojaStore on _LojaStoreBase, Store {
  late final _$lojaOpenCloseMensageAtom =
      Atom(name: '_LojaStoreBase.lojaOpenCloseMensage', context: context);

  @override
  String? get lojaOpenCloseMensage {
    _$lojaOpenCloseMensageAtom.reportRead();
    return super.lojaOpenCloseMensage;
  }

  @override
  set lojaOpenCloseMensage(String? value) {
    _$lojaOpenCloseMensageAtom.reportWrite(value, super.lojaOpenCloseMensage,
        () {
      super.lojaOpenCloseMensage = value;
    });
  }

  late final _$isOpenAtom =
      Atom(name: '_LojaStoreBase.isOpen', context: context);

  @override
  bool? get isOpen {
    _$isOpenAtom.reportRead();
    return super.isOpen;
  }

  @override
  set isOpen(bool? value) {
    _$isOpenAtom.reportWrite(value, super.isOpen, () {
      super.isOpen = value;
    });
  }

  late final _$corBotaoAtom =
      Atom(name: '_LojaStoreBase.corBotao', context: context);

  @override
  dynamic get corBotao {
    _$corBotaoAtom.reportRead();
    return super.corBotao;
  }

  @override
  set corBotao(dynamic value) {
    _$corBotaoAtom.reportWrite(value, super.corBotao, () {
      super.corBotao = value;
    });
  }

  late final _$corContainerAtom =
      Atom(name: '_LojaStoreBase.corContainer', context: context);

  @override
  dynamic get corContainer {
    _$corContainerAtom.reportRead();
    return super.corContainer;
  }

  @override
  set corContainer(dynamic value) {
    _$corContainerAtom.reportWrite(value, super.corContainer, () {
      super.corContainer = value;
    });
  }

  late final _$pingApiAtom =
      Atom(name: '_LojaStoreBase.pingApi', context: context);

  @override
  bool? get pingApi {
    _$pingApiAtom.reportRead();
    return super.pingApi;
  }

  @override
  set pingApi(bool? value) {
    _$pingApiAtom.reportWrite(value, super.pingApi, () {
      super.pingApi = value;
    });
  }

  late final _$_LojaStoreBaseActionController =
      ActionController(name: '_LojaStoreBase', context: context);

  @override
  dynamic changeLojaOpenCloseMensage(String? value) {
    final _$actionInfo = _$_LojaStoreBaseActionController.startAction(
        name: '_LojaStoreBase.changeLojaOpenCloseMensage');
    try {
      return super.changeLojaOpenCloseMensage(value);
    } finally {
      _$_LojaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsOpen(bool? value) {
    final _$actionInfo = _$_LojaStoreBaseActionController.startAction(
        name: '_LojaStoreBase.setIsOpen');
    try {
      return super.setIsOpen(value);
    } finally {
      _$_LojaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCorBotao(dynamic value) {
    final _$actionInfo = _$_LojaStoreBaseActionController.startAction(
        name: '_LojaStoreBase.setCorBotao');
    try {
      return super.setCorBotao(value);
    } finally {
      _$_LojaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCorContainer(dynamic value) {
    final _$actionInfo = _$_LojaStoreBaseActionController.startAction(
        name: '_LojaStoreBase.setCorContainer');
    try {
      return super.setCorContainer(value);
    } finally {
      _$_LojaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPingApi(bool? value) {
    final _$actionInfo = _$_LojaStoreBaseActionController.startAction(
        name: '_LojaStoreBase.setPingApi');
    try {
      return super.setPingApi(value);
    } finally {
      _$_LojaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lojaOpenCloseMensage: ${lojaOpenCloseMensage},
isOpen: ${isOpen},
corBotao: ${corBotao},
corContainer: ${corContainer},
pingApi: ${pingApi}
    ''';
  }
}
