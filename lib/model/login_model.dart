// ignore_for_file: non_constant_identifier_names

import 'package:mobx/mobx.dart';

part 'login_model.g.dart';

class Client = _ClientBase with _$Client;

abstract class _ClientBase with Store {
  @observable
  String login = '';
  @action
  chaLogin(String value) => login = value;

  @observable
  String senha = '';
  @action
  chaSenha(String value) => senha = value;
}
