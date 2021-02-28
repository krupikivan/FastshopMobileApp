class Connection {
  var url = '';

  String getUrl() {
    url = '10.0.2.2/FastshopApiProvider'; // Emulador
    // url = '192.168.0.18/FastshopApiProvider'; // Ip privada
    // url = 'fastshop-296500.uc.r.appspot.com'; // Gcloud

    return url;
  }
}

Connection con = Connection();
