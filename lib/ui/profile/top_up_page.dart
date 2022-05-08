import 'dart:async';
import 'dart:io';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../common_widgets/app_widgets/back_button_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';

class TopUpPage extends StatefulWidget {
  static const route = "/top_up_page";

  final String paymentUrl;

  const TopUpPage({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  TopUpPageState createState() => TopUpPageState();
}

bool loading = false;
double myHeight = 1;


class TopUpPageState extends State<TopUpPage> {

  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  late StreamSubscription _onDestroy;
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;


  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          print("onStateChanged: ${state.type} ${state.url}");
        });

    // Enable virtual display.
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {


      print(url);


      if ((url.startsWith(
          "https://syberpay.sybertechnology.com/syberpay/process")) ||
          ((url.startsWith(
              "https://syberpay.sybertechnology.com:443/syberpay/process")))) {



        if (mounted) {
          setState(() {
            Navigator.pop(context, true);
          });
        }


      }


    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor1,
        body: Container(
            child: Column(
          children: [
            Row(
              children: [
                BackButtonWidget(context),
                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.syberPay"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                      padding: EdgeInsetsDirectional.only(
                        start: SizeConfig().w(25),
                        end: SizeConfig().w(25),
                      )),
                  alignment: AlignmentDirectional.topStart,
                )
              ],
            ),
            Expanded(
                child: Padding(
              child:
              WebviewScaffold(

                url: widget.paymentUrl,

              initialChild: Container(
                color: backgroundColor1,
                child: Align(
                  child: CustomLoading(),
                  alignment: AlignmentDirectional.center,
                ),
              ),
              ),
              /*InAppWebView(
                      onLoadStart:
                          (InAppWebViewController controller, Uri? uri) {
                        if (mounted) {
                          setState(() {
                            loading = true;
                          });
                        }
                      },
                      onLoadError: (controller, uri, code, msg) {
                        if (mounted) {
                          setState(() {
                            loading = false;
                          });
                        }
                        ;
                      },
                      onLoadHttpError: (controller, uri, code, msg) {
                        if (mounted) {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      onLoadStop:
                          (InAppWebViewController controller, Uri? uri) {
                        if ((uri.toString().startsWith(
                                "https://syberpay.sybertechnology.com/syberpay/payment")) ||
                            ((uri.toString().startsWith(
                                "https://syberpay.sybertechnology.com:443/syberpay/payment")))) {
                          if (mounted) {
                            setState(() {
                              loading = false;
                            });
                          }
                        } else {
                          if ((uri.toString().startsWith(
                                  "https://syberpay.sybertechnology.com/syberpay/process")) ||
                              ((uri.toString().startsWith(
                                  "https://syberpay.sybertechnology.com:443/syberpay/process")))) {
                            if (mounted) {
                              setState(() {
                                loading = true;
                                Navigator.pop(context, true);
                              });
                            }
                          } else {
                            if (mounted) {
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        }
                      },
                      initialUrlRequest:
                          URLRequest(url: Uri.parse(widget.paymentUrl)),
                      onWebViewCreated: (InAppWebViewController controller) {
                        webviewController = controller;
                      },
                    ),*/
              padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
            )),
          ],
        )));
  }
}
