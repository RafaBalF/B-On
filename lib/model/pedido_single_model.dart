// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:ped/api.dart';

part 'pedido_single_model.g.dart';

class PedidoSingleModel = _PedidoSingleModelBase with _$PedidoSingleModel;

abstract class _PedidoSingleModelBase with Store {
  
  @observable
  String? status;
  @observable
  String? situation;
  @observable
  int? codigo;
  @observable
  String? nameCompany;
  @observable
  String? nameCliente;
  @observable
  List<Phones?> phoneCompany = [];
  @observable
  String? phoneClient;
  @observable
  String? cpfNota;
  @observable
  String? dateOrder;
  @observable
  String? obs;
  @observable
  double? deliveryFee;
  @observable
  String? orderTotal;
  @observable
  double? subTotal; //total - taxa de entrega(delivery fee)
  @observable
  String? methodPaymentName;
  @observable
  String? methodPaymentType;
  @observable
  String? addressCompany;
  @observable
  String? cepCompany;
  @observable
  String? numberCompany;
  @observable
  String? neighborhoodCompany;
  @observable
  String? cityCompany;
  @observable
  String? complementCompany;
  @observable
  String? addressClient;
  @observable
  String? cepClient = '';
  @observable
  String? numberClient;
  @observable
  String? neighborhoodClient;
  @observable
  String? cityClient;
  @observable
  String? stateClient;
  @observable
  String? complementClient;
  @observable
  String? reference;
  @observable
  List<OrderProducts?> orderProducts = [];
  @observable
  bool visibilityCallMotoqueiroButton = false;
  @observable
  bool visibilityCallMotoqueiroMessage = false;
  @observable
  var orderDelivery;

  @action
  setStatus(String? value) => status = value;
  @action
  setCodigo(int? value) => codigo = value;
  @action
  setSituation(String? value) => situation = value;
  @action
  setNameCompany(String? value) => nameCompany = value;
  @action
  setNameCliente(String? value) => nameCliente = value;
  @action
  setPhoneCompany(List<Phones> value) => phoneCompany = value;
  @action
  setPhoneClient(String? value) => phoneClient = value;
  @action
  setCpfNota(String? value) => cpfNota = value;
  @action
  setdataOrder(String? value) => dateOrder = value;
  @action
  setObs(String? value) => obs = value;
  @action
  setDeliveryFee(double? value) => deliveryFee = value;
  @action
  setOrderTotal(String? value) => orderTotal = value;
  @action
  setSubTotal(double? value) => subTotal = value;
  @action
  setMethodPaymentName(String? value) => methodPaymentName = value;
  @action
  setMethodPaymentType(String? value) => methodPaymentType = value;
  @action
  setAddressCompany(String? value) => addressCompany = value;
  @action
  setCityCompany(String? value) => cityCompany = value;
  @action
  setCepCompany(String? value) => cepCompany = value;
  @action
  setNumberCompany(String? value) => numberCompany = value;
  @action
  setNeighborhoodCompany(String? value) => neighborhoodCompany = value;
  @action
  setComplementCompany(String? value) => complementCompany = value;
  @action
  setAddressClient(String? value) => addressClient = value;
  @action
  setCepClient(String? value) => cepClient = value;
  @action
  setNumberClient(String? value) => numberClient = value;
  @action
  setNeighborhoodClient(String? value) => neighborhoodClient = value;
  @action
  setCityClient(String? value) => cityClient = value;
  @action
  setStateClient(String? value) => stateClient = value;
  @action
  setComplementClient(String? value) => complementClient = value;
  @action
  setReference(String? value) => reference = value;
  @action
  setOrderProducts(List<OrderProducts> value) => orderProducts = value;
  @action
  setVisibilityCallMotoqueiroButton(bool value) =>
      visibilityCallMotoqueiroButton = value;
  @action
  setVisibilityCallMotoqueiroMessage(bool value) =>
      visibilityCallMotoqueiroMessage = value;
  @action
  setOrderDelivery(var value) => orderDelivery = value;

  _PedidoSingleModelBase();

  _PedidoSingleModelBase.fromJson(Map<String, dynamic> json) {
    cepClient = json['orders'][0]['postcode'];
    addressClient = json['orders'][0]['address'];
    numberClient = json['orders'][0]['number'];
    complementClient = json['orders'][0]['complement'];
    neighborhoodClient = json['orders'][0]['neighborhood'];
    cityClient = json['orders'][0]['city'];
    stateClient = json['orders'][0]['state'];
    status = json['orders'][0]['status'];
    situation = json['orders'][0]['status_message'];
    methodPaymentName = json['orders'][0]['payment_method']['name'];
    methodPaymentType = json['orders'][0]['payment_method']['type'];
    obs = json['orders'][0]['obs'];
    orderTotal = json['orders'][0]['order_price'];
    deliveryFee = json['orders'][0]['delivery_fee'] + .0;
    phoneClient = json['orders'][0]['tel'];
    codigo = json['orders'][0]['order_number'];
    cpfNota = json['orders'][0]['cpfNota'];
    dateOrder = json['orders'][0]['created_at_brt'];
    nameCliente = json['orders'][0]['user']['name'];
    // orderTicket = null;
    nameCompany = json['orders'][0]['company']['name'];
    addressCompany = json['orders'][0]['company']['address']['street'];
    cepCompany = json['orders'][0]['company']['address']['postcode'];
    numberCompany = json['orders'][0]['company']['address']['number'];
    neighborhoodCompany =
        json['orders'][0]['company']['address']['neighborhood'];
    cityCompany = json['orders'][0]['company']['address']['city'];
    complementCompany = json['orders'][0]['company']['complement'];
    phoneCompany = List.from(json['orders'][0]['company']['phones'])
        .map((e) => Phones.fromJson(e))
        .toList();
    orderProducts = List.from(json['orders'][0]['order_products'])
        .map((e) => OrderProducts.fromJson(e))
        .toList();
        orderDelivery = json['orders'][0]['order_delivery'];
  }

  getPedidoByUuid(String? token, uuid) async {
    var headers = {'Authorization': 'Bearer $token'};

    var request =
        http.MultipartRequest('GET', Uri.parse('$API_URL/orders/$uuid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      PedidoSingleModel ped = PedidoSingleModel.fromJson(data);

      setCepClient(ped.cepClient ?? '');
      setAddressClient(ped.addressClient ?? '');
      setNumberClient(ped.numberClient ?? '');
      setComplementClient(ped.complementClient ?? '');
      setReference(ped.reference ?? '');
      setNeighborhoodClient(ped.neighborhoodClient ?? '');
      setCityClient(ped.cityClient ?? '');
      setStateClient(ped.stateClient ?? '');
      setSituation(ped.situation ?? '');
      setStatus(ped.status);
      setMethodPaymentName(ped.methodPaymentName ?? '');
      setMethodPaymentType(ped.methodPaymentType ?? '');
      setObs(ped.obs ?? 'N/D');
      setOrderTotal(ped.orderTotal ?? '');
      setDeliveryFee(ped.deliveryFee! + .0);
      setPhoneClient(ped.phoneClient ?? '');
      setCodigo(ped.codigo ?? 000);
      setCpfNota(ped.cpfNota ?? 'Não');
      setdataOrder(ped.dateOrder ?? '');
      setNameCliente(ped.nameCliente ?? '');
      // orderTicket = null;
      setNameCompany(ped.nameCompany ?? '');
      setAddressCompany(
          ped.addressCompany ?? '');
      setCepCompany(ped.cepCompany ?? '');
      setNumberCompany(ped.numberCompany ?? '');
      setNeighborhoodCompany(
          ped.neighborhoodCompany ?? '');
      setCityCompany(ped.cityCompany ?? '');
      setComplementCompany(ped.complementCompany ?? '');
      setPhoneCompany(List.from(data['orders'][0]['company']['phones'] ?? '')
          .map((e) => Phones.fromJson(e))
          .toList());
      setOrderProducts(List.from(data['orders'][0]['order_products'] ?? '')
          .map((e) => OrderProducts.fromJson(e))
          .toList());
      setSubTotal(data['orders'][0]['order_total'] -
              data['orders'][0]['delivery_fee'] +
              .0 ??
          '');
      setOrderDelivery(ped.orderDelivery);

      if (orderDelivery != null) {
        setVisibilityCallMotoqueiroButton(false);
        setVisibilityCallMotoqueiroMessage(true);
      } else {
        if (status == 'D' || status == 'A' || status == 'P') {
          visibilityCallMotoqueiroButton = true;
        } else {
          visibilityCallMotoqueiroButton = false;
          visibilityCallMotoqueiroMessage = false;
        }
      }
    }
  }
}

class OrderProducts {
  OrderProducts({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.finalPrice,
  });
  late final String productName;
  late final int quantity;
  late final double unitPrice;
  late final String finalPrice;

  OrderProducts.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'] + .0;
    finalPrice = json['final_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_name'] = productName;
    _data['quantity'] = quantity;
    _data['unit_price'] = unitPrice;
    _data['final_price'] = finalPrice;
    return _data;
  }
}

class Phones {
  Phones({
    required this.phone,
  });
  late final String phone;

  Phones.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone'] = phone;
    return _data;
  }
}
