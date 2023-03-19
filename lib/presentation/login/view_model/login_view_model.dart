import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/functions.dart';
import 'package:movies_app_mvvm/presentation/base/base_view_model.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:movies_app_mvvm/presentation/login/view_model/login_data_object.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final BehaviorSubject _emailStreamController = BehaviorSubject<String>();
  final BehaviorSubject _passwordStreamController = BehaviorSubject<String>();

  final BehaviorSubject<bool> _obscureTextStreamController =
      BehaviorSubject<bool>.seeded(true);

  final BehaviorSubject _areAllInputsValidStreamController =
      BehaviorSubject<void>();

  BehaviorSubject isUserLoggedInSuccessfullyStreamController =
      BehaviorSubject<bool>();

  var loginObject = LoginObject("", "");

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    _obscureTextStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    _obscureTextStreamController.add(true);
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outIsPasswordObscured => _obscureTextStreamController.stream;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
    inputAreAllInputsValid.add(null);
  }

  @override
  void togglePasswordVisibility() {
    _obscureTextStreamController.add(!_obscureTextStreamController.value);
  }

  @override
  login(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(seconds: 1));
    inputState.add(ContentState());
    isUserLoggedInSuccessfullyStreamController.add(true);
  }

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => isPasswordValid(password));

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  bool _areAllInputsValid() {
    return isPasswordValid(loginObject.password) &&
        isEmailValid(loginObject.email);
  }
}

abstract class LoginViewModelInputs {
  setEmail(String email);

  setPassword(String password);

  void togglePasswordVisibility();

  login(BuildContext context);

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outIsPasswordObscured;

  Stream<bool> get outAreAllInputsValid;
}
