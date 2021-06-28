import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:uni_mindelo/utils/constants/colors.dart';
import 'package:uni_mindelo/utils/services/dialogService.dart';
import 'package:uni_mindelo/widgets/appBar.dart';

class Payment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaymentState();
  }
}

class PaymentState extends State<Payment> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: translate("APP_BAR.TITLE.PAYMENT"),
        canBack: false,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardBgColor: creditCardColor,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      formKey: formKey,
                      onCreditCardModelChange: onCreditCardModelChange,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumberDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: translate("PAYMENT.LABEL_NUMBER"),
                        hintText: translate("PAYMENT.HINT_NUMBER"),
                      ),
                      expiryDateDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: translate("PAYMENT.LABEL_DATE"),
                        hintText: translate("PAYMENT.HINT_DATE"),
                      ),
                      cvvCodeDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: translate("PAYMENT.LABEL_CVV"),
                        hintText: translate("PAYMENT.HINT_CVV"),
                      ),
                      cardHolderDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: translate("PAYMENT.LABEL_CARD_HOLDER"),
                      ),
                      cardHolderName: '',
                      cardNumber: '',
                      cvvCode: '',
                      expiryDate: '',
                      themeColor: creditCardColorBtPay,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        width: 100,
                        child: Text(
                          translate("PAYMENT.BT_PAY"),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: PrimaryWhiteAssentColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      color: creditCardColorBtPay,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _showDialog(translate("PAYMENT.VALID_PAYMENT_TITLE"),
                              translate("PAYMENT.VALID_PAYMENT_SUBTITLE"));
                          /* DO SOMETHING ON THE SERVER */
                        } else {}
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDialog(String title, String subTitle) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogService(
              subTitle: subTitle,
              title: title,
              dismissOnPopLogin: false,
              isCreditCard: true);
        });
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
