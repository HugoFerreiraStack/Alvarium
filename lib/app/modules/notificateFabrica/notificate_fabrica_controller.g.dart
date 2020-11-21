// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificate_fabrica_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $NotificateFabricaController = BindInject(
  (i) => NotificateFabricaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificateFabricaController on _NotificateFabricaControllerBase, Store {
  final _$valueAtom = Atom(name: '_NotificateFabricaControllerBase.value');

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

  final _$_NotificateFabricaControllerBaseActionController =
      ActionController(name: '_NotificateFabricaControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_NotificateFabricaControllerBaseActionController
        .startAction(name: '_NotificateFabricaControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_NotificateFabricaControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
