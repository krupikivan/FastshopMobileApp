class Connection {
  var url = '';

  String getUrl() {
    // url = '10.0.2.2/FastshopApiProvider'; // Emulator
    url = '192.168.0.135/FastshopApiProvider'; // Device

    return url;
  }
}

Connection con = Connection();
