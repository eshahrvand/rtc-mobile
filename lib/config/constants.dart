String baseImage = "assets/images";

String baseUrl =
    // "https://api.rtciran.com/api/v1/";
    "http://192.168.2.20:8001/api/v1/";

String sentryDsn =
    "https://2962c320fa06ba33cac5f31ed9506446@sentry.caltivita.com/10";

const Duration connectionTimeout = Duration(seconds: 4);
const Duration receiveTimeout = Duration(seconds: 7);
const Duration sendTimeout = Duration(seconds: 12);
