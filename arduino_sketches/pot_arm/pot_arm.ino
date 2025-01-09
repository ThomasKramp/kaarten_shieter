// Potentiometer is connected to GPIO 34 (Analog ADC1_CH6) 
#define POT_PIN 13

// variable for storing the potentiometer value
uint16_t potValue = 0;

void setup() {
  Serial.begin(115200);
  delay(1000);
}

void loop() {
  // Reading potentiometer value
  potValue = analogRead(POT_PIN)/4;
  Serial.println(potValue);
  delay(500);
}

// Full:  0
// Empty: 250

// no cards:  1530 - 817 mostly 1535
// 55 cards:  797 - 802 mostly 800
