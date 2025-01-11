#include "BluetoothSerial.h"
#include <Stepper.h>

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

#define RED     32 // RED   -> pin 08 -> GPIO 32
#define BLUE    33 // BLUE  -> pin 09 -> GPIO 33
#define GREEN   25 // GREEN -> pin 10 -> GPIO 25
#define BLACK   26 // BLACK -> pin 11 -> GPIO 26
#define ENABLE  27 // EN_H  -> pin 12 -> GPIO 27

Stepper stepper(360, RED, BLUE, GREEN, BLACK);
BluetoothSerial SerialBT;

char bt_command = 0;
=
void setup() {
  Serial.begin(115200);

  // Horizontal rotate setup
  pinMode(RED, OUTPUT);
  pinMode(BLUE, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLACK, OUTPUT);
  pinMode(ENABLE, OUTPUT);
  stepper.setSpeed(30);

  // Bluetooth connect
  SerialBT.begin("Kaarten Shieter"); //Bluetooth device name
  
  Serial.println("The device started, now you can pair it with bluetooth!");
}

void loop() {
  if (SerialBT.available()) {
    bt_command = SerialBT.read();
    Serial.println(bt_command);
    switch(bt_command) {
      case 'l': // Turn left
        rotate(true);
        break;  
      case 'r': // Turn right
        rotate(false);
        break;  
      case 's': // Shoot
        break;
      default:  // ignore the rest
        break;
    }
  }
  delay(20);
}

void rotate(boolean left) {
  digitalWrite(ENABLE, HIGH);
  delay(20);
  if (left) stepper.step(15);
  else      stepper.step(-15);
  delay(20);
  digitalWrite(ENABLE, LOW);
}
