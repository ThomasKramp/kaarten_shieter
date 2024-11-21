uint8_t en_m = 9;

uint8_t red = 8;
uint8_t blue = 7;
uint8_t green = 6;
uint8_t black = 11;

void setup() {
  for (int i = 1; i < 38; i++) {
  pinMode(i, OUTPUT);
  digitalWrite(i, HIGH);!
  }
  
  /*pinMode(en_m, OUTPUT);
  digitalWrite(en_m, HIGH);
  pinMode(red, OUTPUT);
  digitalWrite(red, LOW);
  pinMode(blue, OUTPUT);
  digitalWrite(blue, HIGH);*/
}

void loop() {
}
