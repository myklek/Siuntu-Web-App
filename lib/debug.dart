import 'package:siuntu_web_app/services/auth.dart' as auth;
import 'package:siuntu_web_app/services/shipments.dart' as shipmentAPI;

void main() {
  auth.login('test@email.com', 'password');
  shipmentAPI.getShipments();

}