// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStoreBase, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??=
          Computed<bool>(() => super.isValid, name: '_LoginStoreBase.isValid'))
      .value;

  late final _$idPdvObsAtom =
      Atom(name: '_LoginStoreBase.idPdvObs', context: context);

  @override
  String? get idPdvObs {
    _$idPdvObsAtom.reportRead();
    return super.idPdvObs;
  }

  @override
  set idPdvObs(String? value) {
    _$idPdvObsAtom.reportWrite(value, super.idPdvObs, () {
      super.idPdvObs = value;
    });
  }

  late final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase', context: context);

  @override
  dynamic changeIdPdvObs(String? value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.changeIdPdvObs');
    try {
      return super.changeIdPdvObs(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
idPdvObs: ${idPdvObs},
isValid: ${isValid}
    ''';
  }
}
