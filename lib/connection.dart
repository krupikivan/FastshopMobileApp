class Connection {
  var url = '';

  String getUrl() {
    url = 'http://192.168.1.156/api'; // Local
    // url = 'https://fastshop-backend.herokuapp.com'; // Heroku
    // url = '192.168.0.135/FastshopApiProvider'; // Device

    return url;
  }
}

Connection con = Connection();
