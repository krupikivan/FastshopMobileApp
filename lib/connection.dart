class Connection {
  var url = '';

  String getUrl() {
    //url = "192.168.1.13";                   //Para el android emulator
    //url = "192.168.1.175/FASTSHOP";  //para mi cel
    //  url = "10.1.1.107";                  //Para celular
    // url = "192.168.1.24/FastshopApiProvider";   //Para celular
    url = 'fastshop2020.000webhostapp.com'; //Para celular

    return url;
  }
}

Connection con = Connection();
