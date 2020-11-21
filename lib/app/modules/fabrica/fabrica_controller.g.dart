// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fabrica_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $FabricaController = BindInject(
  (i) => FabricaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FabricaController on _FabricaControllerBase, Store {
  final _$valueAtom = Atom(name: '_FabricaControllerBase.value');

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

  final _$_FabricaControllerBaseActionController =
      ActionController(name: '_FabricaControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_FabricaControllerBaseActionController.startAction(
        name: '_FabricaControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_FabricaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
