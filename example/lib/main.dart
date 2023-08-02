// ignore_for_file: non_constant_identifier_names

import 'package:adyen_dropin/flutter_adyen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

String clientKey = "test_QHAHOVARCRG4FHLBMC3ORHDXFIV67HB3";
String paymentMethods =
    '{"paymentMethods":[{"brands":["amex","diners","discover","maestro","mc","visa"],"details":[{"key":"encryptedCardNumber","type":"cardToken"},{"key":"encryptedSecurityCode","type":"cardToken"},{"key":"encryptedExpiryMonth","type":"cardToken"},{"key":"encryptedExpiryYear","type":"cardToken"},{"key":"holderName","optional":true,"type":"text"}],"name":"Credit Card","type":"scheme"},{"brands":["amex","discover","maestro","mc","visa"],"configuration":{"merchantId":"000000000201422","merchantName":"Futon Limited"},"details":[{"key":"applepay.token","type":"applePayToken"}],"name":"Apple Pay","type":"applepay"},{"name":"Pay later with Klarna.","type":"klarna"},{"name":"Pay over time with Klarna.","type":"klarna_account"},{"configuration":{"merchantId":"50","gatewayMerchantId":"FutonCOM"},"details":[{"key":"paywithgoogle.token","type":"payWithGoogleToken"}],"name":"Google Pay","type":"paywithgoogle"}]}';
String publicKey =
    "10001|B90C7AA298B0FAA520D35A355F19BD682D7EE110616CA86591C7E036B3F64469C94138DECFCBB8E9CFFF5F18DD4F1A994D6CE0D755F7693DD5EDE2F45665C7DCE1A836492C6063E3061CF7718978475FBBB8FC9C71AC1734D9A35E8EA40BCD99193B44EFBFC234E45A00593B4AF9BEB03FAEDDFBE52F20DF16C1FD3A2A1EDD41307E4C374D25251D9E7AB0F38F0128DEB7BABA8AA6BDC2897609E02420AED1CAFDDF88DA302519EB605DE518399A6A77F114071FC7241C0AA6D548C0FA13D00FBFED69140FB4EAE841B72BA1A32E3C7A43F2FB22D02D5B774F4B9D6A714B463BA5FD70F0312383C742AE5E5D27B4271FE53E059368EDC5C226F0F7DC5E25701D";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _payment_result = 'Unknown';

  String? dropInResponse;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            try {
              dropInResponse = await FlutterAdyen.openDropIn(
                  paymentMethods: paymentMethods,
                  baseUrl: 'https://dev.futoncompany.co.uk/',
                  clientKey: clientKey,
                  publicKey: publicKey,
                  locale: 'GB',
                  shopperReference: 'edasdasdeqweqwdasdasdsaeqeqw',
                  reference: 'T-SO-321630',
                  returnUrl: 'coukfutoncompany://payment',
                  amount: '1230',
                  lineItem: {'id': '1', 'description': 'adyen test'},
                  currency: 'EUR',
                  additionalData: {
                    "orderId": "321630",
                  });
            } on PlatformException catch (e) {
              if (e.code == 'PAYMENT_CANCELLED')
                dropInResponse = 'Payment Cancelled';
              else
                dropInResponse = 'Payment Error';
            }

            setState(() {
              _payment_result = dropInResponse;
            });
          },
        ),
        appBar: AppBar(
          title: const Text('Flutter Adyen'),
        ),
        body: Center(
          child: Text('Payment Result: $_payment_result\n'),
        ),
      ),
    );
  }
}
