import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:get_ip/get_ip.dart';
import 'package:lucas/helpers/SyncClient.dart';

class TestingSockets extends StatefulWidget {
  TestingSockets({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TestingSocketsState createState() => _TestingSocketsState();
}

class _TestingSocketsState extends State<TestingSockets> {
  // String _ip = 'Unknown';
  // String _socketResult = 'Unknown';
  String clientStatus = 'Unknown';
  String serverStatus = 'Unknown';

  List<SyncClient> clients = [];
  String serverIpAddress = '';
  ServerSocket server;
  Socket client;
  String textToSend = '';
  String txtServerIP = '';
  int port = 64646;

  /* void getInternetAddress() async {
    String ipAddress;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      ipAddress = await GetIp.ipAddress;
    } on PlatformException {
      ipAddress = 'Failed to get ipAdress.';
    }

    if (!mounted) return;

    setState(() {
      _ip = ipAddress;
    });
  }

  void getSocketToGoogle() async {
    Socket socket;

    try {
      socket = await Socket.connect("google.com", 80);
    } on PlatformException {
      if (mounted) {
        setState(() {
          _socketResult = 'Failed to open socket';
        });
      }
      return;
    }

    if (!mounted) return;

    setState(() {
      _socketResult = 'Connected to: '
          '${socket.remoteAddress.address}:${socket.remotePort}';
    });

    if (socket != null) {
      socket.destroy();
    }
  }

  void executeSendAndRecieve() async {
    Socket socket;

    try {
      socket = await Socket.connect("google.com", 80);
    } on PlatformException {
      if (mounted) {
        setState(() {
          _socketResult = 'Failed to open socket';
        });
      }
      return;
    }

    if (!mounted) return;

    setState(() {
      _socketResult = 'Connected to: '
          '${socket.remoteAddress.address}:${socket.remotePort}';
    });

    //Establish the onData, and onDone callbacks
    socket.listen((data) {
      print(new String.fromCharCodes(data).trim());
    }, onDone: () {
      // print doc in console
      print("Done");
      socket.destroy();
    });

    String indexRequest = 'GET / HTTP/1.1\nConnection: close\n\n';

    //Send the request
    socket.write(indexRequest);
    print('Local IP: ${socket.remoteAddress.address}');
  } */

  Future<String> getIpAddress() async {
    String ipAddress = '';

    // try {
    //   ipAddress = await GetIp.ipAddress;
    // } on PlatformException {
    //   ipAddress = '';
    // }

    // setState(() {
    //   serverIpAddress = ipAddress;
    // });

    return ipAddress;
  }

  // SERVER STARTS
  void startServer() async {
    String ipAddress = await getIpAddress();

    if (ipAddress.isEmpty) return;
    if (!mounted) return;

    ServerSocket.bind(InternetAddress.anyIPv4, port, shared: true)
        .then((ServerSocket socket) {
      server = socket;
      server.listen((client) {
        handleConnection(client);
      });

      setState(() {
        serverStatus = 'Server ($ipAddress:$port) running';
        serverIpAddress = ipAddress;
        clientStatus = 'Unknown';
      });
    });

    // ServerSocket server =
    //     await ServerSocket.bind(InternetAddress.anyIPv4, port,shared: true);
    // server.listen(handleClient);

    // if (!mounted) return;

    // setState(() {
    //   _serverStatus = 'Running on: ${server.address.address}:${server.port}';
    // });
  }

  void handleConnection(Socket client) {
    /* print('Connection from '
        '${client.remoteAddress.address}:${client.remotePort}');

    clients.add(new SyncClient(client));

    client.write("Welcome! "
        "There are ${clients.length - 1} other clients\n"); */
  }

  sendInfoToClients() {
    for (SyncClient c in clients) {
      c.write(textToSend + "\n");
    }
  }
  // SERVER ENDS

  // CLIENT STARTS
  void startClient() async {
    try {
      client = await Socket.connect(txtServerIP, port);
      if (client != null) {
        setState(() {
          clientStatus =
              'Client (${client.remoteAddress.address}:${client.remotePort}) connected';
        });
      } else {
        setState(() {
          clientStatus = 'Connection failed';
        });
      }
      client.listen(dataHandler,
          onError: errorHandler, onDone: doneHandler, cancelOnError: false);
    } catch (e) {
      setState(() {
        clientStatus = 'Connection failed: $e';
      });
      return;
    }

    // //Connect standard in to the socket
    // stdin.listen(
    //     (data) => client.write(new String.fromCharCodes(data).trim() + '\n'));
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
  }
  // CLIENT ENDS

  // void handleClient(Socket client) {
  //   print('Connection from '
  //       '${client.remoteAddress.address}:${client.remotePort}');

  //   client.write("Hello from simple server!\n");
  //   client.close();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket Testing'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // internetAddress(),
          // socketToGoogle(),
          // sendAndRecieve(),
          startSyncServer(),
          startSyncClient(),
          sentToClientsClient(),
        ],
      ),
    );
  }

  // Widget internetAddress() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Text(_ip),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: MaterialButton(
  //           onPressed: getInternetAddress,
  //           child: Text('Get IP'),
  //           color: Colors.red,
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget socketToGoogle() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(_socketResult),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: MaterialButton(
  //           onPressed: getSocketToGoogle,
  //           child: Text('Open socket to Google'),
  //           color: Colors.red,
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget sendAndRecieve() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(_socketResult),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: MaterialButton(
  //           onPressed: executeSendAndRecieve,
  //           child: Text('Send & Recieve'),
  //           color: Colors.red,
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget startSyncServer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(serverStatus),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: startServer,
            child: Text('Start server'),
            color: Colors.red,
          ),
        )
      ],
    );
  }

  Widget startSyncClient() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Server IP:'),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              txtServerIP = text;
                            });
                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.all(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(clientStatus),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: startClient,
            child: Text('Start client'),
            color: Colors.red,
          ),
        )
      ],
    );
  }

  Widget sentToClientsClient() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: sendInfoToClients,
            child: Text('Send to clients'),
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
