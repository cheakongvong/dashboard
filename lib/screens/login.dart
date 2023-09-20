import 'dart:async' show Timer;
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../services/authentication_service.dart';

class _NumPadLayout extends StatelessWidget {
  final String number;
  final void Function({String? digit, bool isRemoved}) onChanged;
  final Widget child;
  const _NumPadLayout({
    Key? key,
    required this.number,
    required this.onChanged,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).dividerColor,
      padding: EdgeInsets.only(
        bottom: kIsWeb
            ? 16
            : Platform.isAndroid ||
                    (Platform.isIOS &&
                        MediaQuery.of(context).viewPadding.bottom < 10)
                ? 16
                : MediaQuery.of(context).viewPadding.bottom,
      ),
      child: Column(
        children: [
          Expanded(child: child),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
            ),
            childAspectRatio: 6,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ...List.generate(
                9,
                (index) => _NumPadButton(
                  number: (index + 1).toString(),
                  onTap: () => onChanged(digit: (index + 1).toString()),
                ),
              ),
              _NumPadButton(number: '+', onTap: () => onChanged(digit: '+')),
              _NumPadButton(number: '0', onTap: () => onChanged(digit: '0')),
              _NumPadButton(
                onTap: () => onChanged(isRemoved: true),
                child: Icon(
                  Icons.backspace_outlined,
                  color: Theme.of(context).textTheme.displayMedium!.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NumPadButton extends StatelessWidget {
  final String? number;
  final Widget? child;
  final void Function()? onTap;
  const _NumPadButton({
    Key? key,
    this.number,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      assert(number != null || child != null);
    } catch (_) {
      debugPrint("Error Assertion");
      return const SizedBox.shrink();
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(15),
          ),
          child: number != null
              ? Text(
                  number!,
                  textScaleFactor: 1,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontFamily: 'Nokora'),
                )
              : child,
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  final void Function() getProfileCallback;
  const Login({
    Key? key,
    required this.getProfileCallback,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneNumberController = TextEditingController();

  String _phoneNumber = '';
  String _formattedPhoneNumber = '';
  void _changePhoneNumber({String? digit, bool isRemoved = false}) {
    try {
      assert(isRemoved && digit == null || digit != null && !isRemoved);
      isRemoved
          ? _phoneNumber = _phoneNumber.isNotEmpty
              ? _phoneNumber.substring(0, _phoneNumber.length - 1)
              : ''
          : _phoneNumber.length < 18
              ? _phoneNumber += digit!
              : null;
      _phoneNumberController.text = _phoneNumber;
      _phoneNumberController.selection =
          TextSelection.fromPosition(TextPosition(offset: _phoneNumber.length));
      setState(() {});
    } catch (e) {
      debugPrint("Failed Assertion: $e");
    }
  }

  String _smsCodeId = '';
  void setData(String verificationId) {
    setState(() => _smsCodeId = verificationId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _VerifySmsCodeScreen(
          phoneNumber: _formattedPhoneNumber,
          controlCodeId: _smsCodeId,
          setProfileCallback: widget.getProfileCallback,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _NumPadLayout(
      number: _phoneNumber,
      onChanged: _changePhoneNumber,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.8),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight + 32),
            Expanded(
              child: Image.asset(
                'assets/lg_verify.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'AppLocalizations.of(context)!.lgInfo',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor,
                    offset: const Offset(0, -3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'AppLocalizations.of(context)!.lgEnterPhone',
                        ),
                        TextField(
                          controller: _phoneNumberController,
                          autocorrect: false,
                          autofocus: true,
                          maxLength: 18,
                          // onChanged: widget.onChangedCallback,
                          cursorColor: Theme.of(context).primaryColor,
                          cursorHeight: 17 * 1 * 1.3,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isCollapsed: true,
                            counterText: '',
                            hintText: '012 345 678',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.none,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextButton(
                      onPressed: _phoneNumber.isNotEmpty
                          ? () async {
                              setState(() => _formattedPhoneNumber =
                                  '+855${_phoneNumber[0] == '0' ? _phoneNumber.substring(1) : _phoneNumber}');
                              await AuthService().verifyPhoneNumber(
                                  context, _formattedPhoneNumber, 91, setData);
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          _phoneNumber.isNotEmpty
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).disabledColor,
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).cardColor.withOpacity(0.1),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30 - 16)),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                            horizontal: 2 * 16,
                            vertical: 10,
                          ),
                        ),
                      ),
                      child: const Text(
                        'AppLocalizations.of(context)!.lgSendCode',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerifySmsCodeScreen extends StatefulWidget {
  final String phoneNumber;
  final String controlCodeId;
  final void Function() setProfileCallback;
  const _VerifySmsCodeScreen({
    Key? key,
    required this.phoneNumber,
    required this.controlCodeId,
    required this.setProfileCallback,
  }) : super(key: key);

  @override
  State<_VerifySmsCodeScreen> createState() => _VerifySmsCodeScreenState();
}

class _VerifySmsCodeScreenState extends State<_VerifySmsCodeScreen> {
  String _smsCode = '';
  void _changeSmsCode({String? digit, bool isRemoved = false}) async {
    try {
      assert((isRemoved && digit == null) || (digit != null && !isRemoved));
      setState(() => isRemoved
          ? _smsCode = _smsCode.isNotEmpty
              ? _smsCode.substring(0, _smsCode.length - 1)
              : ''
          : _smsCode += digit!);
      if (!isRemoved && _smsCode.length >= 6) {
        await AuthService().signInWithPhoneNumber(
          context,
          widget.controlCodeId,
          _smsCode,
          widget.setProfileCallback,
        );
      }
    } catch (e) {
      debugPrint("Failed Assertion: $e");
    }
  }

  int _countSeconds = 90;
  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_countSeconds <= 1) {
            timer.cancel();
            Navigator.pop(context);
          } else {
            _countSeconds--;
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(
          left: 16,
          top: 10,
        ),
        child: Icon(Icons.arrow_back_ios),
      ),
      body: _NumPadLayout(
        number: _smsCode,
        onChanged: _changeSmsCode,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.8),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: kToolbarHeight + 32),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: RichText(
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              text: TextSpan(
                                text:
                                    '${'AppLocalizations.of(context)!.lgCodeSentInfo'}\n',
                                children: [
                                  TextSpan(
                                    text: widget.phoneNumber,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2 * 16,
                            ),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(16),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      6,
                                      (index) {
                                        final bool show =
                                            index > _smsCode.length - 1;
                                        return GestureDetector(
                                          onTap: () => setState(() => _smsCode =
                                              _smsCode.substring(
                                                  0,
                                                  index < _smsCode.length
                                                      ? index
                                                      : null)),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: show
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.6)
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              index < _smsCode.length
                                                  ? _smsCode[index]
                                                  : '$index',
                                              textScaleFactor: 1,
                                              style: show
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          color: Colors
                                                              .transparent,
                                                          fontFamily: 'Nokora')
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          fontFamily: 'Nokora'),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: const Text(
                                    'AppLocalizations.of(context)!.lgEnterCode',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'AppLocalizations.of(context)!.lgNavigatorPop',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 10 / 2),
                                Text(
                                  '$_countSeconds',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor,
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).cardColor.withOpacity(0.1),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30 - 16)),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                            horizontal: 2 * 16,
                            vertical: 10,
                          ),
                        ),
                      ),
                      child: const Text(
                        'AppLocalizations.of(context)!.lgVerifyCode',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
