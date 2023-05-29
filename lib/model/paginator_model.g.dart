// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginator_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaginatorModel on _PaginatorModelBase, Store {
  late final _$currentPageAtom =
      Atom(name: '_PaginatorModelBase.currentPage', context: context);

  @override
  int? get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int? value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$totalPagesAtom =
      Atom(name: '_PaginatorModelBase.totalPages', context: context);

  @override
  int? get totalPages {
    _$totalPagesAtom.reportRead();
    return super.totalPages;
  }

  @override
  set totalPages(int? value) {
    _$totalPagesAtom.reportWrite(value, super.totalPages, () {
      super.totalPages = value;
    });
  }

  late final _$_PaginatorModelBaseActionController =
      ActionController(name: '_PaginatorModelBase', context: context);

  @override
  dynamic setCurrentPage(int? value) {
    final _$actionInfo = _$_PaginatorModelBaseActionController.startAction(
        name: '_PaginatorModelBase.setCurrentPage');
    try {
      return super.setCurrentPage(value);
    } finally {
      _$_PaginatorModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTotalPages(int? value) {
    final _$actionInfo = _$_PaginatorModelBaseActionController.startAction(
        name: '_PaginatorModelBase.setTotalPages');
    try {
      return super.setTotalPages(value);
    } finally {
      _$_PaginatorModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
totalPages: ${totalPages}
    ''';
  }
}
