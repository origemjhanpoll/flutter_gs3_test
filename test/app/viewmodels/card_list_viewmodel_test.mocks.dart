// Mocks generated by Mockito 5.4.5 from annotations
// in flutter_gs3_test/test/app/viewmodels/card_list_viewmodel_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_gs3_test/app/models/card.dart' as _i5;
import 'package:flutter_gs3_test/app/services/card_service.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [CardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCardService extends _i1.Mock implements _i3.CardService {
  MockCardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client =>
      (super.noSuchMethod(
            Invocation.getter(#client),
            returnValue: _FakeClient_0(this, Invocation.getter(#client)),
          )
          as _i2.Client);

  @override
  _i4.Future<List<_i5.BankCard>> loadCards() =>
      (super.noSuchMethod(
            Invocation.method(#loadCards, []),
            returnValue: _i4.Future<List<_i5.BankCard>>.value(<_i5.BankCard>[]),
          )
          as _i4.Future<List<_i5.BankCard>>);
}
