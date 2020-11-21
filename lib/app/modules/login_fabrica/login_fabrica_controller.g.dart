// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_fabrica_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $LoginFabricaController = BindInject(
  (i) => LoginFabricaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginFabricaController on _LoginFabricaControllerBase, Store {
  final _$valueAtom = Atom(name: '_LoginFabricaControllerBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_LoginFabricaControllerBaseActionController =
      ActionController(name: '_LoginFabricaControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_LoginFabricaControllerBaseActionController
        .startAction(name: '_LoginFabricaControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_LoginFabricaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
