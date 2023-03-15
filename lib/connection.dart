class Connection {
  var url = '';

  String getUrl() {
    url = '192.168.1.156/api'; // Emulator
    // url = '192.168.0.135/FastshopApiProvider'; // Device

    return url;
  }
}

Connection con = Connection();
