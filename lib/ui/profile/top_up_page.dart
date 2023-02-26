import 'dart:async';
import 'dart:io';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common_widgets/app_widgets/back_button_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../model/syberPay/top_up_param.dart';

class TopUpPage extends StatefulWidget {
  static const route = "/top_up_page";

  final TopUpParam topUpParam;

  const TopUpPage({Key? key, required this.topUpParam}) : super(key: key);

  @override
  TopUpPageState createState() => TopUpPageState();
}

bool loading = false;
double myHeight = 1;


class TopUpPageState extends State<TopUpPage> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  //final flutterWebViewPlugin = new FlutterWebviewPlugin();
  //late StreamSubscription _onDestroy;
  //late StreamSubscription<String> _onUrlChanged;
  //late StreamSubscription<WebViewStateChanged> _onStateChanged;


  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    //_onDestroy.cancel();
    //_onUrlChanged.cancel();
    //_onStateChanged.cancel();
    //flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    /*flutterWebViewPlugin.close();
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      print("destroy");
    });*/

    /*_onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          print("onStateChanged: ${state.type} ${state.url}");
        });*/


    /*
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
    */

  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
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

              WebView(initialUrl: widget.topUpParam.paymentUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  print('WebView is loading (progress : $progress%)');
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },
                navigationDelegate: (NavigationRequest request) {
                  /*if ((request.url.startsWith(
                      "https://syberpay.sybertechnology.com/syberpay/process")) ||
                      ((request.url.startsWith(
                          "https://syberpay.sybertechnology.com:443/syberpay/process")))) */


                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');

                  String fullUrl = "https://syberpay.sybertechnology.com/syberpay/process/"+ (widget.topUpParam.transactionId??"");
                  if (url == fullUrl)
                  {
                    if (mounted) {
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                  }
                },
                gestureNavigationEnabled: true,
                backgroundColor: const Color(0x00000000),
              ),

              /*WebviewScaffold(

                url: widget.paymentUrl,

              initialChild: Container(
                color: backgroundColor1,
                child: Align(
                  child: CustomLoading(),
                  alignment: AlignmentDirectional.center,
                ),
              ),
              ),*/


              padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
            )),
          ],
        )));
  }
}
