Het idee van dit project is om een kaarten schieter te maken die op afstandsbediening te besturen is.
# Brainstorm
De kaarten schieter zal uit 2 componenten bestaan: Afstandsbediening *(Remote)* & Module

![[base_diagram.png]]
De volgende idee worden geïmplementeerd worden in dit project:
- **LCD/OLED scherm:**
  Deze toont in welke modus de module staat.
- **Een kaart motor:**
  Deze zal er uiteindelijk voor zorgen dat de kaarten afgeschoten worden.
- **Een motor voor horizontale rotatie:**
  Hierdoor kan de module in 360° kaarten afschieten.
- **Een servo voor verticale rotatie:**
  Hiermee kan er gericht worden.
- **Bluetooth module:**
  Bluetooth is een protocol dat tamelijk simpel is om te implementeren. Via Bluetooth kunnen we communiceren tussen afstandsbediening en module.
- **Joystick:**
  Hiermee bepalen we de beweging mee van de mode module.
* **Knoppen:**
  Deze knoppen kunnen dienen om te selecteren tussen modussen en het aantal spelers mee te geven.
* **Laser:**
  Met de laser kunnen we te tonen de kaarten worden gericht.
* **Sensor:**
  Met de sensor kunnen we zien of er nog kaarten over zijn.
# ==Onderzoek==
## Module
### MCU & Bluetooth
Voor de module gaat er gebruik gemaakt worden van de **ESP32-WROOM** chip aangezien we hiermee de modules kunnen aansturen en deze Bluetooth ondersteuning ingebouwd heeft. *Deze wordt zonder devboard gebruikt om de operavlakte van de PCB te verkleinen.*
**Specificaties**:
- **Spanning:** 3V3.
- **==Stroom:** varierent ???==

![[ESP32_WROOM_Pinout.webp]]
![[esp32_wroom_datasheet.pdf#page=8]]
### Kaart motor
Voor de kaart motor wordt er gebruik gemaakt van een brush motor.
- Hieraan koppelen we een wiel, met een rubber bandje, om de kaarten af te schieten.
- De motor zal constant draaien om zijn snelheid te behouden.
- Eenmaal er geschoten moet worden, zal een solinoïde de motor naar het boeket kaarten duwen.
- Uiteindelijk wordt de motor terug naar boven getrokken a.d.h.v. elastieke bandjes.
**Specificaties**:
- **Spanning:** 3V3/5V.
- **==Stroom:** varierent ???==
- **Aansturing:** H-Brug & GPIO
### Horizontale rotatie motor
Voor de OLED wordt er gebruik gemaakt van de NEMA17 stepper motor. Hiermee kunnen we de richting van de module nauwkeurig instellen.
**Specificaties**:
- **Spanning:** 3V6.
- **==Stroom:** ???==
- **Aansturing:** H-Brug & Pulsen
![[nema17_datasheet.pdf#page=2]]
### Verticale rotatie servo
***Dit aspect wordt achterwegen gelaten dankzij tijdsrestricties.***
### Laser
***Dit aspect wordt achterwegen gelaten dankzij tijdsrestricties.***
### Sensor
Als sensor, wordt er gebruik gemaakt van een potentiometer met een arm. Afhankelijk van hoeveel spanning er over de middelste pin staat, kan er een waarde uitgelezen worden die vermeld of er nog kaarten geladen zijn.
**Specificaties**:
- **Spanning:** Vcc.
- **==Stroom:** ???==
- **Aansturing:** Uitlezing via ADC.
## Afstandbediening
***De afstandbediening is door tijdsrestricties optioneel geworden.***
### MCU & Bluetooth
Voor de module gaat er gebruik gemaakt worden van de ESP32-WROOM chip.
### OLED
Voor de OLED wordt er gebruik gemaakt van de SSD1306. Deze zal tonen in welke mode onze module staat:
- **Blackjack:** 1 dealer & 4 spelers
- **Uno:** 4 spelers rondom
- **Free mode:** 4 spelers op zelf besloten plaatsen
- **Assault mode:** Gewoon schieten
**Specificaties**:
- **Spanning:** 3V3.
- **==Stroom:** ???==
- **Aansturing:** I2C
![[ssd1306_datasheet.pdf]]
### Joystick
Voor de Joystick wordt er gebruik gemaakt van de SKQUCAA010.
**Specificaties**:
- **Spanning:** Vcc.
- **==Stroom:** ???==
- **Aansturing:** Uitlezen via GPIO
![[skqucaa010_datasheet.pdf#page=2]]
### Knoppen
***Dit aspect wordt achterwegen gelaten aangezien we de besturing via de joystick kunnen doen.***
# Elektrisch schema
Het elektrisch schema is gemaakt met KiCad.
Alle modules en externe componenten worden via een JST-connector en kabels verbonden aan de PCB.
Enige componenten worden uit de componentenlijst van de Universiteit van Antwerpen *(te vinden in het school_componenten.xlsx bestand)* gekozen of via de volgende websites opgezocht voor bestelling:
- [Farnell](https://be.farnell.com/en-BE/)
- [OctoParts](https://octopart.com/)
- [AliExpress](https://nl.aliexpress.com)
## Volledig schema
![[schematic.pdf]]
## Schema componenten
### Microcontroller
Zoals reeds vermeld is wordt de ESP32-WROOM als microcontroller gebruikt. Deze wordt zonder devboard op de PCB geplaatst om plaats uit te sparen.
Het PCB schema is gebaseerd op het schema uit de datasheet:
![[esp32_wroom_datasheet.pdf#page=19]]

Daarnaast worden er twee groepen aan connectoren voorzien:
- **02x03 connector:** Hiermee kunnen we met een externe programmer verbinden.
- **Twee 02x09 connectors:** Hiermee brengen we alle poorten van de ESP32 MCU naar buiten. Dit wordt gedaan voor debug redenen.
Het schema ziet er als volgt uit:
- Module:
![[mcu_module.png]]

- Remote:
![[mcu_remote.png]]
### Programmer
Zoals hiervoor al vermeld is wordt er een aparte progammer gebruikt om plaats op de PCBs uit te besparen. De programmer PCB maakt gebruik van de FT232R USB UART converter.
Specificaties:
- **Input USB spanning:** 5V
- **Output UART spanning:** 1V8, 2V8, 3V3 & 5V
Het schema van de PCB is gebaseerd op twee voorbeelden:
- Het FT232R *USB to MCU UART interface* voorbeeld:
![[ft232r_datasheet.pdf#page=31]]

- Het ESP32 Devkit schema:
![[esp32_devkitc_schematic.pdf]]

Zoals in het Devkit schema *(links vanonder)* te zien is, maakt de programmer gebruik van twee NPN-transistoren om de MCU op de juiste moment te enablen. Voor deze transistoren maken we gebruik van de BCW71.
Specificaties:
- **Open collector spanning:** 5V
- **Collector stroom:** 100mA
![[bcw71_datasheet.pdf#page=2]]

Het schema ziet er als volgt uit:
![[programmer.png]]

Voor zekerheid dat de MCU zeker geprogrammeerd kan worden zijn de volgende stappen genomen:
- De UART TX & RX pinnen zijn met *"traingular solder jumper pads"* verbonden, in het geval dat de verbindingen foutief zijn.
- Alle pinnen zijn naar buiten gebracht. Hierdoor kunnen we de MCU nog programmeren a.d.h.v. een extern devkit board *(zoals de [ESP32 D1 MINI](https://galopago.github.io/assets/pdf/esp32-d1-mini.pdf))*.
### Kaart H-brug
Aangezien beide de kaart motor en solinoïde gebruik maken van spoelen, worden ze beveiligd a.d.h.v. een H-brug. De gebruikte H-brug driver is een DRV8833.
Specificaties:
- **Maximum voltage:** 10V
- **Maximum stroom:** 1.5A
Aangezien deze driver bestaat uit twee H-bruggen, kunnen we beide de motor en solinoïde aansturen met dezelfde driver.
- De motor functioneert vanaf een spanning van 3V.
- De solinoïde functioneerd vanaf een spanning van 5V.
Voor deze driver wordt er een aparte voeding voorzien van 5V. *(De motor functioneert ook op 5V.)*
![[drv8833_datasheet.pdf]]

Het elektrisch schema ziet er als volgt uit:
![[h_bridge_driver_card.png]]
### Horizontale rotatie H-brug
Om de NEMA17 *(stepper)* motor aan te sturen, hebben we nood aan twee H-bruggen. Aangezien deze motor werkt vanaf 3V, kunnen we hier ook een DRV883 driver gerbuiken.
Het elektrisch schema ziet er als volgt uit:
![[h_bridge_driver_hori.png]]
### Voeding
Beide de module en afstandsbediening hebben nood aan voeding. Hierbij wordt er gebruik gemaakt van batterijen en step down converters:
- **Batterij:** 18650 1200mAh 3.6V
- **Step down converter:** LM2596
![[lm2596_datasheet.pdf]]

De module heeft drie spanningen nodig: 3V3, 3V3 motor aansturing & 5V motor aansturing.
- **5V MA:** De batterijen komen met een 3V3 naar 5V converter bord, dat ook dient om ze op te laden.
- **3V3 & 3V3 MA:** Deze kunnen we m.b.v. de step down converters bekomen.
Deze worden dan allemaal met de PCB a.d.h.v. een screw terminal. Het schema is als volgt:
![[supply_terminals_module.png]]

De afstandbediening heeft enkel nood aan 3V3 om te functioneren. Dit kan gedaan worden met een enkele batterij en een step down converter. Het schema is als volgt:
![[supply_terminals_remote.png]]
### Laser controller
Voor te richten wordt er gebruik gemaakt van een [laser](https://nl.aliexpress.com/item/1005005965904497.html?spm=a2g0o.productlist.main.1.486f5a5fnkwrmv&algo_pvid=1d03160c-83f5-4386-951f-2b8b5557513d&algo_exp_id=1d03160c-83f5-4386-951f-2b8b5557513d-0&pdp_npi=4%40dis%21EUR%213.06%213.06%21%21%2123.17%2123.17%21%4021038e8317283929845612749e1452%2112000035084960358%21sea%21BE%214336790662%21X&curPageLogUid=0sLpbIOsMe3v&utparam-url=scene%3Asearch%7Cquery_from%3A). Deze werkt vanaf 5V. Gelukkig kan dit afgetakt worden van de kaart H-brug.
Aangezien de ESP32 MCU werkt op 3V3, gaan we een MOSFET moeten gebruiken om de laser aan te sturen. De 2N7002 N-channel mosfet wordt gebruikt.
Specificaties:
- **Gate threshold spanning:** 2V1
- **Maximum drain stroom:** 115mA
![[2n7002_datasheet.PDF#page=2]]

Het schema ziet er als volgt uit:
![[laser_control.png]]
### Potentiometer arm
Als sensor wordt er gebruik gemaakt van een potentiometer die,  met een arm, gaat meten of er nog kaarten zijn.
Aangezien de ESP32 MCU werkt met een spanning van 3V3 en het een [analoge waarde kan mappen op 12 bits (4096)](https://lastminuteengineers.com/esp32-basics-adc/), heeft het een accuraatheid van 805µV.
We nemen een potentiometer van 10kOhm en meten de waarde die over de potentiometer staat.
Voor de veiligheid zijn er een paar serieweerstanden toegevoegd zodat er geen open keten ontstaat. Neem 4 1kOhm weerstanden:
- Als de potentiometer helemaal open staat *(0Ohm)*, dan zal er een voltage van 470mV gemeten worden.
$$V_{IN} = \frac{R_{UP}}{R_{UP} + R_{Pot Open} + R_{Down}} \cdot V_{CC} = \frac{2k\Omega}{2k\Omega + 10k\Omega + 2k\Omega} \cdot 3V3 = 470mV$$
- Als de potentiometer helemaal gelsoten staat *(10kOhm)*, dan zal er een voltage van 2V82 gemeten worden.
$$V_{IN} = \frac{R_{UP} + R_{Pot Open}}{R_{UP} + R_{Pot Open} + R_{Down}} \cdot V_{CC} = \frac{2k\Omega + 10k\Omega}{2k\Omega + 10k\Omega + 2k\Omega} \cdot 3V3 = 2V82$$
Het schema ziet er als volgt uit:
![[Images/schematic/pot_arm.png]]
### Verticale rotatie servo
De servo heeft 5V nodig om te functioneren en werkt op basis van een pulssignaal. Gelukkig kan de 5V afgetakt worden van de kaart H-brug.
Het schema ziet er als volgt uit:
![[servo_vert.png]]
### Joystick
De joystick werkt a.d.h.v. een common pin die doorverbonden wordt naar de up, down, left, right of center pin. Deze common pin wordt met een pull-up weerstand verbonden met de 3V3 Vcc en de andere pinnen worden [geactiveerd via een interrupt](https://lastminuteengineers.com/handling-esp32-gpio-interrupts-tutorial/).
![[skqucaa010_datasheet.pdf#page=2]]
Het schema ziet er als volgt uit:
![[joystick.png]]
### Menu scherm
Het menu scherm is een SSD1306 OLED scherm. Deze werkt op 3V3 en communiceert over I2C.
![[ssd1306_datasheet.pdf]]

Het schema ziet er als volgt uit:
![[menu_screen.png]]
## Fouten in pin verdeling
Uit verder onderzoek blijk dat [niet alle pinnen op de ESP32 WROOM MCU bruikbaar](https://lastminuteengineers.com/esp32-wroom-32-pinout-reference) zijn.

| Bruikbaar | Pins | Probeer te vermijden | Pins | Onbruikbaar | Pins |
| --------- | ---- | -------------------- | ---- | ----------- | ---- |
| GPIO4     | 26   | GPIO0                | 25   | GPIO1       | 35   |
| GPIO13    | 16   | GPIO2                | 24   | GPIO3       | 34   |
| GPIO14    | 13   | GPIO5                | 29   | GPIO6       | 20   |
| GPIO16    | 27   | GPIO12               | 14   | GPIO7       | 21   |
| GPIO17    | 28   | GPIO15               | 23   | GPIO8       | 22   |
| GPIO18    | 30   | GPIO34 *(Input)*     | 6    | GPIO9       | 17   |
| GPIO19    | 31   | GPIO35 *(Input)*     | 7    | GPIO10      | 18   |
| GPIO21    | 33   | GPIO36 *(Input)*     | 4    | GPIO11      | 19   |
| GPIO22    | 36   | GPIO39 *(Input)*     | 5    | /           |      |
| GPIO23    | 37   | /                    |      | /           |      |
| GPIO25    | 10   | /                    |      | /           |      |
| GPIO26    | 11   | /                    |      | /           |      |
| GPIO27    | 12   | /                    |      | /           |      |
| GPIO32    | 8    | /                    |      | /           |      |
| GPIO33    | 9    | /                    |      | /           |      |
Dit betekent dat de volgende pinnen doorverbonden moeten worden:
- Voor de module:

| Signaal          | Oude Pin      | Nieuwe Pin    |
| ---------------- | ------------- | ------------- |
| EN_Hori          | 17 *(GPIO9)*  | 8 *(GPIO32)*  |
| Motor_Hori_Black | 19 *(GPIO11)* | 9 *(GPIO33)*  |
| Motor_Hori_Green | 20 *(GPIO6)*  | 10 *(GPIO25)* |
| Motor_Hori_Red   | 21 *(GPIO7)*  | 11 *(GPIO26)* |
| Motor_Hori_Blue  | 22 *(GPIO8)*  | 12 *(GPIO27)* |
- Voor de afstandsbediening:

| Signaal   | Oude Pin      | Nieuwe Pin    |
| --------- | ------------- | ------------- |
| UP_JS     | 17 *(GPIO9)*  | 8 *(GPIO32)*  |
| LEFT_JS   | 18 *(GPIO10)* | 9 *(GPIO33)*  |
| DOWN_JS   | 19 *(GPIO11)* | 10 *(GPIO25)* |
| RIGHT_JS  | 20 *(GPIO6)*  | 11 *(GPIO26)* |
| CENTER_JS | 21 *(GPIO7)*  | 12 *(GPIO27)* |
# PCB
De PCB is gemaakt met KiCad en besteld bij [JLCPCB](https://jlcpcb.com/).
De PCB bestaat uit drie onderdelen:
- De module
- De afstandsbediening
- De programmer
Enige footprints die niet standaard in KiCad staan zijn gevonden op [SnapMagic](https://www.snapeda.com/home/) of gemaakt via de footprint editor en kunnen in de */libraries* folder gevonden worden.
## Routes
### Alle routes
![[pcb_routes.png]]
### Voorkant routes
![[pcb_routes_front.png]]
### Achterkant routes
![[pcb_routes_back.png]]
## 3D
### 3D voorkant
![[pcb_3d_front.png]]
### 3D achterkant
![[pcb_3d_back.png]]
## ==Bestukt==
==Moet nog fotos nemen==
# Behuizing
## 3D-printer
De behuizing is gemaakt met OpenSCAD. De bestanden hiervoor zijn te vinden in *casing* folder.
Nota's:
- meer tolerantie op baterijen in box
- opening voor switch in box
- buck converter gaten staan verkeert
- voeg step up converter toe MT3608 aan bc plate
- bc plate scheidingen
- wiel gat vergroten voor tandwiel
- kijk alle elestikjes randen na
- schieter toren aanpassen naar solinoide en motor apart
- meer tolerantie tussen schuiver
- geen tussenstuk meer
- 
### Doos
![[box_outside.png]]
![[box_inside.png]]
### Buck plaat
![[buck_plate.png]]
### PCB plaat
![[pcb_plate.png]]
### Deksel
![[lid_top.png]]
![[lid_bottom.png]]
### Kaart schieter
#### Toren
![[card_tower.png]]
#### Wiel
![[card_wheel.png]]
### Sensor
#### Houder
![[pot_holder.png]]
#### Arm
![[Images/casing/pot_arm.png]]
## Lazercutter

# Code
