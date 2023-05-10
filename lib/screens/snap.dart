import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/snap_configuration.dart';
//import 'package:flutter_midtrans/helpers/utils.dart';
//import 'package:flutter_midtrans/widgets/common/button_widget.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:nunut_application/resources/midtransApi.dart';

class SnapScreen extends StatefulWidget {
  final String transactionToken;

  SnapScreen({
    required this.transactionToken,
  });

  @override
  _SnapScreenState createState() => _SnapScreenState();
}

class _SnapScreenState extends State<SnapScreen> {
  late WebViewController _controller;
  bool _isLoading = false;
  bool _modalShow = false;

  @override
  void initState() {
    print(widget.transactionToken);
    _isLoading = true;
    super.initState();
  }

  @override
  void didUpdateWidget(SnapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WebViewController _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Print', onMessageReceived: (JavaScriptMessage receiver) {
        log(json.decode(receiver.message).toString());
        // print('==========>>>>>>>>>>>>>> BEGIN PRINT');
        // log(receiver.message);
        if (receiver.message != 'undefined') {
          if (receiver.message == 'close') {
            Navigator.pop(context);
          } else {
            Map<String, dynamic> response = jsonDecode(receiver.message);
            String status = "pending";
            switch (response['transaction_status']) {
              case 'capture':
                status = "ok";
                break;
              case 'settlement':
                status = "ok";
                break;
              case 'deny':
                status = "error";
                break;
              case 'cancel':
                status = "close";
                break;
              case 'expire':
                status = "error";
                break;
              case 'pending':
                status = "pending";
                break;
              default:
                status = "pending";
                break;
            }

            Map<String, dynamic> data = {"status": status, "payment_type": response['payment_type'], "order_id": response['order_id']};

            _handleResponse(data, context);
          }
        }
        // print('==========>>>>>>>>>>>>>> END');
      })
      ..addJavaScriptChannel(
        'Android',
        onMessageReceived: (JavaScriptMessage receiver) {
          // print('==========>>>>>>>>>>>>>> BEGIN');
          // print(receiver.message);
          log(json.decode(receiver.message).toString());
          if (Platform.isAndroid) {
            if (receiver.message != 'undefined') {
              if (receiver.message == 'close') {
                Navigator.pop(context);
              } else {
                Map<String, dynamic> response = jsonDecode(receiver.message);
                String status = "pending";
                switch (response['transaction_status']) {
                  case 'capture':
                    status = "ok";
                    break;
                  case 'settlement':
                    status = "ok";
                    break;
                  case 'deny':
                    status = "error";
                    break;
                  case 'cancel':
                    status = "close";
                    break;
                  case 'expire':
                    status = "error";
                    break;
                  case 'pending':
                    status = "pending";
                    break;
                  default:
                    status = "pending";
                    break;
                }

                Map<String, dynamic> data = {"status": status, "payment_type": response['payment_type'], "order_id": response['order_id']};

                _handleResponse(data, context);
              }
            }
          }
          // print('==========>>>>>>>>>>>>>> END');
        },
      )
      ..loadRequest(Uri.dataFromString('''<html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script 
          type="text/javascript"
          src="https://app.midtrans.com/snap/snap.js"
          data-client-key="Mid-client--XRbVedkdIW_kGcG"
        ></script>
      </head>
      <body onload="setTimeout(function(){pay()}, 1000)">
        <script type="text/javascript">
            function pay() {
                snap.pay('${widget.transactionToken}', {
                  // Optional
                  onSuccess: function(result) {
                    Print.postMessage(JSON.stringify(result));
                  },
                  // Optional
                  onPending: function(result) {
                    Print.postMessage(JSON.stringify(result));
                  },
                  // Optional
                  onError: function(result) {
                    Print.postMessage(JSON.stringify(result));
                  },
                  onClose: function(result) {
                    Print.postMessage(JSON.stringify(result));
                  }
                });
            }
        </script>
      </body>
    </html>''', mimeType: 'text/html', encoding: Encoding.getByName('utf-8')))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {},
        onPageFinished: (url) {
          if (this.mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        },
      ));
    return Scaffold(
      // appBar: AppBar(
      //   title: NunutText(
      //     title: 'PAYMENT',
      //     size: 18,
      //     fontWeight: FontWeight.w600,
      //   ),
      //   elevation: 2,
      // ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Stack(
          children: <Widget>[WebViewWidget(controller: _controller)],
        ),
      ),
    );
  }

  _handleResponse(data, BuildContext rootcontext) async {
    try {
      var title, desc;
      Midtrans midtrans = Midtrans(MIDTRANS_PAYMENT_TYPE.bank_transfer, MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_200);
      if (Platform.isAndroid) {
        switch (data['status']) {
          case 'ok':
            midtrans = Midtrans(MIDTRANS_PAYMENT_TYPE.bank_transfer, MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_200);
            break;
          case 'pending':
            midtrans = Midtrans(MIDTRANS_PAYMENT_TYPE.bank_transfer, MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_201);
            break;
          case 'error':
            midtrans = Midtrans(MIDTRANS_PAYMENT_TYPE.bank_transfer, MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_202);
            break;
        }
      } else {
        midtrans = Midtrans.fromString(data);
      }
      var result = midtrans.getResult();
      title = result[0];
      desc = result[1];
      if (title.length == 0 && desc.length == 0) {
        Fluttertoast.showToast(msg: 'Something went wrong!');
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      } else {
        Result result = await MidtransApi.handleTopup(data['order_id'], data['payment_type'], data['status']);
        if (result.status != 200) {
          Fluttertoast.showToast(msg: 'Something went wrong while handling response: ' + result.message);
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
          return;
        } else {
          _showConfirmDialog(title, desc, rootcontext);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong' + e.toString());
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    }
  }

  void _showConfirmDialog(title, desc, BuildContext rootcontext) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NunutText(title: title, size: 18, fontWeight: FontWeight.w600),
                SizedBox(
                  height: 25,
                ),
                NunutText(title: desc, size: 14, fontWeight: FontWeight.w400),
                SizedBox(
                  height: 25,
                ),
                NunutButton(
                  title: "Close",
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

enum MIDTRANS_PAYMENT_TYPE {
  // credit_card,
  // bca_klikpay,
  // bca_klikbca,
  // bri_epay,
  // telkomsel_cash,
  bank_transfer,
  gopay,
  // echannel,
  // indosat_dompetku,
  // cstore
}

const Map<String, MIDTRANS_PAYMENT_TYPE> MidtransPaymentTypeMap = {
  // 'credit_card': MIDTRANS_PAYMENT_TYPE.credit_card,
  // 'bca_klikpay': MIDTRANS_PAYMENT_TYPE.bca_klikpay,
  // 'bca_klikbca': MIDTRANS_PAYMENT_TYPE.bca_klikbca,
  // 'bri_epay': MIDTRANS_PAYMENT_TYPE.bri_epay,
  // 'telkomsel_cash': MIDTRANS_PAYMENT_TYPE.telkomsel_cash,
  'bank_transfer': MIDTRANS_PAYMENT_TYPE.bank_transfer,
  'gopay': MIDTRANS_PAYMENT_TYPE.gopay,
  // 'echannel': MIDTRANS_PAYMENT_TYPE.echannel,
  // 'indosat_dompetku': MIDTRANS_PAYMENT_TYPE.indosat_dompetku,
  // 'cstore': MIDTRANS_PAYMENT_TYPE.cstore,
};

enum MIDTRANS_STATUS_CODE {
  MIDTRANS_STATUS_CODE_200,
  MIDTRANS_STATUS_CODE_201,
  MIDTRANS_STATUS_CODE_202,
  MIDTRANS_STATUS_CODE_300,
  MIDTRANS_STATUS_CODE_400,
  MIDTRANS_STATUS_CODE_401,
  MIDTRANS_STATUS_CODE_402,
  MIDTRANS_STATUS_CODE_403,
  MIDTRANS_STATUS_CODE_404,
  MIDTRANS_STATUS_CODE_405,
  MIDTRANS_STATUS_CODE_406,
  MIDTRANS_STATUS_CODE_407,
  MIDTRANS_STATUS_CODE_408,
  MIDTRANS_STATUS_CODE_409,
  MIDTRANS_STATUS_CODE_410,
  MIDTRANS_STATUS_CODE_411,
  MIDTRANS_STATUS_CODE_412,
  MIDTRANS_STATUS_CODE_413,
  MIDTRANS_STATUS_CODE_500,
  MIDTRANS_STATUS_CODE_501,
  MIDTRANS_STATUS_CODE_502,
  MIDTRANS_STATUS_CODE_503,
  MIDTRANS_STATUS_CODE_504,
}

const Map<int, MIDTRANS_STATUS_CODE> MidtransStatusCodeMap = {
  200: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_200,
  201: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_201,
  202: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_202,
  300: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_300,
  400: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_400,
  401: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_401,
  402: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_402,
  403: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_403,
  404: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_404,
  405: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_405,
  406: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_406,
  407: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_407,
  408: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_408,
  409: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_409,
  410: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_410,
  411: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_411,
  412: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_412,
  413: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_413,
  500: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_500,
  501: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_501,
  502: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_502,
  503: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_503,
  504: MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_504,
};

class Midtrans {
  MIDTRANS_PAYMENT_TYPE paymentType = MIDTRANS_PAYMENT_TYPE.bank_transfer;
  MIDTRANS_STATUS_CODE statusCode = MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_200;

  Midtrans(MIDTRANS_PAYMENT_TYPE type, MIDTRANS_STATUS_CODE code) {
    paymentType = type;

    statusCode = code;
  }

  Midtrans.fromString(String message) {
    String? codeStr = RegExp(r'"status_code".*').stringMatch(message);
    int code = int.parse(RegExp(r'\d+;$').stringMatch(codeStr!)!.replaceAll(RegExp(r';'), ''));
    statusCode = MidtransStatusCodeMap[code]!;

    String? typeStr = RegExp(r'"payment_type".*').stringMatch(message);
    typeStr = RegExp(r'"?\w+"?;').stringMatch(typeStr!)!.replaceAll(RegExp(r'[;"]'), '');
    paymentType = MidtransPaymentTypeMap[typeStr]!;
  }

  List<String> getResult() {
    String title = '', desc = '';
    switch (statusCode) {
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_200:
        title = 'Purchase successfully!';
        break;

      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_201:
        title = 'Purchase successfully!';

        if (paymentType == MIDTRANS_PAYMENT_TYPE.bank_transfer) {
          desc = 'You have 24 hours to send money.';
        }
        break;
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_202:
        title = 'Fraud detection!';
        desc = 'Your payment is denied.';
        break;
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_300:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_400:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_401:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_402:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_403:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_404:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_405:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_406:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_407:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_408:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_409:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_410:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_411:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_412:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_413:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_500:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_501:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_502:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_503:
      case MIDTRANS_STATUS_CODE.MIDTRANS_STATUS_CODE_504:
    }
    return [title, desc];
  }
}
