#include <ESP32Servo.h>

#define card_sleep  5
#define card_pos    16
#define card_neg    17

#define DEBUG
#define DELAY 378

Servo card_arm;

void setup() {
  Serial.begin(115200);
  // Motor setup
  pinMode(card_sleep, OUTPUT);
  pinMode(card_pos,   OUTPUT);
  pinMode(card_neg,   OUTPUT);
  digitalWrite(card_pos, LOW);
  digitalWrite(card_neg, LOW);

  // Servo setup
  card_arm.attach(2);
  card_arm.write(135);
  delay(DELAY*3);
  
}

void loop() {
  shoot();
  delay(DELAY*3);
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
  card_arm.write(45);
  delay(DELAY);
  
  // Lift motor
  #ifdef DEBUG
  Serial.println("Lift motor");
  #endif
  card_arm.write(135);
  delay(DELAY);
  
  // Put motor in sleep
  #ifdef DEBUG
  Serial.println("Put motor in sleep");
  #endif
  digitalWrite(card_pos, LOW);
  delay(DELAY/10);
  digitalWrite(card_sleep, LOW);
}
