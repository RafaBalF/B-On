// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'paginator_model.g.dart';

class PaginatorModel = _PaginatorModelBase with _$PaginatorModel;

abstract class _PaginatorModelBase with Store
{
  @observable
  late int? currentPage;
  @observable
  int? totalPages = 1;

  @action
  setCurrentPage(int? value) => currentPage = value;

  @action
  setTotalPages(int? value) => totalPages = value;

  _PaginatorModelBase(
      {this.currentPage, this.totalPages});

  _PaginatorModelBase.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        totalPages = json['last_page'];

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'totalPages': totalPages,
      };
}