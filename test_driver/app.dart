import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FlutterDriver driver;

  // test('check flutter driver health', () async {
  //   final health = await driver.checkHealth();
  //   expect(health.status, HealthStatus.ok);
  // });

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });
}
