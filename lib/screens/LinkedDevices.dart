import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/PushMessageType.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/MLinkedDevice.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
import 'package:lucas/screens/UserAccount.dart';
//import 'package:get_ip/get_ip.dart';
import 'package:lucas/helpers/SyncClient.dart';

class LinkedDevices extends StatefulWidget {
  LinkedDevices({Key key}) : super(key: key);

  @override
  _LinkedDevicesState createState() => _LinkedDevicesState();
}

class _LinkedDevicesState extends State<LinkedDevices> {
  List<String> translationItems = [
    'linked devices',
    'warning',
    'email or name not filled',
    'user profile',
    'add new device',
    'remote user email',
    'remote user email instructions',
    'enter remote user email',
    'please enter remote email',
    'close',
    'invite sent',
    'recieved invite',
    'accept',
    'ignore and dismiss',
    'invite confirmed',
    'invite accepted',
    'remember link other party',
    'invite rejected',
    'echo device',
    'device silent',
    'device blocked',
    'device unblocked',
    'delete linked device',
    'confirm delete linked device',
    'not connected to internet',
    'check connection',
  ];

  Map<String, String> translations = Map<String, String>();
  String remoteUserEmail = '';
  String _localUserEmail = '';

  bool inviteSend = false;
  bool inviteRecieved = false;
  bool inviteRejected = false;
  bool inviteConfirmationRecieved = false;
  bool inviteConfirmationSend = false;
  bool isShowingInviteCard = false;
  bool connectedToInternet = false;

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _localToken = '';
  //String _messageText = '';
  Map<String, dynamic> inviteMessage = new Map();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<MLinkedDevice> linkedDevices = <MLinkedDevice>[];

  ServerSocket server;
  // Socket clientToRemoteServer;
  // Socket clientToLocalServer;
  // Socket client;
  //String serverIpAddress = '';
  SyncClient client;
  bool connectionEstablished = false;
  String textToSend = '';

  _LinkedDevicesState() {
    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }
  }

  @override
  void initState() {
    super.initState();

    initialize().then((result) {
      setState(() {});
    });

    //_firebaseMessaging.configure(
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      String senderEmail = getValueInMessage(message.data, 'sender email');
      if (_localUserEmail != senderEmail) {
        String messageType = getValueInMessage(message.data, 'message type');

        //if (messageType != PushMessageType.objectChunk)
        showMessageTypeInSnackbar(messageType, Icon(Icons.cloud_download));

        if (messageType == PushMessageType.invite) {
          if (mounted) {
            setState(() {
              inviteMessage = message.data;
              inviteRecieved = true;
            });
          }

          await saveLinkedDevice(message.data);
        }

        if (messageType == PushMessageType.inviteConfirmation) {
          if (mounted) {
            setState(() {
              inviteMessage = message.data;
              inviteConfirmationRecieved = true;
            });
          }

          await saveLinkedDevice(message.data);
        }

        if (messageType == PushMessageType.inviteRejected) {
          if (mounted) {
            setState(() {
              inviteRejected = true;
            });
          }
        }

        if (messageType == PushMessageType.tryConnectingToStartPoint) {
          await tryToConnectToStartPoint(message.data);
        }

        if (messageType == PushMessageType.tryConnectingToEndPoint) {
          await tryToConnectToEndPoint(message.data);
        }

        if (messageType == PushMessageType.connectionEstablishedToStartPoint) {
          setState(() {
            connectionEstablished = true;
          });
        }

        if (messageType == PushMessageType.connectionEstablishedToEndPoint) {
          setState(() {
            connectionEstablished = true;
          });
          server.close();
        }

        // if (messageType == PushMessageType.connectionAccepted) {
        //   await connectionAccepted(message);
        // }

        /* if (messageType == PushMessageType.requestObjectList) {
            await sendObjectListToDevice(senderEmail);
          }

          if (messageType == PushMessageType.objectList) {
            await readObjectListFromRemoteDevice(message);
          }

          if (messageType == PushMessageType.requestObjects) {
            await sendObjectsToListner(message);
          }

          if (messageType == PushMessageType.objectChunk) {
            await processObjectChunk(message);
          } */

        /* 
          if (messageType == 'REQUEST OBJECT DOWNLOAD') {
            await startSyncServer(senderEmail);
          }

          if (messageType == 'READY TO SEND') {
            String serverIPs = getValueInMessage(message, 'server IPs');
            int serverPort = -1;
            serverPort =
                int.tryParse(getValueInMessage(message, 'server port'));

            await openSocketToServer(senderEmail, serverIPs, serverPort);
          } */
      }
    });

    FirebaseMessaging.instance.requestPermission(sound: true, badge: true, alert: true);

    FirebaseMessaging.instance.getToken().then((String token) {
      assert(token != null);
      if (mounted) {
        setState(() {
          _localToken = token;
        });
      }
      print('Local token: $_localToken');
    });
  }

  showMessageTypeInSnackbar(String messageType, Icon icon,
      {int duration, Color color}) {
    if (!mounted) return;
    if (color == null) color = Theme.of(context).primaryColor;

    final snackBar = SnackBar(
      duration: duration == null
          ? Duration(milliseconds: 500)
          : Duration(seconds: duration),
      content: Container(
        color: color,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon == null ? Icon(Icons.info_outline) : icon,
            ),
            Expanded(
              child: Text(messageType),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //_scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  saveLinkedDevice(Map<String, dynamic> message) async {
    String senderEmail = getValueInMessage(message, 'sender email');
    MLinkedDevice mLinkedDevice = await MLinkedDevice.getByEmail(senderEmail);
    if (mLinkedDevice == null) {
      int id = await MLinkedDevice.maxId();

      String senderName = getValueInMessage(message, 'sender name');
      String token = getValueInMessage(message, 'sender token');

      MLinkedDevice mLinkedDevice = MLinkedDevice();
      mLinkedDevice.id = id;
      mLinkedDevice.email = senderEmail;
      mLinkedDevice.name = senderName;
      mLinkedDevice.blocked = 0;
      mLinkedDevice.token = token;

      await MLinkedDevice.createWithID(mLinkedDevice);

      await getLinkedDevices();
    }
  }

  String getValueInMessage(Map<String, dynamic> message, String property) {
    if (message['data'] != null) {
      return message['data'][property].toString();
    }

    return message[property].toString();
  }

  Future<void> initialize() async {
    // String strUserEmail = await LocalPreferences.getString('userEmail', '');
    // String strUserName = await LocalPreferences.getString('userName', '');
    String strLocalUserEmail =
        await LocalPreferences.getString('userEmail', '');

    Map<String, String> result = await L.getItems(translationItems);

    if (mounted) {
      setState(() {
        translations = result;
        _localUserEmail = strLocalUserEmail;
      });
    }

    await getLinkedDevices();

    await isConnectedToInternet();
  }

  Future<void> getLinkedDevices() async {
    List<MLinkedDevice> objects = await MLinkedDevice.getAll(false);

    setState(() {
      linkedDevices = objects;
    });
  }

  Future<void> isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          connectedToInternet = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        connectedToInternet = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (translations == null || translations.isEmpty) return Container();

    return WillPopScope(
      onWillPop: handleBackButton,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            translations['linked devices'],
          ),
          actions: <Widget>[
            TextButton(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(20.0),
              //   ),
              // ),
              child: Icon(
                Icons.add_to_queue,
                color: Colors.white,
              ),
              onPressed: () async {
                if (mounted) {
                  setState(() {
                    isShowingInviteCard = false;
                    inviteMessage = Map();
                    inviteSend = false;
                    inviteRecieved = false;
                    inviteConfirmationRecieved = false;
                    inviteConfirmationSend = false;
                    inviteRejected = false;
                  });
                }
                await inviteDevice();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              showConnectedToInternet(),
              showConnectionEstablished(),
              showInviteSend(),
              showInviteCard(),
              showInviteMessage(),
              showInviteConfirmationSend(),
              showInviteConfirmationCard(),
              showInviteRejectedCard(),
              //Text('xcvbn', style: TextStyle(color: Colors.red),),
              getLinkedDevicesListView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationOptions(),
      ),
    );
  }

  Widget showConnectedToInternet() {
    Color getBackgroundColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        // the color to return when button is in pressed, hovered, focused state
        return Colors.red;
      }
      // the color to return when button is in it's normal/unfocused state
      return Colors.white;
    }

    if (connectedToInternet) return Container();

    return Card(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(translations['not connected to internet']),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith(getBackgroundColor),
              ),
              child: Text(
                translations['check connection'],
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await isConnectedToInternet();
              },
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(20.0),
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showConnectionEstablished() {
    if (!connectionEstablished) return Container();

    return Card(
      color: Colors.green,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              onChanged: (text) {
                setState(() {
                  textToSend = text;
                });
              },
              decoration: InputDecoration(
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.all(5.0),
              ),
            ),
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.send),
            onPressed: () async {
              client.write(textToSend);

              // showMessageTypeInSnackbar(
              //   textToSend,
              //   Icon(Icons.cloud_upload),
              // );
              //await isConnectedToInternet();
            },
          ),
        ],
      ),
    );
    // Card(
    //   color: Colors.red,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       TextFormField(
    //         onChanged: (text) {
    //           setState(() {
    //             textToSend = text;
    //           });
    //         },
    //         decoration: InputDecoration(
    //           alignLabelWithHint: true,
    //           contentPadding: EdgeInsets.all(5.0),
    //         ),
    //       ),
    //       Expanded(
    //                   child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: IconButton(
    //             color: Colors.white,
    //             icon: Icon(Icons.send),
    //             onPressed: () async {
    //               client.write(textToSend);
    //               //await isConnectedToInternet();
    //             },
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget showInviteSend() {
    Color getBackgroundColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        // the color to return when button is in pressed, hovered, focused state
        return Colors.red;
      }
      // the color to return when button is in it's normal/unfocused state
      return Theme.of(context).primaryColor;
    }

    if (!inviteSend) return Container();
    if (inviteRecieved) return Container();
    if (inviteConfirmationSend) return Container();
    if (inviteConfirmationRecieved) return Container();
    if (inviteRejected) return Container();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/mailman.png',
            height: MediaQuery.of(context).size.height / 1.7,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              translations['invite sent'] + ' $remoteUserEmail',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          // CircularProgressIndicator(
          //   value: null,
          //   strokeWidth: 3.0,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith(getBackgroundColor),
                ),
                child: L.getUpperText('close'),
                onPressed: () => {
                  if (mounted)
                    {
                      setState(() {
                        isShowingInviteCard = false;
                        inviteMessage = Map();
                        inviteSend = false;
                        inviteRecieved = false;
                        inviteConfirmationRecieved = false;
                        inviteConfirmationSend = false;
                        inviteRejected = false;
                      })
                    }
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(20.0),
                //   ),
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showInviteCard() {
    Color getBackgroundColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        // the color to return when button is in pressed, hovered, focused state
        return Colors.red;
      }
      // the color to return when button is in it's normal/unfocused state
      return Theme.of(context).primaryColor;
    }

    if (!isShowingInviteCard) return Container();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/link.png',
            height: MediaQuery.of(context).size.height / 2.7,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              translations['add new device'],
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              translations['remote user email instructions'],
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                  child: TextFormField(
                    onChanged: (text) async {
                      remoteUserEmail = text;
                    },
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(5.0),
                        hintText: translations['enter remote user email']),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateColor.resolveWith(getBackgroundColor),
                    ),
                    child: L.getUpperText('accept'),
                    onPressed: () async {
                      await sendInvite();
                    },
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.all(
                    //     Radius.circular(20.0),
                    //   ),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateColor.resolveWith(getBackgroundColor),
                      ),
                      child: L.getUpperText('close'),
                      onPressed: () => {
                        if (mounted)
                          {
                            setState(() {
                              isShowingInviteCard = false;
                            })
                          }
                      },
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.all(
                      //     Radius.circular(20.0),
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget showInviteMessage() {
    if (!inviteRecieved) return Container();
    if (inviteConfirmationSend) return Container();
    if (inviteConfirmationRecieved) return Container();

    // String remoteUserEmail = getValueInMessage(inviteMessage, 'sender email');
    String remoteUserName = getValueInMessage(inviteMessage, 'sender name');
    // String remoteToken = getValueInMessage(inviteMessage, 'sender token');

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/comments_check_this_out.png',
            height: MediaQuery.of(context).size.height / 1.7,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              translations['recieved invite'] + ' $remoteUserName',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 5.0,
            runSpacing: 5.0,
            children: <Widget>[
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(translations['accept'].toUpperCase()),
                onPressed: () async {
                  await sendInviteToParty();
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(translations['ignore and dismiss'].toUpperCase()),
                onPressed: () async {
                  await sendRejectToParty();
                  if (mounted) {
                    setState(() {
                      isShowingInviteCard = false;
                      inviteMessage = Map();
                      inviteSend = false;
                      inviteRecieved = false;
                      inviteConfirmationRecieved = false;
                      inviteConfirmationSend = false;
                      inviteRejected = false;
                    });
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget showInviteConfirmationSend() {
    if (!inviteConfirmationSend) return Container();
    if (inviteConfirmationRecieved) return Container();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/chase.png',
            height: MediaQuery.of(context).size.height / 1.7,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              translations['invite confirmed'] + ' $remoteUserEmail',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 5.0,
            runSpacing: 5.0,
            children: <Widget>[
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(translations['close']),
                onPressed: () => {
                  if (mounted)
                    {
                      setState(() {
                        isShowingInviteCard = false;
                        inviteMessage = Map();
                        inviteSend = false;
                        inviteRecieved = false;
                        inviteConfirmationRecieved = false;
                        inviteConfirmationSend = false;
                        inviteRejected = false;
                      })
                    }
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget showInviteConfirmationCard() {
    if (!inviteConfirmationRecieved) return Container();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/actions_hug.png',
            height: MediaQuery.of(context).size.height / 1.7,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              translations['invite accepted'] + ' $remoteUserEmail',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.red,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  translations['remember link other party'],
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 5.0,
            runSpacing: 5.0,
            children: <Widget>[
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(translations['close']),
                onPressed: () => {
                  if (mounted)
                    {
                      setState(() {
                        inviteMessage = Map();
                        inviteSend = false;
                        inviteRecieved = false;
                        inviteConfirmationRecieved = false;
                        inviteConfirmationSend = false;
                        inviteRejected = false;
                      })
                    }
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget showInviteRejectedCard() {
    if (!inviteRejected) return Container();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/moo.png',
            height: MediaQuery.of(context).size.height / 1.7,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              translations['invite rejected'] + ' $remoteUserEmail',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 5.0,
            runSpacing: 5.0,
            children: <Widget>[
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(translations['close']),
                onPressed: () => {
                  if (mounted)
                    {
                      setState(() {
                        inviteMessage = Map();
                        inviteSend = false;
                        inviteRecieved = false;
                        inviteConfirmationRecieved = false;
                        inviteConfirmationSend = false;
                        inviteRejected = false;
                      })
                    }
                },
              )
            ],
          )
        ],
      ),
    );
  }

  sendInviteToParty() async {
    // send invite back to user. This is needed because when other party
    // send the invitation, the decvice was not subscribed to topic
    // and did not get the invitation.
    if (mounted) {
      setState(() {
        remoteUserEmail = getValueInMessage(inviteMessage, 'sender email');
      });
    }

    await sendInviteConfirmation();
    if (mounted) {
      setState(() {
        inviteMessage = Map();
      });
    }
  }

  sendRejectToParty() async {
    // send invite back to user. This is needed because when other party
    // send the invitation, the decvice was not subscribed to topic
    // and did not get the invitation.
    if (mounted) {
      setState(() {
        remoteUserEmail = getValueInMessage(inviteMessage, 'sender email');
      });
    }

    await sendInviteRejection();
    if (mounted) {
      setState(() {
        inviteMessage = Map();
      });
    }
  }

  Future<void> inviteDevice() async {
    String strLocalUserEmail =
        await LocalPreferences.getString('userEmail', '');
    String strLocalUserName = await LocalPreferences.getString('userName', '');

    if (strLocalUserEmail.isEmpty || strLocalUserName.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            titlePadding: EdgeInsets.all(0.0),
            title: Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.warning),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(translations['warning']),
                  ),
                ],
              ),
            ),
            content: Text(translations['email or name not filled']),
            actions: <Widget>[
              new TextButton(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(20.0),
                //   ),
                // ),
                child: Text(translations['user profile'].toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pop();

                  Route route =
                      MaterialPageRoute(builder: (context) => UserAccount());
                  Navigator.push(context, route);
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (mounted) {
      setState(() {
        isShowingInviteCard = true;
      });
    }
  }

  sendInvite() async {
    if (mounted) {
      setState(() {
        isShowingInviteCard = false;
      });
    }

    if (remoteUserEmail.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            titlePadding: EdgeInsets.all(0.0),
            title: Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.warning),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(translations['warning']),
                  ),
                ],
              ),
            ),
            content: Text(translations['please enter remote email']),
            actions: <Widget>[
              new TextButton(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(20.0),
                //   ),
                // ),
                child: Text(translations['close'].toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    String topic = getTopicName(remoteUserEmail, localUserEmail);

    await FirebaseMessaging.instance.subscribeToTopic(topic);

    await sendInviteMessageToTopic(topic);

    if (mounted) {
      setState(() {
        inviteSend = true;
      });
    }
  }

  sendInviteConfirmation() async {
    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    String topic = getTopicName(remoteUserEmail, localUserEmail);

    await sendInviteConfirmationMessageToTopic(topic);

    if (mounted) {
      setState(() {
        inviteConfirmationSend = true;
      });
    }
  }

  sendInviteRejection() async {
    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    String topic = getTopicName(remoteUserEmail, localUserEmail);

    await sendInviteRejectionMessageToTopic(topic);

    if (mounted) {
      setState(() {
        inviteConfirmationSend = true;
      });
    }
  }

  String getTopicName(String remoteUserEmail, String localUserEmail) {
    List<String> listOfEmails = <String>[];
    listOfEmails.add(remoteUserEmail.replaceAll('@', ''));
    listOfEmails.add(localUserEmail.replaceAll('@', ''));

    listOfEmails.sort((s1, s2) => s1.compareTo(s2));
    return listOfEmails[0] + listOfEmails[1];
  }

  Future<void> sendInviteMessageToTopic(String topic) async {
    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    String localToken = await FirebaseMessaging.instance.getToken();
    String localUserName = await LocalPreferences.getString('userName', '');

    String body = jsonEncode(
      <String, dynamic>{
        // 'notification': <String, dynamic>{
        //   'body': UniqueKey().toString(),
        //   'title': UniqueKey().toString(),
        // },
        'priority': 'high',
        'data': <String, dynamic>{
          'sender email': _localUserEmail,
          'sender name': localUserName,
          'sender token': localToken,
          'timestamp': DateTime.now().toIso8601String(),
          'message type': PushMessageType.invite,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          //'id': UniqueKey().toString(),
        },
        'to': '/topics/$topic',
        //'to': 'ddnhpU-50Dg:APA91bGPc5MyHWyLhmIaMs9RTb2TRd397L35lVVGQ03SdXn4PloyarW0gKU5meYdw8wZ542ppi5vNvKMEjEuqcoDRHWuE5qaS9gU9MoMccWS_aG0HuyLycwQjB8lmCbK4IvBzPLgaigH',
      },
    );

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Helper.serverToken}',
      },
      body: body,
    );

    // final Completer<Map<String, dynamic>> completer =
    //     Completer<Map<String, dynamic>>();

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     completer.complete(message);
    //   },
    // );

    // return completer.future;
  }

  Future<void> sendInviteConfirmationMessageToTopic(String topic) async {
    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    String localToken = await FirebaseMessaging.instance.getToken();
    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    String localUserName = await LocalPreferences.getString('userName', '');

    String body = jsonEncode(
      <String, dynamic>{
        // 'notification': <String, dynamic>{
        //   'body': UniqueKey().toString(),
        //   'title': UniqueKey().toString(),
        // },
        'priority': 'high',
        'data': <String, dynamic>{
          'sender email': localUserEmail,
          'sender name': localUserName,
          'sender token': localToken,
          'timestamp': DateTime.now().toIso8601String(),
          'message type': PushMessageType.inviteConfirmation,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          //'id': UniqueKey().toString(),
        },
        'to': '/topics/$topic',
        //'to': 'ddnhpU-50Dg:APA91bGPc5MyHWyLhmIaMs9RTb2TRd397L35lVVGQ03SdXn4PloyarW0gKU5meYdw8wZ542ppi5vNvKMEjEuqcoDRHWuE5qaS9gU9MoMccWS_aG0HuyLycwQjB8lmCbK4IvBzPLgaigH',
      },
    );

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Helper.serverToken}',
      },
      body: body,
    );

    // final Completer<Map<String, dynamic>> completer =
    //     Completer<Map<String, dynamic>>();

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     completer.complete(message);
    //   },
    // );

    // return completer.future;
  }

  Future<void> sendInviteRejectionMessageToTopic(String topic) async {
    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    String localToken = await FirebaseMessaging.instance.getToken();
    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    String localUserName = await LocalPreferences.getString('userName', '');

    String body = jsonEncode(
      <String, dynamic>{
        // 'notification': <String, dynamic>{
        //   'body': UniqueKey().toString(),
        //   'title': UniqueKey().toString(),
        // },
        'priority': 'high',
        'data': <String, dynamic>{
          'sender email': localUserEmail,
          'sender name': localUserName,
          'sender token': localToken,
          'timestamp': DateTime.now().toIso8601String(),
          'message type': PushMessageType.inviteRejected,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          //'id': UniqueKey().toString(),
        },
        'to': '/topics/$topic',
        //'to': 'ddnhpU-50Dg:APA91bGPc5MyHWyLhmIaMs9RTb2TRd397L35lVVGQ03SdXn4PloyarW0gKU5meYdw8wZ542ppi5vNvKMEjEuqcoDRHWuE5qaS9gU9MoMccWS_aG0HuyLycwQjB8lmCbK4IvBzPLgaigH',
      },
    );

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Helper.serverToken}',
      },
      body: body,
    );

    // final Completer<Map<String, dynamic>> completer =
    //     Completer<Map<String, dynamic>>();

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     completer.complete(message);
    //   },
    // );

    // return completer.future;
  }

  Widget getLinkedDevicesListView() {
    if (isShowingInviteCard ||
        inviteSend ||
        inviteRecieved ||
        inviteConfirmationRecieved ||
        inviteConfirmationSend ||
        inviteRejected) return Container();

    return Card(
      color: Colors.white,
      child: Column(
        children: [
          for (final item in linkedDevices) buildListTile(item),
        ],
      ),
    );

    // return ListView.builder(
    //     itemCount: linkedDevices.length,
    //     itemBuilder: (context, index) {
    //       return buildListTile(linkedDevices[index]);
    //     });
  }

  Widget buildListTile(MLinkedDevice mLinkedDevice) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${mLinkedDevice.name} (${mLinkedDevice.email})',
            style: TextStyle(
                color: mLinkedDevice.blocked == 0
                    ? Colors.black
                    : Colors.grey.shade400),
          ),
          Row(
            children: <Widget>[
              blockButton(mLinkedDevice),
              outputVoiceboxButton(mLinkedDevice),
              downloadFromDeviceButton(mLinkedDevice),
              deleteButton(mLinkedDevice),
            ],
          )
        ],
      ),
    );
  }

  Widget blockButton(MLinkedDevice mLinkedDevice) {
    return IconButton(
      color: Colors.black,
      icon: Row(
        children: <Widget>[
          new Icon(
            mLinkedDevice.blocked == 0 ? Icons.block : Icons.remove_red_eye,
          ),
        ],
      ),
      onPressed: () async {
        if (mLinkedDevice.blocked == 1) {
          mLinkedDevice.blocked = 0;
        } else {
          mLinkedDevice.blocked = 1;
        }
        MLinkedDevice.update(mLinkedDevice);

        if (mounted) {
          final snackBar = SnackBar(
            content: Text(mLinkedDevice.blocked == 1
                ? translations['device blocked']
                : translations['device unblocked']),
            backgroundColor: Theme.of(context).primaryColor,
          );

          if (_scaffoldKey.currentState != null) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //_scaffoldKey.currentState.showSnackBar(snackBar);
          }
        }

        await getLinkedDevices();
      },
    );
  }

  Widget deleteButton(MLinkedDevice mLinkedDevice) {
    return IconButton(
      color: Colors.black,
      icon: Row(
        children: <Widget>[
          new Icon(Icons.delete),
        ],
      ),
      onPressed: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              titlePadding: EdgeInsets.all(0.0),
              title: Container(
                padding: EdgeInsets.all(15.0),
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.warning),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(translations['delete linked device']),
                    ),
                  ],
                ),
              ),
              content: Text(translations['confirm delete linked device']),
              actions: <Widget>[
                TextButton(
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(20.0),
                  //   ),
                  // ),
                  child: Text(translations['accept'].toUpperCase()),
                  onPressed: () async {
                    await MLinkedDevice.delete(mLinkedDevice);
                    await getLinkedDevices();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(20.0),
                  //   ),
                  // ),
                  child: Text(translations['close'].toUpperCase()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget outputVoiceboxButton(MLinkedDevice mLinkedDevice) {
    if (mLinkedDevice.blocked == 1) return Container();

    return IconButton(
      color: Colors.red,
      icon: Row(
        children: <Widget>[
          new Icon(
            Icons.settings_voice,
            color: mLinkedDevice.outputVoicebox == 0
                ? Colors.grey.shade400
                : Colors.black,
          ),
        ],
      ),
      onPressed: () async {
        if (mLinkedDevice.blocked == 1) return;

        if (mLinkedDevice.outputVoicebox == 1) {
          mLinkedDevice.outputVoicebox = 0;
        } else {
          mLinkedDevice.outputVoicebox = 1;
        }
        MLinkedDevice.update(mLinkedDevice);

        if (mounted) {
          final snackBar = SnackBar(
            content: Text(mLinkedDevice.outputVoicebox == 1
                ? translations['echo device']
                : translations['device silent']),
            backgroundColor: Theme.of(context).primaryColor,
          );

          if (_scaffoldKey.currentState != null) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //_scaffoldKey.currentState.showSnackBar(snackBar);
          }
        }

        await getLinkedDevices();
      },
    );
  }

  Widget downloadFromDeviceButton(MLinkedDevice mLinkedDevice) {
    if (mLinkedDevice.blocked == 1) return Container();

    return IconButton(
        //color: Colors.red,
        icon: Row(
          children: <Widget>[
            new Icon(
              Icons.cloud_download,
              color: Colors.black,
            ),
          ],
        ),
        onPressed: () async {
          await tryConnectingToStartPoint(mLinkedDevice, true);
        });
  }

  Future<void> tryConnectingToStartPoint(
      MLinkedDevice mLinkedDevice, bool initiatedByStartPoint) async {
    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    String ipAddresses = await getLocalIps();

    bool localServerIsRunning = await startServer();
    if (localServerIsRunning) {
      String serverIPs = await getLocalIps();
      client = await connectClientTo(serverIPs, Helper.port, false);
    } else {
      showMessageTypeInSnackbar(
          'Could not start local server', Icon(Icons.warning),
          duration: 5, color: Colors.red);
    }

    String body = jsonEncode(
      <String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'sender email': localUserEmail,
          'server IPs': ipAddresses,
          'server is running': localServerIsRunning,
          'timestamp': DateTime.now().toIso8601String(),
          'message type': PushMessageType.tryConnectingToStartPoint,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
        'to': mLinkedDevice.token,
      },
    );

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Helper.serverToken}',
      },
      body: body,
    );

    showMessageTypeInSnackbar(
        PushMessageType.tryConnectingToStartPoint, Icon(Icons.cloud_upload));
  }

  Future<void> tryToConnectToStartPoint(Map<String, dynamic> message) async {
    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    //String ipAddresses = await getLocalIps();
    String remoteEmail = getValueInMessage(message, 'sender email');
    MLinkedDevice mLinkedDevice = await MLinkedDevice.getByEmail(remoteEmail);

    String startPointIPs = getValueInMessage(message, 'server IPs');
    client = await connectClientTo(startPointIPs, Helper.port, true);
    if (client != null) {
      String body = jsonEncode(
        <String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'sender email': localUserEmail,
            'server IPs': startPointIPs,
            'timestamp': DateTime.now().toIso8601String(),
            'message type': PushMessageType.connectionEstablishedToStartPoint,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          'to': mLinkedDevice.token,
        },
      );

      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${Helper.serverToken}',
        },
        body: body,
      );

      showMessageTypeInSnackbar(
          PushMessageType.connectionEstablishedToStartPoint,
          Icon(Icons.cloud_upload));

      setState(() {
        connectionEstablished = true;
      });

      await requestObjectList();
    } else {
      bool localServerIsRunning = await startServer();
      if (localServerIsRunning) {
        String serverIPs = await getLocalIps();
        client = await connectClientTo(serverIPs, Helper.port, true);
        if (client != null) {
          String body = jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'sender email': localUserEmail,
                'server IPs': serverIPs,
                'timestamp': DateTime.now().toIso8601String(),
                'message type': PushMessageType.tryConnectingToEndPoint,
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              },
              'to': mLinkedDevice.token,
            },
          );

          await http.post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'key=${Helper.serverToken}',
            },
            body: body,
          );

          showMessageTypeInSnackbar(
            PushMessageType.tryConnectingToEndPoint,
            Icon(Icons.cloud_upload),
          );
        } else {
          await communicationFailed(mLinkedDevice);
        }
      } else {
        await communicationFailed(mLinkedDevice);
      }
    }
  }

  Future<void> tryToConnectToEndPoint(Map<String, dynamic> message) async {
    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    String ipAddresses = await getLocalIps();
    String remoteEmail = getValueInMessage(message, 'sender email');
    MLinkedDevice mLinkedDevice = await MLinkedDevice.getByEmail(remoteEmail);

    String serverIPs = getValueInMessage(message, 'server IPs');
    client = await connectClientTo(ipAddresses, Helper.port, false);
    if (client != null) {
      String body = jsonEncode(
        <String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'sender email': localUserEmail,
            'server IPs': serverIPs,
            'timestamp': DateTime.now().toIso8601String(),
            'message type': PushMessageType.connectionEstablishedToEndPoint,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          'to': mLinkedDevice.token,
        },
      );

      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${Helper.serverToken}',
        },
        body: body,
      );

      showMessageTypeInSnackbar(PushMessageType.connectionEstablishedToEndPoint,
          Icon(Icons.cloud_upload));

      setState(() {
        connectionEstablished = true;
      });

      await requestObjectList();
    } else {
      await communicationFailed(mLinkedDevice);
    }
  }

  Future<void> communicationFailed(MLinkedDevice mLinkedDevice) async {
    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    String localUserEmail = await LocalPreferences.getString('userEmail', '');

    String body = jsonEncode(
      <String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'sender email': localUserEmail,
          'timestamp': DateTime.now().toIso8601String(),
          'message type': PushMessageType.communicationFailed,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
        'to': mLinkedDevice.token,
      },
    );

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Helper.serverToken}',
      },
      body: body,
    );

    showMessageTypeInSnackbar(
      PushMessageType.communicationFailed,
      Icon(Icons.cloud_upload),
      duration: 5,
    );
  }

  Future<void> requestObjectList() async {
    if (!client.isServer) client.write("send me the object list");
  }

  Future<String> getLocalIps() async {
    List<String> ips = <String>[];

    for (var interface in await NetworkInterface.list()) {
      //print('== Interface: ${interface.name} ==');
      for (var addr in interface.addresses) {
        ips.add(addr.address);
      }
    }
    return ips.join(', ');
  }

  Future<bool> startServer() async {
    try {
      ServerSocket socket = await ServerSocket.bind(
          InternetAddress.anyIPv6, Helper.port,
          shared: true);

      if (socket != null) {
        server = socket;

        server.listen((client) {
          print('${client.remoteAddress.address} connected');
          // showMessageTypeInSnackbar(
          //     '${client.remoteAddress.address} connected', null);

          SyncClient(client, true);
        });

        return true;
      }
      /* } on SocketException catch (e) {
      // String msg = '';
      // msg += e.message.isEmpty ? '' : 'Message: ${e.message}\n';
      // msg += e.address == null ? '' : 'Address: ${e.address.address}\n';
      // msg += e.port == null ? '' : 'Port: ${e.port}\n';
      // msg += '${e.osError}';

      // showMessageTypeInSnackbar(msg, Icon(Icons.warning),
      //     duration: 5, color: Colors.red);
    }  */
    } catch (e) {
      // String msg = e.toString();

      // showMessageTypeInSnackbar(msg, Icon(Icons.warning),
      //     duration: 5, color: Colors.red);
    }

    return false;
  }

  Future<SyncClient> connectClientTo(
      String serverIPs, int serverPort, bool isServer) async {
    List<String> ips = serverIPs.split(',');
    for (int i = 0; i < ips.length; i++) {
      try {
        // showMessageTypeInSnackbar(
        //     'Attempting to connect to server ${ips[i]}:$serverPort...', null);

        Socket client = await Socket.connect(
          ips[i],
          serverPort,
          timeout: Duration(seconds: 5),
        );

        // client.listen(dataHandler,
        //     onError: errorHandler, onDone: doneHandler, cancelOnError: false);

        //SyncClient syncClient =
        SyncClient syncClient = SyncClient(client, isServer);

        return syncClient;
      }
      /* on SocketException catch (e) {
        // String msg = '';
        // msg += e.message.isEmpty ? '' : 'Message: ${e.message}\n';
        // msg += e.address == null ? '' : 'Address: ${e.address.address}\n';
        // msg += e.port == null ? '' : 'Port: ${e.port}\n';
        // msg += '${e.osError}';

        // showMessageTypeInSnackbar(msg, Icon(Icons.warning),
        //     duration: 5, color: Colors.red);
      }  */
      catch (e) {
        //String msg = e.toString();

        // showMessageTypeInSnackbar(msg, Icon(Icons.warning),
        //     duration: 5, color: Colors.red);
      }
    }
    return null;
  }

  // void dataHandler(data) {
  //   print(new String.fromCharCodes(data).trim());
  // }

  // void errorHandler(error, StackTrace trace) {
  //   print(error);
  // }

  // void doneHandler() {
  //   clientToLocalServer.destroy();
  //   clientToRemoteServer.destroy();
  //   exit(0);
  // }

/*
  Future<void> requestFileListFromDevice(MLinkedDevice mLinkedDevice) async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    String localUserEmail = await LocalPreferences.getString('userEmail', '');

    String body = jsonEncode(
      <String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'sender email': localUserEmail,
          'timestamp': DateTime.now().toIso8601String(),
          'message type': PushMessageType.requestObjectList,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
        'to': mLinkedDevice.token,
      },
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Helper.serverToken}',
      },
      body: body,
    );

    showMessageTypeInSnackbar(
        PushMessageType.requestObjectList, Icon(Icons.cloud_upload));
  }

  Future<void> sendObjectListToDevice(String remoteEmail) async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    List<MFolder> folders = await MFolder.getUserCreated('');
    List<MImage> images = await MImage.getUserCreated('');
    List<MVideo> videos = await MVideo.getUserCreated('');
    List<MSound> sounds = await MSound.getUserCreated('');

    var jsonFolders = jsonEncode(folders.map((e) => e.idMap()).toList());
    var jsonImages = jsonEncode(images.map((e) => e.idMap()).toList());
    var jsonVideos = jsonEncode(videos.map((e) => e.idMap()).toList());
    var jsonSounds = jsonEncode(sounds.map((e) => e.idMap()).toList());

    MLinkedDevice mLinkedDevice = await MLinkedDevice.getByEmail(remoteEmail);

    String localUserEmail = await LocalPreferences.getString('userEmail', '');

    String body = jsonEncode(
      <String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'sender email': localUserEmail,
          'timestamp': DateTime.now().toIso8601String(),
          'folders': jsonFolders,
          'images': jsonImages,
          'videos': jsonVideos,
          'sounds': jsonSounds,
          'message type': PushMessageType.objectList,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
        'to': mLinkedDevice.token,
      },
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Helper.serverToken}',
      },
      body: body,
    );

    showMessageTypeInSnackbar(
        PushMessageType.objectList, Icon(Icons.cloud_upload));
  }

  readObjectListFromRemoteDevice(Map<String, dynamic> message) async {
    String remoteEmail = getValueInMessage(message, 'sender email');
    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    MLinkedDevice mLinkedDevice = await MLinkedDevice.getByEmail(remoteEmail);

    String jsonFolders = getValueInMessage(message, 'folders');
    String jsonImages = getValueInMessage(message, 'images');
    String jsonVideos = getValueInMessage(message, 'videos');
    String jsonSounds = getValueInMessage(message, 'sounds');

    List<dynamic> folders = jsonDecode(jsonFolders);
    List<dynamic> images = jsonDecode(jsonImages);
    List<dynamic> videos = jsonDecode(jsonVideos);
    List<dynamic> sounds = jsonDecode(jsonSounds);

    // get remote user's objects
    List<MFolder> existingRemoteUserFolders =
        await MFolder.getUserCreated(remoteEmail);
    List<MImage> existingRemoteUserImages =
        await MImage.getUserCreated(remoteEmail);
    List<MVideo> existingRemoteUserVideos =
        await MVideo.getUserCreated(remoteEmail);
    List<MSound> existingRemoteUserSounds =
        await MSound.getUserCreated(remoteEmail);

    List<String> objectsToRequest = List<String>();
    for (int i = 0; i < folders.length; i++) {
      bool found = false;
      for (int j = 0; j < existingRemoteUserFolders.length; j++) {
        if (existingRemoteUserFolders[j].remoteId == folders[i]['id']) {
          found = true;
          break;
        }
      }

      if (!found) {
        objectsToRequest.add(jsonEncode(
          <String, dynamic>{
            'id': folders[i]['id'],
            'objectType': 'folder',
          },
        ));
      }

      /// TODO delete objects that were not sent
      // else {
      //   // Delete object from database
      //   MFolder objectToDelete =
      //       await MFolder.getByID(int.parse(folders[i]['id']));
      //   await MFolder.delete(objectToDelete);
      // }
    }
    for (int i = 0; i < images.length; i++) {
      bool found = false;
      for (int j = 0; j < existingRemoteUserImages.length; j++) {
        if (existingRemoteUserImages[j].remoteId == images[i]['id']) {
          found = true;
          break;
        }
      }

      if (!found) {
        objectsToRequest.add(jsonEncode(
          <String, dynamic>{
            'id': images[i]['id'],
            'objectType': 'image',
          },
        ));
      }
    }
    for (int i = 0; i < videos.length; i++) {
      bool found = false;
      for (int j = 0; j < existingRemoteUserVideos.length; j++) {
        if (existingRemoteUserVideos[j].remoteId == videos[i]['id']) {
          found = true;
          break;
        }
      }

      if (!found) {
        objectsToRequest.add(jsonEncode(
          <String, dynamic>{
            'id': videos[i]['id'],
            'objectType': 'video',
          },
        ));
      }
    }
    for (int i = 0; i < sounds.length; i++) {
      bool found = false;
      for (int j = 0; j < existingRemoteUserSounds.length; j++) {
        if (existingRemoteUserSounds[j].remoteId == sounds[i]['id']) {
          found = true;
          break;
        }
      }

      if (!found) {
        objectsToRequest.add(jsonEncode(
          <String, dynamic>{
            'id': sounds[i]['id'],
            'objectType': 'sound',
          },
        ));
      }
    }

    String body = jsonEncode(
      <String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'sender email': localUserEmail,
          'timestamp': DateTime.now().toIso8601String(),
          'send me these objects': jsonEncode(objectsToRequest),
          'message type': PushMessageType.requestObjects,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
        'to': mLinkedDevice.token,
      },
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Helper.serverToken}',
      },
      body: body,
    );

    showMessageTypeInSnackbar(
        PushMessageType.requestObjects, Icon(Icons.cloud_upload));
  }

  sendObjectsToListner(Map<String, dynamic> message) async {
    String remoteEmail = getValueInMessage(message, 'sender email');
    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    MLinkedDevice mLinkedDevice = await MLinkedDevice.getByEmail(remoteEmail);

    List<dynamic> objectsToSend =
        jsonDecode(getValueInMessage(message, 'send me these objects'));
    for (int i = 0; i < objectsToSend.length; i++) {
      Map<String, dynamic> jsonMap = json.decode(objectsToSend[i]);
      int objectId = jsonMap['id'];
      String objectType = jsonMap['objectType'];

      List<String> chunks = await getObjectChunks(objectId, objectType);
      await sendChunks(chunks, localUserEmail, objectId, objectType, mLinkedDevice);

      showMessageTypeInSnackbar('$objectType $objectId SENT', Icon(Icons.cloud_upload));
    }
  }

  Future<List<String>> getObjectChunks(int objectId, String objectType) async {
    File localFile;
    Map<String, dynamic> map;

    if (objectType == 'folder') {
      MFolder mFolder = await MFolder.getByID(objectId);
      map = mFolder.toBDMap();
      if (mFolder.useAsset == 0)
        localFile = File('${Helper.appDirectory}/${mFolder.localFileName}');
    }
    if (objectType == 'image') {
      MImage mImage = await MImage.getByID(objectId);
      map = mImage.toBDMap();
      if (mImage.useAsset == 0)
        localFile = File('${Helper.appDirectory}/${mImage.localFileName}');
    }
    if (objectType == 'video') {
      MVideo mVideo = await MVideo.getByID(objectId);
      map = mVideo.toBDMap();
      if (mVideo.useAsset == 0)
        localFile = File('${Helper.appDirectory}/${mVideo.localFileName}');
    }
    if (objectType == 'sound') {
      MSound mSound = await MSound.getByID(objectId);
      map = mSound.toBDMap();
      if (mSound.useAsset == 0)
        localFile = File('${Helper.appDirectory}/${mSound.localFileName}');
    }

    String base64Str = '';
    if (localFile != null) {
      final bytes = await localFile.readAsBytes();
      base64Str = Helper.base64String(bytes);
    }

    String object = jsonEncode(
      <String, dynamic>{
        'map': map,
        'localFile': base64Str,
      },
    );

    List<String> chunks = [];
    int previousIndex = 0;
    int currentIndex = 0;
    int size = 4000;
    while (currentIndex < object.length) {
      if (currentIndex + size < object.length) {
        currentIndex += size;
        chunks.add(object.substring(previousIndex, currentIndex));
        previousIndex += size;
      } else {
        chunks.add(object.substring(currentIndex, object.length));
        currentIndex += size;
      }
    }
    return chunks;
  }

  Future<void> sendChunks(List<String> chunks, String localUserEmail,
      int objectId, String objectType, MLinkedDevice mLinkedDevice) async {
    for (int j = 0; j < chunks.length; j++) {
      String chunk = chunks[j];
      String body = jsonEncode(
        <String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'sender email': localUserEmail,
            'timestamp': DateTime.now().toIso8601String(),
            'object id': objectId,
            'objectType': objectType,
            'chunk index': j,
            'total chunks': chunks.length,
            'chunk': chunk,
            'message type': PushMessageType.objectChunk,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          'to': mLinkedDevice.token,
        },
      );

      await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${Helper.serverToken}',
        },
        body: body,
      );

      //showMessageTypeInSnackbar('SENDING $objectType $objectId (${(j+1)}/${chunks.length})', Icon(Icons.cloud_upload));
      // showMessageTypeInSnackbar(
      //     PushMessageType.objectChunk, Icon(Icons.cloud_upload));
    }
  }

  processObjectChunk(Map<String, dynamic> message) async {
    String remoteEmail = getValueInMessage(message, 'sender email');
    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    MLinkedDevice mLinkedDevice = await MLinkedDevice.getByEmail(remoteEmail);

    int objectId = int.parse(getValueInMessage(message, 'object id'));
    String objectType = getValueInMessage(message, 'objectType');
    String chunk = getValueInMessage(message, 'chunk');
    int chunkIndex = int.parse(getValueInMessage(message, 'chunk index'));
    int totalChunks = int.parse(getValueInMessage(message, 'total chunks'));

    print('$chunkIndex/$totalChunks');
  }*/

  // Future<void> requestConnectionTo(MLinkedDevice mLinkedDevice) async {
  //   await _firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(
  //         sound: true, badge: true, alert: true, provisional: false),
  //   );

  //   String localUserEmail = await LocalPreferences.getString('userEmail', '');
  //   String ipAddresses = await getLocalIps();

  //   bool localServerIsRunning = await startServer();
  //   if (localServerIsRunning) {
  //     // showMessageTypeInSnackbar(
  //     //     'Local server running', Icon(Icons.settings_input_component),
  //     //     duration: 5);

  //     String serverIPs = await getLocalIps();
  //     await startClient(serverIPs, Helper.port, true);
  //   } else {
  //     showMessageTypeInSnackbar('Local server NOT RUNNING.', Icon(Icons.warning),
  //         duration: 5, color: Colors.red);
  //   }

  //   String body = jsonEncode(
  //     <String, dynamic>{
  //       'priority': 'high',
  //       'data': <String, dynamic>{
  //         'sender email': localUserEmail,
  //         'server IPs': ipAddresses,
  //         'server is running': localServerIsRunning,
  //         'timestamp': DateTime.now().toIso8601String(),
  //         'message type': PushMessageType.requestConnection,
  //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //       },
  //       'to': mLinkedDevice.token,
  //     },
  //   );

  //   await http.post(
  //     'https://fcm.googleapis.com/fcm/send',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=${Helper.serverToken}',
  //     },
  //     body: body,
  //   );

  //   showMessageTypeInSnackbar(
  //       PushMessageType.requestConnection, Icon(Icons.cloud_upload));
  // }

  // Future<void> acceptConnection(Map<String, dynamic> message) async {
  //   await _firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(
  //         sound: true, badge: true, alert: true, provisional: false),
  //   );

  //   String localUserEmail = await LocalPreferences.getString('userEmail', '');
  //   String ipAddresses = await getLocalIps();
  //   String remoteEmail = getValueInMessage(message, 'sender email');
  //   MLinkedDevice mLinkedDevice = await MLinkedDevice.getByEmail(remoteEmail);

  //   bool localServerIsRunning = await startServer();
  //   if (localServerIsRunning) {
  //     // showMessageTypeInSnackbar(
  //     //     'Local server running', Icon(Icons.settings_input_component),
  //     //     duration: 5);

  //     String serverIPs = await getLocalIps();
  //     await startClient(serverIPs, Helper.port, true);
  //   } else {
  //     showMessageTypeInSnackbar('Local server NOT RUNNING.', Icon(Icons.warning),
  //         duration: 5, color: Colors.red);
  //   }

  //   String serverIPs = getValueInMessage(message, 'server IPs');
  //   await startClient(serverIPs, Helper.port, false);

  //   if (clientToLocalServer != null) clientToLocalServer.write('Hi');
  //   if (clientToRemoteServer != null) clientToRemoteServer.write('Hi');

  //   String body = jsonEncode(
  //     <String, dynamic>{
  //       'priority': 'high',
  //       'data': <String, dynamic>{
  //         'sender email': localUserEmail,
  //         'server IPs': ipAddresses,
  //         'server is running': localServerIsRunning,
  //         'timestamp': DateTime.now().toIso8601String(),
  //         'message type': PushMessageType.connectionAccepted,
  //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //       },
  //       'to': mLinkedDevice.token,
  //     },
  //   );

  //   await http.post(
  //     'https://fcm.googleapis.com/fcm/send',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=${Helper.serverToken}',
  //     },
  //     body: body,
  //   );

  //   showMessageTypeInSnackbar(
  //       PushMessageType.connectionAccepted, Icon(Icons.cloud_upload));
  // }
  // Future<void> connectionAccepted(Map<String, dynamic> message) async {
  //   await _firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(
  //         sound: true, badge: true, alert: true, provisional: false),
  //   );

  //   String localUserEmail = await LocalPreferences.getString('userEmail', '');
  //   String ipAddresses = await getLocalIps();
  //   String serverIPs = getValueInMessage(message, 'server IPs');
  //   String remoteEmail = getValueInMessage(message, 'sender email');
  //   MLinkedDevice mLinkedDevice = await MLinkedDevice.getByEmail(remoteEmail);

  //   await startClient(serverIPs, Helper.port, false);
  //   if (clientToRemoteServer != null) clientToRemoteServer.write('Hi');
  // }
/*
  // Future<String> getIpAddress() async {
  //   String ipAddress;

  //   try {
  //     ipAddress = await GetIp.ipAddress;
  //   } on PlatformException {
  //     ipAddress = '';
  //   }

  //   return ipAddress;
  // }

  // Future printIps() async {
  //   for (var interface in await NetworkInterface.list()) {
  //     print('== Interface: ${interface.name} ==');
  //     for (var addr in interface.addresses) {
  //       print(
  //           '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
  //     }
  //   }
  // }

  

  Future<void> startSyncServer(String remoteEmail) async {
    //await printIps();
    String ipAddresses = await getLocalIps();
    //String ipAddress = await getIpAddress();

    // if (ipAddress.isEmpty) {
    //   return;
    // }

    List<String> ips = ipAddresses.split(',');
    if (ips.length > 1) {
      showMessageTypeInSnackbar(
          'Server reports several IP: $ipAddresses', null);
    }

    for (int i = 0; i < ips.length; i++) {
      //ServerSocket.bind(InternetAddress.anyIPv6, Helper.port, shared: true)
      try {
        //ServerSocket.bind(ips[i], Helper.port, shared: true).catchError((e) {
        String srvIP = '';
        ServerSocket socket;
        // try {
          srvIP = InternetAddress(ips[i]).address;
          // socket = await ServerSocket.bind(InternetAddress(ips[i]), Helper.port,
          //     shared: true);
          socket = await ServerSocket.bind(InternetAddress.loopbackIPv6, Helper.port,
              shared: true);
        // } catch (w) {
        //   srvIP = ips[i];
        //   try {
        //     socket = await ServerSocket.bind(srvIP, Helper.port, shared: true);
        //   } catch (w) {}
        // }
        /* ServerSocket.bind(InternetAddress(ips[i]), Helper.port, shared: true)
        .catchError((e) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                //title: Text(translations['error']),
                content: Row(
                  children: <Widget>[
                    Text(e.toString()),
                  ],
                ),
                actions: <Widget>[
                  new TextButton(
                    child: L.getUpperText('close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }).then((ServerSocket socket) async { */

        //ServerSocket socket = await ServerSocket.bind(InternetAddress(ips[i]), Helper.port, shared: true);
        if (socket != null) {
          server = socket;

          showMessageTypeInSnackbar(
              'Server ${server.address.address}:${server.port} running',
              Icon(Icons.settings_input_component), duration: 5);

          server.listen((client) {
            showMessageTypeInSnackbar(
                '${client.remoteAddress.address} connected', null);

            sendObjects(client);
          });

          // send confirmation to client that server is running
          await _firebaseMessaging.requestNotificationPermissions(
            const IosNotificationSettings(
                sound: true, badge: true, alert: true, provisional: false),
          );

          MLinkedDevice mLinkedDevice =
              await MLinkedDevice.getByEmail(remoteEmail);

          String localUserEmail =
              await LocalPreferences.getString('userEmail', '');
          String localUserName =
              await LocalPreferences.getString('userName', '');

          String body = jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'sender email': localUserEmail,
                'sender name': localUserName,
                'timestamp': DateTime.now().toIso8601String(),
                'server IPs': ipAddresses,
                'server port': Helper.port,
                'message type': 'READY TO SEND',
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              },
              'to': mLinkedDevice.token,
            },
          );

          await http.post(
            'https://fcm.googleapis.com/fcm/send',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'key=${Helper.serverToken}',
            },
            body: body,
          );

          showMessageTypeInSnackbar('READY TO SEND', Icon(Icons.cloud_upload));
          //  });
        }
      } on SocketException catch (e) {
        String msg = '';
        msg += e.message.isEmpty ? '' : 'Message: ${e.message}\n';
        msg += e.address == null ? '' : 'Address: ${e.address.address}\n';
        msg += e.port == null ? '' : 'Port: ${e.port}\n';
        msg += '${e.osError}';

        showMessageTypeInSnackbar(msg, Icon(Icons.warning), duration: 5);
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       //title: Text(translations['error']),
        //       content: Row(
        //         children: <Widget>[
        //           Expanded(
        //               child: Text(msg
        //                   // 'Server IP(s): $serverIPs\n'
        //                   // 'Server port: $serverPort\n'
        //                   )),
        //         ],
        //       ),
        //       actions: <Widget>[
        //         new TextButton(
        //           child: L.getUpperText('close'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              //title: Text(translations['error']),
              content: Row(
                children: <Widget>[
                  Text(e),
                ],
              ),
              actions: <Widget>[
                new TextButton(
                  child: L.getUpperText('close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  void sendObjects(Socket client) {
    // print('Connection from '
    //     '${client.remoteAddress.address}:${client.remotePort}');

    if (mounted) {
      final snackBar = SnackBar(
        content: Text('Sending objects to '
            '${client.remoteAddress.address}:${client.remotePort}'),
        backgroundColor: Theme.of(context).primaryColor,
      );

      if (_scaffoldKey.currentState != null) {
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
    // clients.add(new SyncClient(client));

    // client.write("Welcome! "
    //     "There are ${clients.length - 1} other clients\n");
  }

  Future<void> openSocketToServer(
      String senderEmail, String serverIPs, int serverPort) async {
    List<String> ips = serverIPs.split(',');
    if (ips.length > 1) {
      showMessageTypeInSnackbar('Server reports several IP: $serverIPs', null);
    }

    for (int i = 0; i < ips.length; i++) {
      try {
        showMessageTypeInSnackbar(
            'Trying to connect to server ${ips[i]}:$serverPort...', null);

        client = await Socket.connect(
          ips[i],
          serverPort,
          timeout: Duration(seconds: 5),
        );

        client.listen(dataHandler,
            onError: errorHandler, onDone: doneHandler, cancelOnError: false);
      } on SocketException catch (e) {
        String msg = '';
        msg += e.message.isEmpty ? '' : 'Message: ${e.message}\n';
        msg += e.address == null ? '' : 'Address: ${e.address.address}\n';
        msg += e.port == null ? '' : 'Port: ${e.port}\n';
        msg += '${e.osError}';

        showMessageTypeInSnackbar(msg, Icon(Icons.warning), duration: 5);
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       //title: Text(translations['error']),
        //       content: Row(
        //         children: <Widget>[
        //           Expanded(
        //               child: Text(msg
        //                   // 'Server IP(s): $serverIPs\n'
        //                   // 'Server port: $serverPort\n'
        //                   )),
        //         ],
        //       ),
        //       actions: <Widget>[
        //         new TextButton(
        //           child: L.getUpperText('close'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              //title: Text(translations['error']),
              content: Row(
                children: <Widget>[
                  Text(e),
                ],
              ),
              actions: <Widget>[
                new TextButton(
                  child: L.getUpperText('close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  void dataHandler(data) {
    print(new String.fromCharCodes(data).trim());
  }

  void errorHandler(error, StackTrace trace) {
    print(error);
  }

  void doneHandler() {
    client.destroy();
    exit(0);
  } */

  Future<bool> handleBackButton() async {
    // save the new current activity
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'SettingScreen');

    return true;
  }
}
