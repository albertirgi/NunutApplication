enum Environment { Local, Dev, Prod }

class Config {
  static Map<String, dynamic> _config = _ConfigMap.localConfig;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.Local:
        _config = _ConfigMap.localConfig;
        break;
      case Environment.Dev:
        _config = _ConfigMap.devConfig;
        break;
      case Environment.Prod:
        _config = _ConfigMap.prodConfig;
        break;
    }
  }

  static String getEnvironment() {
    if (_config == _ConfigMap.prodConfig) {
      return "prod";
    } else if (_config == _ConfigMap.devConfig) {
      return "dev";
    } else {
      return "local";
    }
  }

  static bool isProd() => _config == _ConfigMap.prodConfig;

  static bool isLocal() => _config == _ConfigMap.localConfig;

  static get baseURL {
    return _config[_ConfigMap.BASE_URL];
  }

  static get midtransURL {
    return _config[_ConfigMap.MIDTRANS_URL];
  }

  static get midtransClientKey {
    return _config[_ConfigMap.MIDTRANS_CLIENT_KEY];
  }
}

class _ConfigMap {
  static const BASE_URL = "BASE_URL";
  static const MIDTRANS_URL = "MIDTRANS_URL";
  static const MIDTRANS_CLIENT_KEY = "MIDTRANS_CLIENT_KEY";

  static Map<String, dynamic> localConfig = {
    BASE_URL: "http://localhost:3000",
    MIDTRANS_URL: "https://app.sandbox.midtrans.com/snap/snap.js",
    MIDTRANS_CLIENT_KEY: "SB-Mid-client-5TcCUhLDAoRnAsCq"
  };

  static Map<String, dynamic> devConfig = {
    BASE_URL: "http://localhost:5000",
    MIDTRANS_URL: "https://app.sandbox.midtrans.com/snap/snap.js",
    MIDTRANS_CLIENT_KEY: "SB-Mid-client-5TcCUhLDAoRnAsCq"
  };

  static Map<String, dynamic> prodConfig = {
    BASE_URL: "http://localhost:5000",
    MIDTRANS_URL: "https://app.sandbox.midtrans.com/snap/snap.js",
    MIDTRANS_CLIENT_KEY: "SB-Mid-client-5TcCUhLDAoRnAsCq"
  };
}
