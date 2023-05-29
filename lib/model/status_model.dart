// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'status_model.g.dart';

class StatusModel = _StatusModelBase with _$StatusModel;

abstract class _StatusModelBase with Store {
  @observable
  late String canceladoPor;
  @observable
  late String obs;
  @observable
  late DateTime dataPedido;
  @observable
  late DateTime dataCancelado;

  @action
  setCanceladoPor(String value) => canceladoPor = value;
  @action
  setObs(String value) => obs = value;
  @action
  setDatPedido(DateTime value) => dataPedido = value;
  @action
  setDataCancelado(DateTime value) => dataCancelado = value;

  _StatusModelBase(
      this.canceladoPor, this.obs, this.dataPedido, this.dataCancelado);

  _StatusModelBase.fromJson(Map<String, dynamic> json)
      : canceladoPor = json['canceladoPor'],
        obs = json['obs'],
        dataPedido = DateTime.parse(json['dataPedido'] as String),
        dataCancelado = DateTime.parse(json['dataCancelado'] as String);
  Map<String, dynamic> toJson() => {
        'canceladoPor': canceladoPor,
        'obs': obs,
        'dataPedido': dataPedido,
        'dataCancelado': dataCancelado,
      };
}
