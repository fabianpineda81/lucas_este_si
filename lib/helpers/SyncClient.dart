import 'dart:io';

class SyncClient {
  static List<SyncClient> clients = <SyncClient>[];

  Socket _socket;
  String _address;
  int _port;
  bool isServer;
  String lastMessage = '';

  SyncClient(Socket s, bool socketIsFromServer) {
    isServer = socketIsFromServer;
    _socket = s;
    _address = _socket.remoteAddress.address;
    _port = _socket.remotePort;

    //if (!isClientForTest) {
    SyncClient.clients.add(this);
    _socket.listen(messageHandler,
        onError: errorHandler, onDone: finishedHandler);
    //}
  }

  void messageHandler(List<int> data) {
    String message = new String.fromCharCodes(data).trim();

    if (lastMessage != message) {
      print('IP: $_address, Server: $isServer, Message: $message');
      distributeMessage(this, message);
    }
  }

  void errorHandler(error) {
    print('$_address:$_port Error: $error');
    removeClient(this);
    _socket.close();
  }

  void finishedHandler() {
    print('$_address:$_port Disconnected');
    removeClient(this);
    _socket.close();
  }

  void write(String message) {
    _socket.write(message);
  }

  void distributeMessage(SyncClient client, String message) {
    removeDuplicatedClients();
    for (SyncClient c in clients) {
      if (!c._address.contains(client._address) &&
          !client._address.contains(c._address) &&
          (lastMessage != message)) {
        c.write(message + "\n");
        lastMessage = message;
      }
    }
  }

  void removeClient(SyncClient client) {
    clients.remove(client);
  }

  static removeDuplicatedClients() {
    for (int i = clients.length - 1; i >= 0; i--) {
      SyncClient lookForClient = clients[i];

      bool found = false;
      for (int j = 0; j < clients.length; j++) {
        if (i != j) {
          SyncClient client = clients[j];
          if (lookForClient._address.contains(client._address)) {
            found = true;
            break;
          }
        }
      }

      if (found) {
        clients.removeAt(i);
      }
    }
  }
}
