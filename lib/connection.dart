class Connection {
  var url = '';

  String getUrl() {
    url = '192.168.0.18/FastshopApiProvider';
    // url = '181.169.92.59/FastshopApiProvider';
    // url = 'fastshop-296500.uc.r.appspot.com';

    return url;
  }
}

Connection con = Connection();
