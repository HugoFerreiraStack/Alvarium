// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lojas_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $LojasController = BindInject(
  (i) => LojasController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LojasController on _LojasControllerBase, Store {
  final _$valueAtom = Atom(name: '_LojasControllerBase.value');

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

  final _$_LojasControllerBaseActionController =
      ActionController(name: '_LojasControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_LojasControllerBaseActionController.startAction(
        name: '_LojasControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_LojasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
