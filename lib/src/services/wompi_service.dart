import 'package:wompi_pago/src/services/wompi_client.dart';

abstract class WompiService {
  final WompiClient wompiClient;

  WompiService(this.wompiClient);
}
