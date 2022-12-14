// Mocks generated by Mockito 5.3.0 from annotations
// in wompi_payment_colombia/test/payment_methods/pse/pse_check_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:wompi_payment_colombia/src/src_exports.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWompiClient_0 extends _i1.SmartFake implements _i2.WompiClient {
  _FakeWompiClient_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakePsePaymentResponse_1 extends _i1.SmartFake
    implements _i2.PsePaymentResponse {
  _FakePsePaymentResponse_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakePsePaymentResponseData_2 extends _i1.SmartFake
    implements _i2.PsePaymentResponseData {
  _FakePsePaymentResponseData_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakePsePaymentResponseMeta_3 extends _i1.SmartFake
    implements _i2.PsePaymentResponseMeta {
  _FakePsePaymentResponseMeta_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [PseCheck].
///
/// See the documentation for Mockito's code generation for more information.
class MockPseCheck extends _i1.Mock implements _i2.PseCheck {
  MockPseCheck() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get transactionId =>
      (super.noSuchMethod(Invocation.getter(#transactionId), returnValue: '')
          as String);
  @override
  _i2.WompiClient get wompiClient =>
      (super.noSuchMethod(Invocation.getter(#wompiClient),
              returnValue:
                  _FakeWompiClient_0(this, Invocation.getter(#wompiClient)))
          as _i2.WompiClient);
  @override
  _i3.Future<_i2.PsePaymentResponse> checkPayment() =>
      (super.noSuchMethod(Invocation.method(#checkPayment, []),
              returnValue: _i3.Future<_i2.PsePaymentResponse>.value(
                  _FakePsePaymentResponse_1(
                      this, Invocation.method(#checkPayment, []))))
          as _i3.Future<_i2.PsePaymentResponse>);
}

/// A class which mocks [PsePaymentResponse].
///
/// See the documentation for Mockito's code generation for more information.
class MockPsePaymentResponse extends _i1.Mock
    implements _i2.PsePaymentResponse {
  MockPsePaymentResponse() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PsePaymentResponseData get data =>
      (super.noSuchMethod(Invocation.getter(#data),
              returnValue:
                  _FakePsePaymentResponseData_2(this, Invocation.getter(#data)))
          as _i2.PsePaymentResponseData);
  @override
  set data(_i2.PsePaymentResponseData? _data) =>
      super.noSuchMethod(Invocation.setter(#data, _data),
          returnValueForMissingStub: null);
  @override
  _i2.PsePaymentResponseMeta get meta =>
      (super.noSuchMethod(Invocation.getter(#meta),
              returnValue:
                  _FakePsePaymentResponseMeta_3(this, Invocation.getter(#meta)))
          as _i2.PsePaymentResponseMeta);
  @override
  set meta(_i2.PsePaymentResponseMeta? _meta) =>
      super.noSuchMethod(Invocation.setter(#meta, _meta),
          returnValueForMissingStub: null);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}
