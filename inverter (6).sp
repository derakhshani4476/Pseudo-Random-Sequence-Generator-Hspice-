* Inverter 

* Library
.include '22nm_HP.pm'

.GLOBAL vdd! gnd! 

* SUB Circuit
.SUBCKT FF CLK D Q
MM0 CLKnot CLK gnd! gnd! NMOS w=22n l=22n
MM1 CLKnot CLK vdd! vdd! PMOS w=66n l=22n
MM2 1 CLK D D NMOS w=22n l=22n
MM3 1 CLKnot D D PMOS w=66n l=22n
MM4 2 1 gnd! gnd! NMOS w=22n l=22n
MM5 2 1 vdd! vdd! PMOS w=66n l=22n
MM6 4 2 gnd! gnd! NMOS w=22n l=22n
MM7 4 2 vdd! vdd! PMOS w=66n l=22n
MM8 1 CLKnot 4 4 NMOS w=22n l=22n
MM9 1 CLK 4 4 PMOS w=66n l=22n
MM10 3 CLK 2 2 NMOS w=22n l=22n
MM11 3 CLKnot 2 2 PMOS w=66n l=22n
MM12 Q 3 gnd! gnd! NMOS w=22n l=22n
MM13 Q 3 vdd! vdd! PMOS w=66n l=22n
MM14 5 Q gnd! gnd! NMOS w=22n l=22n
MM15 5 Q vdd! vdd! PMOS w=66n l=22n
MM16 3 CLKnot 5 5 NMOS w=22n l=22n
MM17 3 CLK 5 5 PMOS w=66n l=22n
.ENDS


* SUB Circuit
.SUBCKT AND A B outC
MM0 1 B vdd! vdd! PMOS w=66n l=22n
MM2 C A 1 1 PMOS w=66n l=22n
MM1 C B gnd! gnd! NMOS w=22n l=22n
MM3 C A gnd! gnd! NMOS w=22n l=22n
MM4 Anot A gnd! gnd! NMOS w=22n l=22n
MM5 Anot A vdd! vdd! PMOS w=66n l=22n
MM6 outC C gnd! gnd! NMOS w=22n l=22n
MM7 outC C vdd! vdd! PMOS w=66n l=22n
.ENDS


* SUB Circuit
.SUBCKT XOR A B C

MM0 Anot A gnd! gnd! NMOS w=22n l=22n
MM1 Anot A vdd! vdd! PMOS w=66n l=22n
MM2 Bnot B gnd! gnd! NMOS w=22n l=22n
MM3 Bnot B vdd! vdd! PMOS w=66n l=22n
MM5 4 A vdd! vdd! PMOS w=66n l=22n
MM6 4 B vdd! vdd! PMOS w=66n l=22n
MM7 C Anot 4 4 PMOS w=66n l=22n
MM8 C Bnot 4 4 PMOS w=66n l=22n
MM9 C A 3 3 NMOS w=22n l=22n
MM10 3 B gnd! gnd! NMOS w=22n l=22n
MM11 C Anot 1 1 NMOS w=22n l=22n
MM12 1 Bnot gnd! gnd! NMOS w=22n l=22n

.ENDS


* SUB Circuit
.SUBCKT Inverter A B
MM0 B A gnd! gnd! NMOS w=22n l=22n
MM1 B A vdd! vdd! PMOS w=66n l=22n
.ENDS

* Circuit
XAND0 R QQ1 Q1 AND
XAND1 R QQ2 Q2 AND
XAND2 R QQ3 Q3 AND
XFF0 CLK Q1 QQ2 FF
XFF1 CLK Q2 QQ3 FF
XFF2 CLK Q3 QQ4 FF
XXOR QQ2 QQ4 QQ1 XOR


XXOR5 X2 X1 S XOR

* Test vector
Vvdd vdd! 0 0.8v
Vgnd gnd! 0 0v
V1 X1 0 0.8V
V2 X2 0 0V

* Analyse
 
Vp CLK 0 PULSE (0V 0.8V 5us 0.5us 0.5us 5us 10us)
Vin R 0 PULSE 0V 0.8 18us 0.5us 0.05us 1ms 2ms


.tr 0.05ms 0.5ms
 
.PROBE TRAN [Q2]

.END