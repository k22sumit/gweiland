import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gweiland/ui/features/dapp_actions.dart';
import 'package:gweiland/ui/features/widgets/custom/nsalert_dialog.dart';
import 'package:gweiland/ui/features/widgets/custom/other_custom_widgets.dart';
import 'package:gweiland/ui/features/widgets/custom/show_snack_bar.dart';
import '../../bloc/metamask_auth_bloc.dart';
import '../../bloc/wallet_event.dart';
import '../../bloc/wallet_state.dart';
import '../../utils/constants/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  BuildContext? dialogContext;
  final String signatureFromBackend = "Sumit";

  @override
  Widget build(BuildContext context) {
    return BlocListener<MetaMaskAuthBloc, WalletState>(
      listener: (context, state) {
        if (state is WalletErrorState) {
          hideDialog(dialogContext);
          ShowSnackBar.buildSnackbar(context, state.message, true);
        } else if (state is WalletReceivedSignatureState) {
          //received signature from metamask success
          hideDialog(dialogContext);
          ShowSnackBar.buildSnackbar(
              context, AppConstants.authenticationSuccessful);
        }
      },
      child:SafeArea(
        child: Scaffold(

            body:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: Text("MetaMask SDK App",style: TextStyle(
                        fontSize: 25
                    ),))),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextButton(onPressed:  () {
                        BlocProvider.of<MetaMaskAuthBloc>(context).add(
                           MetamaskAuthEvent(signatureFromBackend: signatureFromBackend),
                        );
                        buildShowDialog(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DappActions()));

                      }, child: Container(
                        width: 450,
                        child: Center(
                          child: Text("Connect",style: TextStyle(
                              fontSize: 25,
                              color: Colors.white
                          ),),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)
                        ),
                      )),
                      TextButton(onPressed: (){}, child: Container(
                        width: 450,
                        child: Center(
                          child: Text("Clear Session",style: TextStyle(
                              fontSize: 25,
                              color: Colors.white
                          ),),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)
                        ),
                      )),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                )
              ],
            )
        ),
      ),

    );
  }


  buildShowDialog(BuildContext context) {
    return showDialog(
        context: _scaffoldKey.currentContext ?? context,
        barrierDismissible: true, //if user should not
        //cancel this dialog then set as false
        builder: (BuildContext dialogContextL) {
          dialogContext = dialogContextL;
          return BlocBuilder<MetaMaskAuthBloc, WalletState>(
              builder: (context, state) {
                return NSAlertDialog(
                  textWidget: getText(state),
                );
              });
        });
  }

  getText(WalletState state) {
    String message = "";
    if (state is WalletInitializedState) {
      //initialized metamask success
      message = state.message;
    } else if (state is WalletAuthorizedState) {
      //received authorized approval success
      message = state.message;
    } else if (state is WalletReceivedSignatureState) {
      //received signature from metamask success
      message = state.message;
    }
    return Text(
      message,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }
}

