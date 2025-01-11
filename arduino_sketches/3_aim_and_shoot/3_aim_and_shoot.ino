#include "BluetoothSerial.h"
#include "Stepper.h"
#include "ESP32Servo.h"

// Bluetooth values
#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif
BluetoothSerial SerialBT;
char bt_command = 0;

// Rotation motor values
#define RED     32 // RED   -> pin 08 -> GPIO 32
#define BLUE    33 // BLUE  -> pin 09 -> GPIO 33
#define GREEN   25 // GREEN -> pin 10 -> GPIO 25
#define BLACK   26 // BLACK -> pin 11 -> GPIO 26
#define ENABLE  27 // EN_H  -> pin 12 -> GPIO 27
Stepper stepper(360, RED, BLUE, GREEN, BLACK);

// Sensor values
#define POT_PIN 13
#define POT_FUL 265  // All cards are loaded (Full)
#define POT_EMP 525 // No cards are loaded  (Empty)
uint16_t pot_val = 0;

// Servo values
#define ARM_ERR 4
#define ARM_TOP 129 + ARM_ERR // Angle to top of deck     (Top)
#define ARM_BOT 84 + ARM_ERR // Angle to bottom of deck  (Bottom)
#define ARM_OFF 15  // Offset from deck         (Offset)
Servo card_arm;
uint8_t arm_pos = ARM_TOP;

// Card motor values
#define card_sleep  5
#define card_pos    16
#define card_neg    17

// Other values
#define DEBUG
#define DELAY 378

void setup() {
  Serial.begin(115200);
  
  // Bluetooth connect
  SerialBT.begin("Kaarten Shieter"); //Bluetooth device name

  // Roation motor setup
  pinMode(RED, OUTPUT);
  pinMode(BLUE, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLACK, OUTPUT);
  pinMode(ENABLE, OUTPUT);
  stepper.setSpeed(30);

  // Servo setup
  card_arm.attach(2);
  card_arm.write(arm_pos+ARM_OFF);
  delay(DELAY*3);

  // Motor setup
  pinMode(card_sleep, OUTPUT);
  pinMode(card_pos,   OUTPUT);
  pinMode(card_neg,   OUTPUT);
  digitalWrite(card_pos, LOW);
  digitalWrite(card_neg, LOW);
  
  delay(1000);
}

void loop() {
  if (!SerialBT.connected()){
    #ifdef DEBUG
    Serial.println("Reconnect");
    #endif
    SerialBT.begin("Kaarten Shieter");
  }
  if (SerialBT.available()) {
    bt_command = SerialBT.read();
    #ifdef DEBUG
    Serial.println(bt_command);
    #endif
    switch(bt_command) {
      case 'l': // Turn left
        rotate(true);
        break;  
      case 'r': // Turn right
        rotate(false);
        break;  
      case 's': // Shoot
        measure_and_shoot();
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

void measure_and_shoot() {
  // Read value
  pot_val = analogRead(POT_PIN)/4;
  #ifdef DEBUG
  Serial.print("Sensor:\t\t");  Serial.print(pot_val);  Serial.print("\t");
  #endif

  if (pot_val < POT_EMP + 10) {
    // Change position
    arm_pos = map(pot_val, POT_FUL, POT_EMP, ARM_TOP, ARM_BOT);
    #ifdef DEBUG
    Serial.print("Actuator:\t");  Serial.println(arm_pos);
    #endif
  
    // Shoot
    shoot();
  }
}

void shoot() {
  // Activate motor
  #ifdef DEBUG
  Serial.println("Activate motor");
  #endif
  digitalWrite(card_sleep, HIGH);
  delay(DELAY/10);
  digitalWrite(card_pos, HIGH);
  delay(DELAY);
  
  // Lower motor
  #ifdef DEBUG
  Serial.println("Lower motor");
  #endif
  card_arm.write(arm_pos);
  delay(DELAY);
  
  // Lift motor
  #ifdef DEBUG
  Serial.println("Lift motor");
  #endif
  card_arm.write(arm_pos+ARM_OFF);
  delay(DELAY);
  
  // Put motor in sleep
  #ifdef DEBUG
  Serial.println("Put motor in sleep");
  #endif
  digitalWrite(card_pos, LOW);
  delay(DELAY/10);
  digitalWrite(card_sleep, LOW);
}
