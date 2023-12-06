import 'adapters/http_client_test.dart' as http_client_test;
import 'payment_methods/credit_card/mock_tests/credit_card_check_test.dart'
    as credit_card_check_test;
import 'payment_methods/credit_card/mock_tests/credit_card_pay_test.dart'
    as credit_card_pay_test;
import 'payment_methods/nequi/mock_tests/nequi_check_test.dart'
    as nequi_check_test;
import 'payment_methods/nequi/mock_tests/nequi_pay_test.dart' as nequi_pay_test;
import 'payment_methods/pse/mock_tests/pse_check_test.dart' as pse_check_test;
import 'payment_methods/pse/mock_tests/pse_pay_test.dart' as pse_pay_test;
import 'services/wompi_acceptance_token_test.dart'
    as wompi_acceptance_token_test;
import 'services/wompi_client_test.dart' as wompi_client_test;

void main() {
  http_client_test.main();
  credit_card_check_test.main();
  credit_card_pay_test.main();
  nequi_check_test.main();
  nequi_pay_test.main();
  pse_check_test.main();
  pse_pay_test.main();
  wompi_acceptance_token_test.main();
  wompi_client_test.main();
}
