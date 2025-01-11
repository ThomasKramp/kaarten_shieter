#include <ESP32Servo.h>

// Sensor values
#define POT_PIN 13
#define POT_FUL 265 // All cards are loaded (Full)
#define POT_EMP 525 // No cards are loaded  (Empty)
uint16_t pot_val = 0;

// Servo values
#define ARM_ERR 0
#define ARM_TOP 129 + ARM_ERR // Angle to top of deck     (Top)
#define ARM_BOT 84 + ARM_ERR // Angle to bottom of deck  (Bottom)
#define ARM_OFF 15  // Offset from deck         (Offset)
Servo card_arm;
uint8_t arm_pos = ARM_TOP;

// Other values
#define DEBUG
#define DELAY 378

void setup() {
  Serial.begin(115200);

  // Servo setup
  card_arm.attach(2);
  card_arm.write(arm_pos+ARM_OFF);
  delay(DELAY*3);
  
  delay(1000);
}

void loop() {// Read value
  pot_val = analogRead(POT_PIN)/4;
  #ifdef DEBUG
  Serial.print("Sensor:\t\t");  Serial.print(pot_val);  Serial.print("\t");
  #endif

  // Change position
  arm_pos = map(pot_val, POT_FUL, POT_EMP, ARM_TOP, ARM_BOT);
  #ifdef DEBUG
  Serial.print("Actuator:\t");  Serial.println(arm_pos);
  #endif

  card_arm.write(arm_pos);
  delay(500);
}

// Potentiometer
// Full:    20
// Empty:   250

// Servo
// Top:     147
// Bottom:  112
