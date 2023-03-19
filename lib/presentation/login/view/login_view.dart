import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movies_app_mvvm/app/app_preferences.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';
import 'package:movies_app_mvvm/app/resources/assets_manager.dart';
import 'package:movies_app_mvvm/app/resources/routes_manager.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:movies_app_mvvm/presentation/login/view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _loginViewModel.start(); // tell viewmodel, start ur job
    _emailController
        .addListener(() => _loginViewModel.setEmail(_emailController.text));
    _passwordController.addListener(
        () => _loginViewModel.setPassword(_passwordController.text));

    _loginViewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<FlowState>(
      stream: _loginViewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(
              context: context,
              contentScreenWidget: _getContentWidget(),
              retryActionFunction: () {},
            ) ??
            _getContentWidget();
      },
    ));
  }

  Widget _getContentWidget() {
    return GestureDetector(
      onTap: () {
        // to detect when the user taps outside of the text fields to dismiss the keyboard
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ..._loginViewHeaders(),
                  ..._loginViewImage(),
                  ..._loginViewTextFields(),
                  const SizedBox(height: AppSize.s16),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppStrings.forgotPassword,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _loginViewLoginButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _loginViewHeaders() => [
        Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p8,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              AppStrings.welcome,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p8,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              AppStrings.loginToContinue,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        )
      ];
  List<Widget> _loginViewImage() => [
        const SizedBox(height: AppSize.s60),
        Image.asset(
          ImageAssets.logoWithPopcorn,
        ),
        const SizedBox(height: AppSize.s40),
      ];
  List<Widget> _loginViewTextFields() => [
        StreamBuilder<bool>(
          stream: _loginViewModel.outIsEmailValid,
          builder: (context, snapshot) {
            return TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppStrings.enterEmail,
                  errorText:
                      (snapshot.data ?? true) ? null : AppStrings.emailError),
              style: Theme.of(context).textTheme.labelSmall,
            );
          },
        ),
        const SizedBox(height: AppSize.s16),
        StreamBuilder<bool>(
          stream: _loginViewModel.outIsPasswordValid,
          builder: (context, snapshotIsPasswordValid) {
            return StreamBuilder<bool>(
              stream: _loginViewModel.outIsPasswordObscured,
              builder: (context, snapshotObscureText) {
                return TextFormField(
                  obscureText: snapshotObscureText.data ?? true,
                  controller: _passwordController,
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(snapshotObscureText.data ?? true
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () =>
                            _loginViewModel.togglePasswordVisibility(),
                      ),
                      hintText: AppStrings.enterPassword,
                      errorText: (snapshotIsPasswordValid.data ?? true)
                          ? null
                          : AppStrings.passwordError),
                );
              },
            );
          },
        ),
      ];

  Widget _loginViewLoginButton() => StreamBuilder<bool>(
        stream: _loginViewModel.outAreAllInputsValid,
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: (snapshot.data ?? false)
                ? () async {
                    _loginViewModel.login(context);
                  }
                : null,
            child: const Text(
              AppStrings.login,
            ),
          );
        },
      );
}
