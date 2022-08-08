import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DialogController{
  DialogController();

  /// network dialog
  void showNetworkDialog({BuildContext? context, String? title, String? message}) {
    if (context == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppAlertDialog(title: title ?? 'Title', message: message ?? 'Message',),
    );
  }

  /// normal dialog
  void showDefaultDialog({BuildContext? context, String? title, String? message}) {
    if (context == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AppAlertDialog(title: title ?? 'Title',message: message ?? 'Message',),
    );
  }

  /// confirm dialog
  void showConfirmDialog({BuildContext? context, String? title, String? message, required Function buttonOKCallback}) {
    if (context == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ConfirmAlertDialog(
        title: title ?? 'Title',
        message: message ?? 'Message',
        onOkPress: () => buttonOKCallback(),
      ),
    );
  }
}

class AppAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;

  const AppAlertDialog({Key? key, this.title = "Alert", this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? 'Alert'),
      content: Text(message ?? 'Message'),
      actions: <Widget>[
        TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: const Text("OK")),
      ],
    );
  }
}

class ConfirmAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Function? onOkPress;

  const ConfirmAlertDialog({
    Key? key,
    this.title = "Alert",
    this.message,
    this.onOkPress,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? 'Title'),
      content: Text(message ?? 'Message'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            onOkPress!();
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}


class NetworkDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Function? onClose;
  const NetworkDialog({Key? key, this.title, this.message, this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Container(
          height: 200,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 40, right: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Text(
                  title ?? 'Title',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15,),
                Text(
                  message ?? 'Message',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15,),
                const Spacer(),
                const Divider(color: Colors.black,height: 1,),
                TextButton(
                  style: const ButtonStyle(
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onClose != null) {
                      onClose!();
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
