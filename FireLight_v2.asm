;*****************************************************
;Company :
;File Name : FireLight.asm
;Author :
;Create Data : 2015-12-16
;Last Modified : 2015-12-16
;Description :
;Version : 2.0
;*****************************************************

LIST P=69P48
ROMSIZE=4096

;*****************************************************
;ϵͳ�Ĵ��� ($000 ~ $02F, $380 ~ $38C)
;*****************************************************
IE		EQU	00H		;�ж�ʹ��/���ܿ���
IRQ		EQU	01H		;�ж������־

TM0		EQU	02H		;Timer0 ģʽ�Ĵ���
TM1		EQU	03H		;Timer1 ģʽ�Ĵ���

TL0		EQU	04H		;Timer0 ����ֵ��4λ
TH0		EQU	05H		;Timer0 ����ֵ��4λ

TL1		EQU	06H		;Timer1 ����ֵ��4λ
TH1		EQU	07H		;Timer1 ����ֵ��4λ

PORTA		EQU	08H		;PortA ���ݼĴ���
PORTB		EQU	09H		;PortB ���ݼĴ���
PORTC		EQU	0AH		;PortC ���ݼĴ���
PORTD		EQU	0BH		;PortD ���ݼĴ���
PORTE		EQU	0CH		;PortE ���ݼĴ���

					;0DH Reserved
				
TBR		EQU	0EH		;����Ĵ���
INX		EQU	0FH		;���Ѱַα�����Ĵ���
DPL		EQU	10H		;INX����ָ���4λ
DPM		EQU	11H		;INX����ָ����4λ
DPH		EQU	12H		;INX����ָ���4λ

TCTL1		EQU	13H		;Timer1 ���ƼĴ���

ADCCTL		EQU	14H		;ADC ʹ����ο���ѹ
ADCCFG		EQU	15H		;ADC configuration
ADCPORT		EQU	16H		;ADC PORT CONFIGURATION
ADCCHN		EQU	17H		;ADC channel selection

PACR		EQU	18H		;PortA ���ƼĴ���
PBCR		EQU	19H		;PortB ���ƼĴ���
PCCR		EQU	1AH		;PortC ���ƼĴ���
PDCR		EQU	1BH		;PortD ���ƼĴ���
PECR		EQU	1CH		;PortE ���ƼĴ���

					;1DH Reserved
					
WDT		EQU	1EH		;Whichdog timer control
					

PWMC0		EQU	20H		;PWM0 ���ƼĴ���
PWMC1		EQU	21H		;PWM1 ���ƼĴ���

PWMP00		EQU	22H		;PWM0 ���ڿ��ƼĴ�����4λ
PWMP01		EQU	23H		;PWM0 ���ڿ��ƼĴ�����4λ

PWMD00		EQU	24H		;PWM0 ռ�ձȿ��ƼĴ�����2λ
PWMD01		EQU	25H		;PWM0 ռ�ձȿ��ƼĴ�����4λ
PWMD02		EQU	26H		;PWM0 ռ�ձȿ��ƼĴ�����4λ

PWMP10		EQU	27H		;PWM1 ���ڿ��ƼĴ�����4λ
PWMP11		EQU	28H		;PWM1 ���ڿ��ƼĴ�����4λ

PWMD10		EQU	29H		;PWM1 ռ�ձȿ��ƼĴ�����2λ
PWMD11		EQU	2AH		;PWM1 ռ�ձȿ��ƼĴ�����4λ
PWMD12		EQU	2BH		;PWM1 ռ�ձȿ��ƼĴ�����4λ

					;2CH Reserved
					
AD_RET0		EQU	2DH		;ADC ת�������2λ
AD_RET1		EQU	2EH		;ADC ת�������4λ
AD_RET2		EQU	2FH		;ADC ת�������4λ


PPACR 		EQU 	388H		;PORTA ������������ƼĴ��� 
PPBCR 		EQU 	389H		;PORTB ������������ƼĴ��� 
PPCCR 		EQU 	38AH		;PORTC ������������ƼĴ��� 
PPDCR 		EQU 	38BH		;PORTD ������������ƼĴ��� 
PPECR 		EQU 	38CH		;PORTE ������������ƼĴ��� 


;*****************************************************
;�û��Զ���Ĵ��� ($030 ~ $0EF)
;*****************************************************
;Bank0
;------------------------------------------------------------------
AC_BAK 		EQU 	30H 		;AC ֵ���ݼĴ���

SYSTEM_STATE	EQU	31H		;bit 0:  0 - ����״̬(����Դ����),  1 - Ӧ��״̬(����Դͣ��)

SELF_STATE	EQU	32H		;bit 0:  0 - ����״̬(����Դ����),  1 - ģ��Ӧ��״̬(ģ������Դͣ��)
					;bit 1:  0 - ���¼�״̬,	         1 - �¼�״̬
					;bit 2:  0 - �����״̬,	         1 - ���״̬
					;bit 3:  0 - �Զ�ģʽ	         1 - �ֶ�ģʽ
					;ע��:�Զ�ģʽ��ָ��bit 0 - bit 2 ��Ϊʱ�����Ż���ͣ�絼��ϵͳ�������Ӧ״̬
					;�ֶ�ģʽ��ָ��bit 0 - bit 2 ��Ϊͨ��������ͬʱ���İ���������ϵͳ�������Ӧ״̬

ALREADY_ENTER	EQU	33H		;bit 0:  0 - ��ǰ��δ��ʼ���,      1 - ��ǰ�Ѿ���ʼ���
					;bit 1:  0 - ��ǰ��δ��ʼ�ŵ�(Ӧ��),1 - ��ǰ�Ѿ���ʼ�ŵ�(Ӧ��)
					;bit 2:  0 - ��ǰ��δ�����ֶ��¼�,  1 - ��ǰ�Ѿ������ֶ��¼�״̬
					;bit 3:  0 - ��ǰ��δ�����ֶ����,  1 - ��ǰ�Ѿ������ֶ����״̬
				
; ����TIMER ��ʱ
F_496MS_1S	EQU	35H		;bit0 = 1, 496ms �������������ʹ��
					;bit1 = 1, 1s �������ڼ�ʱӦ��ʱ��
					
F_TIME 		EQU 	36H 		;bit0 = 1, 1�뵽; 
					;bit1 = 1, 1�µ�; 
					;bit2 = 1, 1�굽; 
					;bit3 = 1, 1���ӵ���

CNT0_8MS 	EQU 	37H	 	;CNT1_8MS, CNT0_8MS��ɵ�8BIT���ݴﵽ125ʱ����Timer0����125���жϺ󣬱�ʾ1S��ʱ�ѵ�
CNT1_8MS 	EQU 	38H 		;���ԣ���ʼ��CNT1_8MS=07H, CNT0_8MS=0DH

SEC_CNT0	EQU	39H		;SEC_CNT0/1/2 ����Ϊ��λ��ʱ
SEC_CNT1	EQU	3AH		;����ֵ�ﵽ1Сʱ����3600(E10H)��ʱ����HOUR_CNT0/1��λ���������㡣
SEC_CNT2	EQU	3BH

HOUR_CNT0	EQU	3CH		;HOUR_CNT0/1 ��СʱΪ��λ��ʱ
HOUR_CNT1	EQU	3DH		;����ֵ�ﵽ1��ʱ����744(2EBH)Сʱʱ����MONTH_CNT0/1��λ��ͬʱ��F_TIME.1���������㡣
HOUR_CNT2	EQU	3EH		

MONTH_CNT	EQU	3FH		;MONTH_CNT0/1 ����Ϊ��λ��ʱ
					;����ֵ�ﵽ1��ʱ����12(0CH)��ʱ����ͬʱ��F_TIME.2���������㡣

TEMP_SUM_CY	EQU	40H		;AD�ӳ��������ʱ����
FLAG_OCCUPIED	EQU	41H		;bit0/1/2/3 = 1ʱ�ֱ��ʾCHN0��1��6��7��ת�����(CHN0_FINAL_RET1��)����ǰ̨ʹ��,
					;��ʱADC�жϲ����޸���Щ���ݡ�	

FLAG_TYPE	EQU	42H		;bit0 = 1��ʾ�Ѿ���ɵƾ�����ѡ��(PORTB.3/AN7),��λΪ1������Ҫ��AN7����AD����


CMP_MIN_PWR0	EQU	43H		;�ϵ��Լ�ʱ���ƾߵ�Դ��С��ѹֵ.(1.396V -> 0x23B ->(�������2λ) 0x8E)
CMP_MIN_PWR1	EQU	44H		;

CMP_TYPE00	EQU	45H		;�ƾ���������0
CMP_TYPE01	EQU	46H		;

CMP_TYPE10	EQU	47H		;�ƾ���������1
CMP_TYPE11	EQU	48H		;

CMP_TYPE20	EQU	49H		;�ƾ���������2
CMP_TYPE21	EQU	4AH		;

LIGHT_TYPE	EQU	4BH		;�ƾ�����
					;bit0 = 1, ﮵�أ�������
					;bit1 = 1, ﮵�أ�������
					;bit2 = 1, ���ӵ�أ�������
					;bit3 = 1, ���ӵ�أ�������

CMP_SUPPLY0	EQU	4CH		;��⵽��Դ��ѹС�ڴ���ֵʱ����ʼӦ���ŵ�.(1.115V -> 0x72)
CMP_SUPPLY1	EQU	4DH

DURATION_EMER	EQU	4EH		;bit0 = 1, Ӧ��ʱ��С��5����
					;bit1 = 1, Ӧ��ʱ������5���ӣ�С��30����
					;bit2 = 1, Ӧ��ʱ������30����
					
CNT0_EMERGENCY	EQU	4FH		;��Ӧ��ʱ����ʱ����λs
CNT1_EMERGENCY	EQU	50H
CNT2_EMERGENCY	EQU	51H

CMP_EXIT_EMER0	EQU	52H		;��⵽��ص�ѹС�ڴ���ֵʱ(0.96V -> 0x62)��Ӧ�ùر�Ӧ���ŵ繦��
CMP_EXIT_EMER1	EQU	53H

CMP_BAT_OPEN0	EQU	54H		;��⵽��ص�ѹ���ڴ���ֵʱ(1.56V -> 0x9F)����Ϊ��س���·��·
CMP_BAT_OPEN1	EQU	55H

CMP_BAT_FULL0	EQU	56H		;��⵽��ص�ѹ���ڴ���ֵʱ(1.44V -> 0x93)����Ϊ����ѳ���
CMP_BAT_FULL1	EQU	57H

CMP_BAT_CHARGE0	EQU	58H		;��⵽��ص�ѹС�ڴ���ֵʱ(1.35V -> 0x8A)����Ϊ��صÿ�ʼ�����
CMP_BAT_CHARGE1	EQU	59H



BAT_STATE	EQU	58H		;bit0 = 0, ��ʾ����·δ��·��bit0 = 1, ��ʾ����·��·
					;bit1 = 0, ��ʾ���δ������bit1 = 1, ��ʾ����ѳ���
					;bit2 = 0, ��ʾ��ػ�����Ҫ��磻bit2 = 1, ��ʾ�����Ҫ���
					;bit3 = 1, ��ʾ��ص�ѹ���ͣ������ټ���Ӧ���ŵ���


CMP_LIGHT0	EQU	59H		;����Դ���ʹ��,ADת�����С�ڴ���ֵʱ(0.2V -> 0x14)����ʾ��Դ��������
CMP_LIGHT1	EQU	5AH

LIGHT_STATE	EQU	5BH		;bit0 = 1, ��ʾ��Դ����


ALARM_STATE	EQU	5CH		;bit0 = 1, ��ʾ��ع���(��·���·)
					;bit1 = 1, ��ʾ��Դ����(��·���·)
					;bit2 = 1, ��ʾ�Լ�ŵ�ʱ�䲻��


CNT_LED_YELLOW	EQU	5FH		;������������ת�Ƶ����ʹ�ã���ʱ��λΪ168MS


FLAG_SIMU_EMER	EQU	60H		;bit0 = 1, ��ʾ��"ģ��ͣ��"״̬���Ѿ���Ӧ������
					;bit1 = 1��ʾ1s�ѵ�

CNT0_1MINUTE	EQU	61H		;ÿ1���1��ֱ����ʱ��1����Ϊֹ
CNT1_1MINUTE	EQU	62H


CNT0_CHARGE	EQU	63H		;��Ӧ���೤ʱ�䣬��ʼֵΪ20Сʱ����20 * 60 =1200����(0x4B0)
CNT1_CHARGE	EQU	64H
CNT2_CHARGE	EQU	65H

GREEN_FLASH	EQU	66H		;�����ֶ��¼���ֶ����ʱ��LED��˸
					;BIT1 = 1, ����ʱ��������3�룬�̵ƿ�ʼ��1HZ��Ƶ����˸
					;BIT2 = 1, ����ʱ��������5�룬�̵ƿ�ʼ��3HZ��Ƶ����˸


CNT_LED_GREEN	EQU	67H		;����ɫLED��ת��

;������ؼĴ���
DELAY_TIMER2	EQU	71H		;��ʱ�ӳ���ʹ��
DELAY_TIMER1	EQU	72H		;��ʱ�ӳ���ʹ��
DELAY_TIMER0	EQU	73H		;��ʱ�ӳ���ʹ��
CLEAR_AC 	EQU 	74H 		;����ۼ���A ֵ�üĴ���
TEMP 		EQU 	75H 		;��ʱ�Ĵ���

CNT0_496MS	EQU	76H		;���ڶ�ʱ496MS
CNT1_496MS	EQU	77H

BTN_PRE_STA	EQU	78H		;bit0������һ�ΰ���״̬,0:����,1:δ����
BTN_PRESS_CNT	EQU	79H		;��������ʱ������λΪ496ms


;led
CNT0_168MS	EQU	7AH		;���ڶ�ʱ168MS,����תLED��
CNT1_168MS	EQU	7BH

F_168MS		EQU	7CH		;ÿ168ms��bit0 = 1

CMP_RESUME0	EQU	7DH		;��⵽��Դ��ѹ���ڴ���ֵʱ����ʾ�е繩���ѻָ���Ӧ�ر�Ӧ��.(1.396V -> 0x8E)
CMP_RESUME1	EQU	7EH

PRESS_DURATION	EQU	7FH		;���������³���ʱ����־
					;bit0 = 1;  ������ʱ��С��3��
					;bit1 = 1;  ������ʱ������3�룬С��5��
					;bit2 = 1;  ������ʱ������5�룬С��7��
					;bit3 = 1;  ������ʱ������7��

;Bank1(���¼Ĵ�����ʵ��ַӦ����80H)
;------------------------------------------------------------------
CHN0_RET0_BAK0	EQU	00H		;ADC CHN0 ת�������2λ����
CHN0_RET1_BAK0	EQU	01H		;ADC CHN0 ת�������4λ����
CHN0_RET2_BAK0	EQU	02H		;ADC CHN0 ת�������4λ����

CHN0_RET0_BAK1	EQU	03H		;ADC CHN0 ת�������2λ����
CHN0_RET1_BAK1	EQU	04H		;ADC CHN0 ת�������4λ����
CHN0_RET2_BAK1	EQU	05H		;ADC CHN0 ת�������4λ����

CHN0_RET0_BAK2	EQU	06H		;ADC CHN0 ת�������2λ����
CHN0_RET1_BAK2	EQU	07H		;ADC CHN0 ת�������4λ����
CHN0_RET2_BAK2	EQU	08H		;ADC CHN0 ת�������4λ����

CHN0_RET0_BAK3	EQU	09H		;ADC CHN0 ת�������2λ����
CHN0_RET1_BAK3	EQU	0AH		;ADC CHN0 ת�������4λ����
CHN0_RET2_BAK3	EQU	0BH		;ADC CHN0 ת�������4λ����

CHN0_FINAL_RET0	EQU	0CH		;ͨ��0ƽ����Ľ��
CHN0_FINAL_RET1	EQU	0DH		;
CHN0_FINAL_RET2	EQU	0EH

DET0_CT		EQU	0FH		;ADC ͨ��0 ת���������

;------------------------------------------------------------------
CHN1_RET0_BAK0	EQU	10H		;ADC CHN1 ת�������2λ����
CHN1_RET1_BAK0	EQU	11H		;ADC CHN1 ת�������4λ����
CHN1_RET2_BAK0	EQU	12H		;ADC CHN1 ת�������4λ����

CHN1_RET0_BAK1	EQU	13H		;ADC CHN1 ת�������2λ����
CHN1_RET1_BAK1	EQU	14H		;ADC CHN1 ת�������4λ����
CHN1_RET2_BAK1	EQU	15H		;ADC CHN1 ת�������4λ����

CHN1_RET0_BAK2	EQU	16H		;ADC CHN1 ת�������2λ����
CHN1_RET1_BAK2	EQU	17H		;ADC CHN1 ת�������4λ����
CHN1_RET2_BAK2	EQU	18H		;ADC CHN1 ת�������4λ����

CHN1_RET0_BAK3	EQU	19H		;ADC CHN1 ת�������2λ����
CHN1_RET1_BAK3	EQU	1AH		;ADC CHN1 ת�������4λ����
CHN1_RET2_BAK3	EQU	1BH		;ADC CHN1 ת�������4λ����

CHN1_FINAL_RET0	EQU	1CH		;ͨ��1ƽ����Ľ��
CHN1_FINAL_RET1	EQU	1DH		;
CHN1_FINAL_RET2	EQU	1EH		;

DET1_CT		EQU	1FH		;ADC ͨ��1 ת���������

;------------------------------------------------------------------
CHN6_RET0_BAK0	EQU	20H		;ADC CHN6 ת�������2λ����
CHN6_RET1_BAK0	EQU	21H		;ADC CHN6 ת�������4λ����
CHN6_RET2_BAK0	EQU	22H		;ADC CHN6 ת�������4λ����

CHN6_RET0_BAK1	EQU	23H		;ADC CHN6 ת�������2λ����
CHN6_RET1_BAK1	EQU	24H		;ADC CHN6 ת�������4λ����
CHN6_RET2_BAK1	EQU	25H		;ADC CHN6 ת�������4λ����

CHN6_RET0_BAK2	EQU	26H		;ADC CHN6 ת�������2λ����
CHN6_RET1_BAK2	EQU	27H		;ADC CHN6 ת�������4λ����
CHN6_RET2_BAK2	EQU	28H		;ADC CHN6 ת�������4λ����

CHN6_RET0_BAK3	EQU	29H		;ADC CHN6 ת�������2λ����
CHN6_RET1_BAK3	EQU	2AH		;ADC CHN6 ת�������4λ����
CHN6_RET2_BAK3	EQU	2BH		;ADC CHN6 ת�������4λ����

CHN6_FINAL_RET0	EQU	2CH		;ͨ��6ƽ����Ľ��
CHN6_FINAL_RET1	EQU	2DH		;
CHN6_FINAL_RET2	EQU	2EH

DET6_CT		EQU	2FH		;ADC ͨ��6 ת���������

;------------------------------------------------------------------
CHN7_RET0_BAK0	EQU	30H		;ADC CHN7 ת�������2λ����
CHN7_RET1_BAK0	EQU	31H		;ADC CHN7 ת�������4λ����
CHN7_RET2_BAK0	EQU	32H		;ADC CHN7 ת�������4λ����

CHN7_RET0_BAK1	EQU	33H		;ADC CHN7 ת�������2λ����
CHN7_RET1_BAK1	EQU	34H		;ADC CHN7 ת�������4λ����
CHN7_RET2_BAK1	EQU	35H		;ADC CHN7 ת�������4λ����

CHN7_RET0_BAK2	EQU	36H		;ADC CHN7 ת�������2λ����
CHN7_RET1_BAK2	EQU	37H		;ADC CHN7 ת�������4λ����
CHN7_RET2_BAK2	EQU	38H		;ADC CHN7 ת�������4λ����

CHN7_RET0_BAK3	EQU	39H		;ADC CHN7 ת�������2λ����
CHN7_RET1_BAK3	EQU	3AH		;ADC CHN7 ת�������4λ����
CHN7_RET2_BAK3	EQU	3BH		;ADC CHN7 ת�������4λ����

CHN7_FINAL_RET0	EQU	3CH		;ͨ��7ƽ����Ľ��
CHN7_FINAL_RET1	EQU	3DH		;
CHN7_FINAL_RET2	EQU	3EH		;

DET7_CT		EQU	3FH		;ADC ͨ��7 ת���������


;*****************************************************
;����
;*****************************************************
	ORG	0000H

	;�ж�������
	JMP	RESET			;RESET ISP
	JMP	ADC_ISP			;ADC INTERRUPT ISP
	JMP	TIMER0_ISP		;TIMER0 ISP
	RTNI				;TIMER1 ISP
	RTNI				;PORTB/D ISP


;*****************************************************
;Timer0 �жϷ������
;Timer0������Ϊÿ8ms����һ���ж�
;
;*****************************************************
TIMER0_ISP:
	STA 	AC_BAK,		00H 	;����AC ֵ
	ANDIM 	IRQ,		1011B 	;��TIMER0 �ж������־

J_168MS:
	SBIM	CNT0_168MS,	01H
	LDI	TBR,		00H
	SBCM	CNT1_168MS
	BC	J_496MS

	LDI	CNT0_168MS,	04H	;8ms * 21 = 168ms
	LDI	CNT1_168MS,	01H

	ORIM	F_168MS,	0001B	;���� "168ms ��"��־����תLED��

J_496MS:
	SBIM 	CNT0_496MS,	01H	;ÿ��Timer0�жϲ����󣬽�CNT0_496MS��1
	LDI	TBR,		00H	;���ۼ���A ��0
	SBCM	CNT1_496MS		;ÿ��CNT0-1������λʱ����CNT1_496MS��1
	BC	J_1S			;���δ������λ�����ʾ496MS��δ����

	LDI 	CNT0_496MS,	0DH 	;����496ms ������,496 = 8 * 62
	LDI 	CNT1_496MS,	03H 	;����496ms ������
	
	ORIM 	F_496MS_1S,	0001B 	;���� "496ms ��"��־
	
J_1S:	
	SBIM 	CNT0_8MS,	01H	;ÿ��Timer0�жϲ����󣬽�CNT0_8MS��1
	LDI	TBR,		00H
	SBCM	CNT1_8MS		;ÿ��CNT0_8MS-1������λʱ����CNT1_8MS��1
	BC	TIMER0_ISP_END
	
	LDI 	CNT0_8MS,	0CH 	;����1s ������ 1S = 125 * 8 MS
	LDI 	CNT1_8MS,	07H 	;����1s ������
	
	ORIM 	F_TIME,		0001B 	;���� "1s ��"��־
	ORIM	F_496MS_1S,	0010B	;ΪӦ�������ṩ "1s ��"��־
	ORIM	FLAG_SIMU_EMER,	0010B	;Ϊ�ֶ��Լ��ṩ "1s ��"��־

J_MINUTE:
	SBIM	CNT0_1MINUTE,	01H
	LDI	TBR,		00H
	SBCM	CNT1_1MINUTE
	BC	J_HOUR			;��ΪJ_HOUR������Ϊ��λ�ۼӣ�����Ӧ����J_HOUR

	LDI	CNT0_1MINUTE,	0BH	;0x3c * 1s = 60s
	LDI	CNT1_1MINUTE,	03H

	ORIM	F_TIME,		1000B	;���� "1���� ��"��־	

J_HOUR:
	SBIM	SEC_CNT0,	01H	;SEC_CNT0 ÿ���1
	LDI	TBR,		00H
	SBCM	SEC_CNT1		;ÿ��SEC_CNT0-1������λʱ����SEC_CNT1��1
	LDI	TBR,		00H
	SBCM	SEC_CNT2		;ÿ��SEC_CNT1-1������λʱ����SEC_CNT2��1
	BC	TIMER0_ISP_END		;SEC_CNT2��1������λʱ�����ʾ1Сʱ��ʱ�ѵ�
	
	LDI 	SEC_CNT0,	0FH 	;����SEC_CNT0/1/2 ΪE10H-1(3600-1)
	LDI 	SEC_CNT1,	00H
	LDI 	SEC_CNT2,	0EH
	
J_MONTH:	
	SBIM 	HOUR_CNT0,	01H	;HOUR_CNT0 ÿСʱ��1
	LDI	TBR,		00H
	SBCM	HOUR_CNT1		;ÿ�� HOUR_CNT0 ������λʱ���� HOUR_CNT1 ��1
	BC	TIMER0_ISP_END		;HOUR_CNT1 ��1������λʱ�����ʾ1�¼�ʱ�ѵ�
	
	LDI 	HOUR_CNT0,	07H 	;����HOUR_CNT0/1/2 Ϊ2E8H-1(744-1)
	LDI 	HOUR_CNT1,	0EH
	LDI	HOUR_CNT2,	02H
	
	ORIM 	F_TIME,		0010B 	;���� "1�µ�" ��־
	
J_YEAR:	
	SBIM 	MONTH_CNT,	01H	;MONTH_CNT ÿ�¼�1
	BC 	TIMER0_ISP_END		;MONTH_CNT ��1������λʱ�����ʾ1���ʱ�ѵ�
	
	LDI 	MONTH_CNT,	0BH 	;����MONTH_CNT Ϊ0CH-1(12-1)
	
	ORIM 	F_TIME,		0100B 	;���� "1�굽" ��־

TIMER0_ISP_END:
	LDI 	IE,		1100B 	;��ADC,Timer0 �ж�
	LDA 	AC_BAK,		00H 	;�ָ�AC ֵ
	RTNI


;*****************************************************
;ADC �жϷ������
;*****************************************************	
ADC_ISP:
	STA 	AC_BAK,		00H 	;����AC ֵ
	ANDIM 	IRQ,		0111B 	;��ADC �ж������־

	LDA	ADCCHN			
	BAZ	CHN0_VOL_1		;�˴�Ϊͨ��0 ת�����
	SBI	ADCCHN,		01H
	BAZ	CHN1_VOL_1		;�˴�Ϊͨ��1 ת�����	
	SBI	ADCCHN,		06H
	BAZ	CHN6_VOL_1		;�˴�Ϊͨ��6 ת�����
	SBI	ADCCHN,		07H
	BAZ	CHN7_VOL_1		;�˴�Ϊͨ��7 ת�����
	JMP	ADC_ISP_END		;��������²�Ӧִ�д����

;----------------------------------------------------------------	

;ת��ͨ��0 ת�����
;----------------------------------------------------------------
CHN0_VOL_1:
	LDI	TBR,		01H	;������һ
	ADDM	DET0_CT,	01H	

	LDI	TBR,		04H	;DET0_CT - 4 -> A
	SUB	DET0_CT,	01H
	BAZ 	CHN0_VOL_14		;��4��ת�����

	LDI	TBR,		03H	;DET0_CT - 3 -> A
	SUB	DET0_CT,	01H
	BAZ 	CHN0_VOL_13		;��3��ת�����

	LDI	TBR,		02H	;DET0_CT - 2 -> A
	SUB	DET0_CT,	01H
	BAZ 	CHN0_VOL_12		;��2��ת�����

CHN0_VOL_11:
	LDA 	AD_RET0,	00H 	;�����һ��A/D ת�����
	STA 	CHN0_RET0_BAK0,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN0_RET1_BAK0,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN0_RET2_BAK0,	01H
	JMP 	NEXT_CHN	

CHN0_VOL_12:
	LDA 	AD_RET0,	00H 	;����ڶ���A/D ת�����
	STA 	CHN0_RET0_BAK1,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN0_RET1_BAK1,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN0_RET2_BAK1,	01H
	JMP 	NEXT_CHN
	
CHN0_VOL_13:
	LDA 	AD_RET0,	00H 	;���������A/D ת�����
	STA 	CHN0_RET0_BAK2,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN0_RET1_BAK2,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN0_RET2_BAK2,	01H
	JMP 	NEXT_CHN	
	
CHN0_VOL_14:
	LDA 	AD_RET0,	00H 	;������Ĵ�A/D ת�����
	STA 	CHN0_RET0_BAK3,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN0_RET1_BAK3,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN0_RET2_BAK3,	01H

	LDI	TBR,		00H	;DET0_CT ��0
	STA	DET0_CT,	01H
	
	CALL	CAL_CHN0_ADCDATA
	
	JMP 	NEXT_CHN	
;----------------------------------------------------------------	

;ת��ͨ��1 ת�����
;----------------------------------------------------------------
CHN1_VOL_1:
	LDI	TBR,		01H	;������һ
	ADDM	DET1_CT,	01H	

	LDI	TBR,		04H	;DET1_CT - 4 -> A
	SUB	DET1_CT,	01H
	BAZ 	CHN1_VOL_14		;��4��ת�����

	LDI	TBR,		03H	;DET1_CT - 3 -> A
	SUB	DET1_CT,	01H
	BAZ 	CHN1_VOL_13		;��3��ת�����

	LDI	TBR,		02H	;DET1_CT - 2 -> A
	SUB	DET1_CT,	01H
	BAZ 	CHN1_VOL_12		;��2��ת�����

CHN1_VOL_11:
	LDA 	AD_RET0,	00H 	;�����һ��A/D ת�����
	STA 	CHN1_RET0_BAK0,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN1_RET1_BAK0,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN1_RET2_BAK0,	01H
	JMP 	NEXT_CHN	

CHN1_VOL_12:
	LDA 	AD_RET0,	00H 	;����ڶ���A/D ת�����
	STA 	CHN1_RET0_BAK1,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN1_RET1_BAK1,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN1_RET2_BAK1,	01H
	JMP 	NEXT_CHN

CHN1_VOL_13:
	LDA 	AD_RET0,	00H 	;���������A/D ת�����
	STA 	CHN1_RET0_BAK2,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN1_RET1_BAK2,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN1_RET2_BAK2,	01H
	JMP 	NEXT_CHN	

CHN1_VOL_14:
	LDA 	AD_RET0,	00H 	;������Ĵ�A/D ת�����
	STA 	CHN1_RET0_BAK3,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN1_RET1_BAK3,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN1_RET2_BAK3,	01H

	LDI	TBR,		00H	;DET1_CT ��0
	STA	DET1_CT,	01H
	
	CALL	CAL_CHN1_ADCDATA
	
	JMP 	NEXT_CHN	
;----------------------------------------------------------------	

;ת��ͨ��6 ת�����
;----------------------------------------------------------------
CHN6_VOL_1:
	LDI	TBR,		01H	;������һ
	ADDM	DET6_CT,	01H	

	LDI	TBR,		04H	;DET6_CT - 4 -> A
	SUB	DET6_CT,	01H
	BAZ 	CHN6_VOL_14		;��4��ת�����

	LDI	TBR,		03H	;DET6_CT - 3 -> A
	SUB	DET6_CT,	01H
	BAZ 	CHN6_VOL_13		;��3��ת�����

	LDI	TBR,		02H	;DET6_CT - 2 -> A
	SUB	DET6_CT,	01H
	BAZ 	CHN6_VOL_12		;��2��ת�����

CHN6_VOL_11:
	LDA 	AD_RET0,	00H 	;�����һ��A/D ת�����
	STA 	CHN6_RET0_BAK0,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN6_RET1_BAK0,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN6_RET2_BAK0,	01H
	JMP 	NEXT_CHN	

CHN6_VOL_12:
	LDA 	AD_RET0,	00H 	;����ڶ���A/D ת�����
	STA 	CHN6_RET0_BAK1,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN6_RET1_BAK1,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN6_RET2_BAK1,	01H
	JMP 	NEXT_CHN
	
CHN6_VOL_13:
	LDA 	AD_RET0,	00H 	;���������A/D ת�����
	STA 	CHN6_RET0_BAK2,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN6_RET1_BAK2,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN6_RET2_BAK2,	01H
	JMP 	NEXT_CHN	
	
CHN6_VOL_14:
	LDA 	AD_RET0,	00H 	;������Ĵ�A/D ת�����
	STA 	CHN6_RET0_BAK3,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN6_RET1_BAK3,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN6_RET2_BAK3,	01H

	LDI	TBR,		00H	;DET6_CT ��0
	STA	DET6_CT,	01H
	
	CALL	CAL_CHN6_ADCDATA
	
	JMP 	NEXT_CHN	
;----------------------------------------------------------------	

;ת��ͨ��7 ת�����
;----------------------------------------------------------------
CHN7_VOL_1:
	LDI	TBR,		01H	;������һ
	ADDM	DET7_CT,	01H	

	LDI	TBR,		04H	;DET7_CT - 4 -> A
	SUB	DET7_CT,	01H
	BAZ 	CHN7_VOL_14		;��4��ת�����

	LDI	TBR,		03H	;DET7_CT - 3 -> A
	SUB	DET7_CT,	01H
	BAZ 	CHN7_VOL_13		;��3��ת�����

	LDI	TBR,		02H	;DET7_CT - 2 -> A
	SUB	DET7_CT,	01H
	BAZ 	CHN7_VOL_12		;��2��ת�����

CHN7_VOL_11:
	LDA 	AD_RET0,	00H 	;�����һ��A/D ת�����
	STA 	CHN7_RET0_BAK0,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN7_RET1_BAK0,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN7_RET2_BAK0,	01H
	JMP 	NEXT_CHN	

CHN7_VOL_12:
	LDA 	AD_RET0,	00H 	;����ڶ���A/D ת�����
	STA 	CHN7_RET0_BAK1,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN7_RET1_BAK1,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN7_RET2_BAK1,	01H
	JMP 	NEXT_CHN
	
CHN7_VOL_13:
	LDA 	AD_RET0,	00H 	;���������A/D ת�����
	STA 	CHN7_RET0_BAK2,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN7_RET1_BAK2,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN7_RET2_BAK2,	01H
	JMP 	NEXT_CHN	
	
CHN7_VOL_14:
	LDA 	AD_RET0,	00H 	;������Ĵ�A/D ת�����
	STA 	CHN7_RET0_BAK3,	01H
	LDA 	AD_RET1,	00H
	STA 	CHN7_RET1_BAK3,	01H
	LDA 	AD_RET2,	00H
	STA 	CHN7_RET2_BAK3,	01H

	LDI	TBR,		00H	;DET7_CT ��0
	STA	DET7_CT,	01H
	
	CALL	CAL_CHN7_ADCDATA
	
	JMP 	NEXT_CHN	
;----------------------------------------------------------------
	
;----------------------------------------------------------------	
NEXT_CHN:
	LDA	ADCCHN
	BAZ	NEXT_CHN1
	SBI	ADCCHN,		01H
	BAZ	NEXT_CHN6
	SBI	ADCCHN,		06H
	BAZ	NEXT_CHN7
	SBI	ADCCHN,		07H
	BAZ	NEXT_CHN0
	
	JMP 	ADC_ISP_END		;������ִ����һ��

NEXT_CHN0:
	LDI	ADCCHN,		00H	;�趨ΪCHN0
	JMP 	ADC_ISP_END

NEXT_CHN1:
	LDI	ADCCHN,		01H	;�趨ΪCHN1
	JMP 	ADC_ISP_END
	
NEXT_CHN6:
	LDI 	ADCCHN,		06H 	;�趨ΪCHN6
	JMP	ADC_ISP_END

NEXT_CHN7:
	LDA	FLAG_TYPE
	BA0	NEXT_CHN0		;��FLAG_TYPE��bit0=1�����ʾ����ɵƾ�����ѡ�񣬴�ʱ������Ҫ��AN7���в�����
	
	LDI	ADCCHN,		07H	;�趨ΪCHN7
;----------------------------------------------------------------


ADC_ISP_END:
	ORIM 	ADCCFG,		1000B 	;����A/D ת��

	LDI 	IE,		1100B 	;��ADC,Timer0 �ж�
	LDA 	AC_BAK,		00H 	;ȡ��AC ֵ
	RTNI


;*****************************************************
; ������
;*****************************************************
RESET:
	NOP	
	LDI 	IE,		0000B	;�ر������ж�
 	NOP

	CALL	RESET_USER_DATA		;����û��Ĵ���
	CALL	REGISTER_INITIAL	;��ʼ��ϵͳ�Ĵ������û����ݼĴ���

	CALL	PRE_START_PWR_CHK	;�������Դ�Ƿ����������쳣��һֱ�ȴ���ֱ���ָ�
	CALL	PRE_START_TYPE_CHK	;�жϵƾߵĵ���������Դ����
	
	CALL	CHARGE_BAT_ENABLE	;�ϵ�󣬼���ʼ�Ե�ؽ��г��

MAIN_LOOP:
	;CALL	CHARGE_BAT_CTRL		;[������]  ��������Դ״̬�������ʱ��������Ƿ������־λ�Ƚ��е�س�����
	;CALL	EMERGENCY_CTRL		;[�ŵ����]  ����Դͣ����Ӧ���ŵ���ƣ��˳�Ӧ��״̬ʱ������˴�Ӧ���ŵ�ʱ��
	
	CALL	KEY_PROCESS		;[����ɨ��]  ����ɨ��
	CALL	SELF_CHK_STATE		;[�Լ�״̬]  ����ϵͳ����ʱ���밴��ʱ������"ͣ��"��"�¼�"��"���"��־λ
	CALL	SELF_CHK_PROCESS	;[ϵͳ�Լ�]  �����Լ��־λ�������Լ�

	CALL	BAT_STATE_CHK		;[���״̬]  �����״̬��������Ӧ��־λ
	CALL	LIGHT_STATE_CHK		;[��Դ״̬]  ��Դ״̬��⣬������Ӧ��־λ
	CALL	TIPS_PROCESS		;[������ʾ]  ����LED�������

	JMP	MAIN_LOOP

	
;*****************************************************
;���û��Ĵ���($030 ~ $0EF)
;*****************************************************
RESET_USER_DATA:

POWER_RESET:
	LDI 	DPL,		00H
	LDI 	DPM,		03H
	LDI 	DPH,		00H	;��$30 ��ʼ

POWER_RESET_1:
	LDI 	INX,		00H	;��DPH,DPM,DPL��ɵĵ�ַ��д0
	ADIM 	DPL,		01H
	LDI 	TBR,		00H	;���ۼ���A ��0
	ADCM 	DPM,		00H
	BA3 	POWER_RESET_2
	JMP 	POWER_RESET_3

POWER_RESET_2:
	ADIM 	DPH,		01H

POWER_RESET_3:
	SBI 	DPH,		01H	;��$EF ���������ڵ�ַ001 111 000Bʱֹͣ
	BNZ 	POWER_RESET_1
	SBI 	DPM,		07H
	BNZ 	POWER_RESET_1

RESET_USER_DATA_END:
	RTNI


;*****************************************************
;��ʼ��ϵͳ�Ĵ���
;*****************************************************
REGISTER_INITIAL:

	;TIMER0 ��ʼ��
	;
	;  fosc=4M, fsys=4M/4=1M
	;
	;  fsys=1M                 31250Hz                   125Hz
	;           -------------            -------------
	;  -------->| Prescaler |----------->|  Counter  |----------->
	;           -------------            -------------
	;               (32)                     (250)
	
	LDI 	TM0,		03H 	;����TIMER0 Ԥ��ƵΪ/32
	LDI 	TL0,		06H
	LDI 	TH0,		00H 	;�����ж�ʱ��Ϊ8ms

	LDI	CNT0_168MS,	04H	;��ʱ168ms
	LDI	CNT1_168MS,	01H	;

	LDI 	CNT0_8MS,	0DH 	;��ʱ1s
	LDI 	CNT1_8MS,	07H 	;��ʱ1s
	
	LDI	SEC_CNT0,	0FH	;SEC_CNT0/1/2 ��ʼ��ΪE10H - 1����3600 -1
	LDI	SEC_CNT1,	00H
	LDI	SEC_CNT2,	0EH

	LDI	HOUR_CNT0,	07H	;HOUR_CNT0/1/2 ��ʼ��Ϊ2E8H - 1����744 - 1
	LDI	HOUR_CNT1,	0EH
	LDI	HOUR_CNT2,	02H

	LDI	MONTH_CNT,	0BH	;MONTH_CNT ��ʼ��Ϊ12 -1 ����
		

	;I/O �ڳ�ʼ��
	LDI 	PORTA,		00H
	LDI 	PACR,		00H 	;����PortA ��Ϊ�����
	
	LDI 	PORTB,		00H
	LDI 	PBCR,		00H 	;����PortB ��Ϊ�����

	LDI	PORTC,		00H
	LDI	PCCR,		0FH	;����PortC.0/PortC.1/PortC.2/PortC.3 ��Ϊ���
	
	LDI 	PDCR,		1110B 	;����PD.0Ϊ���룬PD.3Ϊ���
	LDI	TBR,		0001B	;��PD.0 �ڲ���������
	STA	PPDCR

	LDI 	PORTE,		00H
	LDI 	PECR,		0FH 	;����PortE ��Ϊ�����

	;ADC��ʼ��
	;tosc = 1/4M = 0.25us, tAD = 8tosc = 2us, һ��A/D ת��ʱ�� = 204tAD = 408 us.
	LDI 	PACR,		0000B 	;����PortA0/1 ��Ϊ�����
	LDI 	PBCR,		0000B 	;����PortB2/3 ��Ϊ�����
	LDI 	ADCCTL,		0001B 	;ѡ���ڲ��ο���ѹVDD��ʹ��ADC
	LDI 	ADCCFG,		0100B 	;A/D ʱ��tAD=8tOSC, A/D ת��ʱ��= 204tAD
	LDI	ADCPORT,	1100B	;ʹ��AN0 ~ AN7
	LDI	ADCCHN,		00H	;ѡ��AN0
	ORIM 	ADCCFG,		1000B 	;����A/D ת��

	;PWM��ʼ��
	LDI	PWMC0,		0000B	;PWM0 Clock = tosc = 4M
	LDI	PWMP00,		0DH	;����Ϊ125��PWM0 Clock
	LDI	PWMP01,		07H	
	LDI	PWMD00,		00H	;��΢��
	LDI	PWMD01,		0EH	;ռ�ձ�Ϊ50%
	LDI	PWMD02,		03H	

	LDI	PWMC1,		0000B	;PWM0 Clock = tosc = 4M
	LDI	PWMP10,		0DH	;����Ϊ125��PWM0 Clock
	LDI	PWMP11,		07H	
	LDI	PWMD10,		00H	;��΢��
	LDI	PWMD11,		0EH	;ռ�ձ�Ϊ50%
	LDI	PWMD12,		03H


	;�������
	LDI	CNT0_496MS,	0DH	;��ʼ��496ms ������,496 = 8 * 62
	LDI	CNT0_496MS,	03H	;��ʼ��496ms ������
	LDI	BTN_PRE_STA,	01H	;��ʼ����һ��û�а���

	;״̬���
	LDI	SYSTEM_STATE,	00H	;��ʼ��Ϊ"����"

	;����ֵ
	LDI	CMP_MIN_PWR0,	07H	;��С�ϵ��ѹ(1.396V -> 0x8E)
	LDI	CMP_MIN_PWR1,	04H	

	LDI	CMP_SUPPLY0,	09H	;С�ڴ˵�ѹ������Ӧ������(1.115V -> 0x72)
	LDI	CMP_SUPPLY1,	03H

	LDI	CMP_RESUME0,	07H	;���ڴ˵�ѹ������Ӧ��ת������(1.396V -> 0x8E)
	LDI	CMP_RESUME1,	04H

	LDI	CMP_EXIT_EMER0,	01H	;��ص�ѹС�ڴ˵�ѹʱ���ر�Ӧ������(0.96V -> 0x62)
	LDI	CMP_EXIT_EMER1,	03H

	LDI	CMP_BAT_OPEN0,	0FH	;��ص�ѹ���ڴ˵�ѹʱ����Ϊ��س���·��·(1.56V -> 0x9F)
	LDI	CMP_BAT_OPEN1,	04H

	LDI	CMP_BAT_FULL0,	09H	;��⵽��ص�ѹ���ڴ���ֵʱ(1.44V -> 0x93)����Ϊ����ѳ���
	LDI	CMP_BAT_FULL1,	04H

	LDI	CMP_BAT_CHARGE0,05H	;��⵽��ص�ѹС�ڴ���ֵʱ(1.35V -> 0x8A)����Ϊ��صÿ�ʼ�����
	LDI	CMP_BAT_CHARGE1,04H

	LDI	CMP_LIGHT0,	0AH	;����Դ���ʹ��,ADת�����С�ڴ���ֵʱ(0.2V -> 0x14)����ʾ��Դ��������
	LDI	CMP_LIGHT1,	00H
	
	LDI	CMP_TYPE00,	00H	;�ƾ���������0
	LDI	CMP_TYPE01,	00H

	LDI	CMP_TYPE10,	00H	;�ƾ���������1
	LDI	CMP_TYPE11,	00H

	LDI	CMP_TYPE20,	00H	;�ƾ���������2
	LDI	CMP_TYPE21,	00H

	LDI	CNT0_CHARGE,	0FH	;��Ӧ���೤ʱ�䣬��ʼֵΪ20Сʱ����20 * 60 =1200����(0x4B0)
	LDI	CNT1_CHARGE,	0AH
	LDI	CNT2_CHARGE,	04H
	

	LDI 	IRQ,		00H
	LDI 	IE,		1100B 	;��ADC,Timer0 �ж�


REGISTER_INITIAL_END:
	RTNI



;*****************************************************
;��鹩���Ƿ�����
;*****************************************************
PRE_START_PWR_CHK:

WAIT_AD_RESULT:
	;һ��ͨ������4�����ݣ�ȥ����С�����ֵ�������µ�2������ƽ����õ����ս����
	;�������̺�ʱԼ408us * 4 = 2ms
	;���������ƶϣ��ĸ�ͨ�����ó�һ�����ս�����ʱ 2ms * 4 = 8ms

	;����������˴���ʱ20ms
	CALL	DELAY_5MS
	CALL	DELAY_5MS
	CALL	DELAY_5MS
	CALL	DELAY_5MS

WAIT_PWR_NML:	
	ORIM	FLAG_OCCUPIED,	0100B	;����ͨ��6���ս��

	LDA	CHN6_FINAL_RET1,01H
	SUB	CMP_MIN_PWR0
	LDA	CHN6_FINAL_RET2,01H
	SBC	CMP_MIN_PWR1

	ANDIM	FLAG_OCCUPIED,	1011B	;�ͷŶ�ͨ��6���ս��������
	
	BC	WAIT_AD_RESULT		;���δ�ﵽ��С�ϵ��ѹ����һֱ�ȴ���ѹ������С�ϵ��ѹ֮�ϡ�

PRE_START_PWR_CHK_END:
	RTNI



;***********************************************************
; ���ƾ�����
; ����: CHN7_FINAL_RET1, CHN7_FINAL_RET2
; ���: LIGHT_TYPE
;***********************************************************
PRE_START_TYPE_CHK:

	ORIM	FLAG_OCCUPIED,	1000B	;����ͨ��7���ս��

	LDA	CHN7_FINAL_RET1,01H	;������0�Ƚ�
	SUB	CMP_TYPE00
	LDA	CHN7_FINAL_RET2,01H
	SBC	CMP_TYPE01
	BNC	LI_ON			;

	LDA	CHN7_FINAL_RET1,01H	;������1�Ƚ�
	SUB	CMP_TYPE10
	LDA	CHN7_FINAL_RET2,01H
	SBC	CMP_TYPE11
	BNC	LI_OFF			;

	LDA	CHN7_FINAL_RET1,01H	;������2�Ƚ�
	SUB	CMP_TYPE20
	LDA	CHN7_FINAL_RET2,01H
	SBC	CMP_TYPE21
	BNC	NI_ON			;

NI_OFF:
	LDI	LIGHT_TYPE,	1000B
	JMP	PRE_START_TYPE_CHK_END
	
LI_ON:
	LDI	LIGHT_TYPE,	0001B
	JMP	PRE_START_TYPE_CHK_END
	
LI_OFF:
	LDI	LIGHT_TYPE,	0010B
	JMP	PRE_START_TYPE_CHK_END
	
NI_ON:
	LDI	LIGHT_TYPE,	0100B
	
PRE_START_TYPE_CHK_END:
	ANDIM	FLAG_OCCUPIED,	0111B	;�ͷŶ�ͨ��7���ս��������
	ORIM	FLAG_TYPE,	0001B	;���ٶ�ͨ��7���в���
	
	RTNI





;***********************************************************
; ͨ��PWM1����ߵ�ƽ���Ե�ؽ��г��
;***********************************************************
CHARGE_BAT_ENABLE:

	LDI	PWMC1,		0000B	;PWM0 Clock = tosc = 4M
	LDI	PWMP10,		0DH	;����Ϊ125��PWM0 Clock
	LDI	PWMP11,		07H	
	LDI	PWMD10,		00H	;��΢��
	LDI	PWMD11,		0DH	;ռ�ձ�Ϊ100%
	LDI	PWMD12,		07H
	ORIM	PWMC1,		0001B	;ʹ��PWM1���

	ORIM	ALREADY_ENTER,	0001B	;���Ѿ���ʼ����־λ
	LDI	CNT0_CHARGE,	0FH
	LDI	CNT1_CHARGE,	0AH
	LDI	CNT2_CHARGE,	04H
	
CHARGE_BAT_ENABLE_END:
	RTNI


;***********************************************************
; ����﮵�أ�ͨ��PWM1����͵�ƽ��ֹͣ�Ե�س��
; �������ӵ�أ�ͨ��PWM1����������Ե�ؽ���������
;***********************************************************
CHARGE_BAT_DISABLE:
	LDA	TBR,		0011B
	AND	LIGHT_TYPE		;�жϵ������
	BNZ	LI_BAT

NI_BAT:
	LDI	PWMC1,		0000B	;PWM0 Clock = 8 * tosc = 2us
	LDI	PWMP10,		0AH	;����Ϊ250��PWM0 Clock
	LDI	PWMP11,		0FH	
	LDI	PWMD10,		00H	;��΢��
	LDI	PWMD11,		0EH	;ռ�ձ�Ϊ1/4
	LDI	PWMD12,		03H
	ORIM	PWMC1,		0001B	;ʹ��PWM1���
	
	JMP	CHARGE_BAT_DISABLE_END

LI_BAT:
	LDI	PWMC1,		0000B	;PWM0 Clock = tosc = 4M
	LDI	PWMP10,		00H	;����Ϊ0��PWM0 Clock
	LDI	PWMP11,		00H	
	LDI	PWMD10,		00H	;��΢��
	LDI	PWMD11,		0DH	;ռ�ձ�Ϊ100%
	LDI	PWMD12,		07H
	ORIM	PWMC1,		0001B	;ʹ��PWM1���

CHARGE_BAT_DISABLE_END:
	ANDIM	ALREADY_ENTER,	1110B	;���Ѿ���ʼ����־λ
	RTNI


;***********************************************************
;��س�����
;***********************************************************
CHARGE_BAT_CTRL:

	ORIM	FLAG_OCCUPIED,	0100B	;����ͨ��6���ս��

	LDA	CHN6_FINAL_RET1,01H
	SUB	CMP_SUPPLY0
	LDA	CHN6_FINAL_RET2,01H
	SBC	CMP_SUPPLY1

	ANDIM	FLAG_OCCUPIED,	1011B	;�ͷŶ�ͨ��6���ս��������

	BC	SET_PWR_DOWN_BIT	;���ͣ��,����ת

	LDA	ALREADY_ENTER		;�������Դ���������������Ƿ��Ѿ�������״̬
	BA0	CHARGE_DURATION		;����Ѿ�������״̬

	LDA	BAT_STATE		
	BA2	CHARGE_BAT_ENABLE	;�����ص�ѹ���ͣ���ʼ�Ե�س��

	JMP	CHARGE_BAT_CTRL_END	;����Ҫ�Ե�س��
	
CHARGE_DURATION:
	ADI	F_TIME,		1000B
	BA3	IS_BAT_FULL		;1����δ��

	ANDIM	F_TIME,		0111B	;��1���ӵ���־λ

	SBIM	CNT0_CHARGE,	01H	;�����ʱ����1����
	LDI	TBR,		00H
	SBCM	CNT1_CHARGE
	LDI	TBR,		00H
	SBCM	CNT2_CHARGE

	BNC	STOP_CHARGE		;
	
IS_BAT_FULL:
	LDA	BAT_STATE
	BA1	STOP_CHARGE		;����ѳ���
	
	JMP	CHARGE_BAT_CTRL_END
	
STOP_CHARGE:
	CALL	CHARGE_BAT_DISABLE
	JMP	CHARGE_BAT_CTRL_END

SET_PWR_DOWN_BIT:
	ORIM	SYSTEM_STATE,	0001B

CHARGE_BAT_CTRL_END:
	RTNI


;***********************************************************
;��Ӧ���ŵ�
;ͨ��PWM0���Ƶ��Ϊ32KHZ��ռ�ձ�Ϊ50%�ķ������Դ�����Ӧ����·
;��ͣ���־λ
;�ý���Ӧ���ŵ��־λ
;Ӧ��ʱ������
;***********************************************************
EMERGENCY_ENABLE:
	ORIM	SYSTEM_STATE,	0001B	;��ͣ���־λ
	ORIM	ALREADY_ENTER,	0010B	;�ñ�־λ�������Ѵ�Ӧ���ŵ繦��
	
	LDI	CNT0_EMERGENCY,	00H	;Ӧ��ʱ������
	LDI	CNT1_EMERGENCY,	00H
	LDI	CNT2_EMERGENCY,	00H

	LDI	PWMC0,		0000B	;PWM0 Clock = tosc = 4M
	LDI	PWMP00,		0DH	;����Ϊ125��PWM0 Clock
	LDI	PWMP01,		07H	
	LDI	PWMD00,		00H	;��΢��
	LDI	PWMD01,		0EH	;ռ�ձ�Ϊ50%
	LDI	PWMD02,		03H
	ORIM	PWMC0,		0001B	;ʹ��PWM0���

EMERGENCY_ENABLE_END:
	RTNI


;***********************************************************
;����PWM0���ر�Ӧ������
;***********************************************************
EMERGENCY_DISABLE:
	LDI	PWMC0,		0000B	;����PWM0

EMERGENCY_DISABLE_END:
	RTNI


;***********************************************************
; ������Ӧ���ŵ��¼������¼�������ʱ��
;***********************************************************
RE_CALC_TIME:
	LDA	DURATION_EMER
	BA0	BETWEEN_0_5
	BA1	BETWEEN_5_30
	BA2	OVER_30

BETWEEN_0_5:
	ADIM	CNT0_CHARGE,	05H	;�������ʱ������5����
	LDI	TBR,		00H
	ADCM	CNT1_CHARGE
	LDI	TBR,		00H
	ADCM	CNT2_CHARGE

	JMP	ADJUST_TIME
	
BETWEEN_5_30:
	ADIM	CNT0_CHARGE,	08H	;�������ʱ������10Сʱ
	LDI	TBR,		05H
	ADCM	CNT1_CHARGE
	LDI	TBR,		02H
	ADCM	CNT2_CHARGE

	JMP	ADJUST_TIME
	
OVER_30:				;��ʹ20+20Сʱ��Ҳ���ᷢ�����
	ADIM	CNT0_CHARGE,	00H	;�������ʱ������20Сʱ
	LDI	TBR,		0BH
	ADCM	CNT1_CHARGE
	LDI	TBR,		04H
	ADCM	CNT2_CHARGE
	
ADJUST_TIME:
	SUB	CNT0_CHARGE,	00H	;�������ʱ����20Сʱ���Ƚ�
	LDI	TBR,		0BH
	SBC	CNT1_CHARGE
	LDI	TBR,		04H
	SBC	CNT2_CHARGE

	BNC	RE_CALC_TIME_END	;�����ʱ��С��20Сʱ

	LDI	CNT0_CHARGE,	00H	;�������ʱ������Ϊ20Сʱ
	LDI	CNT1_CHARGE,	0BH
	LDI	CNT2_CHARGE,	04H
		
RE_CALC_TIME_END:
	RTNI


;***********************************************************
;Ӧ���ŵ����
;����Դͣ����Ӧ���ŵ���ơ�
;��ʱ��ʼӦ���ŵ�:����ԴAD���ŵ�ѹ����1.115V��
;��ʱֹͣӦ���ŵ�:����ԴAD���ŵ�ѹ����1.396V�󣬻��ǵ�غľ�(���AD���ŵ�ѹ����0.96V)
;ֹͣӦ���ŵ�ʱ���ó�Ӧ���ŵ�ʱ��
;***********************************************************
EMERGENCY_CTRL:
	ORIM	FLAG_OCCUPIED,	0100B	;����ͨ��6���ս��

	LDA	CHN6_FINAL_RET1,01H
	SUB	CMP_SUPPLY0
	LDA	CHN6_FINAL_RET2,01H
	SBC	CMP_SUPPLY1

	ANDIM	FLAG_OCCUPIED,	1011B	;�ͷŶ�ͨ��6���ս��������


	BNC	CHK_PWR_RESUME		;�������Դ���ŵ�ѹ����1.115V������ת

	LDA	ALREADY_ENTER		;�������Դ���ŵ�ѹС��1.115V�������Ƿ��Ѿ�����Ӧ��״̬
	BA1	EMERGENCY_CNT		;����Ѿ�����Ӧ��״̬������ת

	CALL	EMERGENCY_ENABLE	;���ͣ���һ�δ����Ӧ��״̬,���Ӧ��
	JMP	EMERGENCY_CTRL_END


CHK_PWR_RESUME:
	ORIM	FLAG_OCCUPIED,	0100B	;����ͨ��6���ս��

	LDA	CHN6_FINAL_RET1,01H
	SUB	CMP_RESUME0
	LDA	CHN6_FINAL_RET2,01H
	SBC	CMP_RESUME1

	ANDIM	FLAG_OCCUPIED,	1011B	;�ͷŶ�ͨ��6���ս��������

	BC	SMALL_THAN_1P396V	;���1.115v < X < 1.396V

	LDA	ALREADY_ENTER		;X > 1.396V
	BA1	STOP_EMERGENCY		;����Ѿ�����Ӧ��״̬������ת
	JMP	EMERGENCY_CTRL_END


SMALL_THAN_1P396V:
	LDA	ALREADY_ENTER		;����Ƿ��Ѿ�����Ӧ��״̬
	BA1	EMERGENCY_CNT		;����Ѿ�����Ӧ��״̬������ת
	JMP	EMERGENCY_CTRL_END


STOP_EMERGENCY:
	ANDIM	SYSTEM_STATE,	1110B	;���ͣ���־λ
	ANDIM	ALREADY_ENTER,	1101B	;����Ѿ���ʼӦ����־λ

BAT_DOWN:	
	CALL	EMERGENCY_DISABLE

	SBI	CNT0_EMERGENCY,	0CH	;��5���ӱȽ�(0x12C)
	LDI	TBR,		02H
	SBC	CNT1_EMERGENCY
	LDI	TBR,		01H
	SBC	CNT2_EMERGENCY

	BNC	LESS_5_MINUTE		;Ӧ��ʱ��С��5����

	SBI	CNT0_EMERGENCY,	08H	;��30���ӱȽ�(0x708)
	LDI	TBR,		00H
	SBC	CNT1_EMERGENCY
	LDI	TBR,		07H
	SBC	CNT2_EMERGENCY

	BNC	LESS_30_MINUTE		;Ӧ��ʱ��С��30����

MORE_30_MINUTE:				;Ӧ��ʱ������30����
	ORIM	DURATION_EMER,	0100B
	CALL	RE_CALC_TIME		;������Ӧ���ŵ��¼������¼�������ʱ��
	JMP	EMERGENCY_CTRL_END

LESS_5_MINUTE:
	ORIM	DURATION_EMER,	0001B
	CALL	RE_CALC_TIME		;������Ӧ���ŵ��¼������¼�������ʱ��
	JMP	EMERGENCY_CTRL_END
	
LESS_30_MINUTE:
	ORIM	DURATION_EMER,	0010B
	CALL	RE_CALC_TIME		;������Ӧ���ŵ��¼������¼�������ʱ��
	JMP	EMERGENCY_CTRL_END
	

EMERGENCY_CNT:
	ADI	F_496MS_1S,	0010B	;ÿ����һ��
	BA1	EMERGENCY_BATTERY

	ANDIM	F_496MS_1S,	1101B	;���1s��־λ
	SBI	CNT2_EMERGENCY,	08H	;���CNT�ﵽ0x800�����ʾ��Ӧ���ŵ�0x800s = 2048s > 30min
	BC	EMERGENCY_BATTERY	;��ʱ�����ٶ�Ӧ���ŵ�ʱ����ʱ

	ADIM	CNT0_EMERGENCY,	01H
	LDI	TBR,		00H
	ADCM	CNT1_EMERGENCY
	LDI	TBR,		00H
	ADCM	CNT2_EMERGENCY

EMERGENCY_BATTERY:			;������Ƿ��Ѿ��ľ�
	ORIM	FLAG_OCCUPIED,	0010B	;����ͨ��1���ս��

	LDI	CHN1_FINAL_RET1,01H
	SUB	CMP_EXIT_EMER0
	LDI	CHN1_FINAL_RET2,01H
	SBC	CMP_EXIT_EMER1

	ANDIM	FLAG_OCCUPIED,	1101B	;�ͷŶ�ͨ��1���ս��������

	BNC	EMERGENCY_CTRL_END
	JMP	BAT_DOWN		;


EMERGENCY_CTRL_END:
	RTNI



;***********************************************************
;����ص�ѹ��
;��������õ�ص�ѹ���������Ӧ���״̬��־λ
;***********************************************************
BAT_STATE_CHK:

	ORIM	FLAG_OCCUPIED,	0010B	;����ͨ��1���ս��

	LDI	CHN1_FINAL_RET1,01H	
	SUB	CMP_BAT_OPEN0		;�жϵ���Ƿ�·
	LDI	CHN1_FINAL_RET2,01H
	SBC	CMP_BAT_OPEN1
	BNC	BAT_OPEN		;ADת���������1.56V����ؿ�·
	ANDIM	BAT_STATE,	1110B	;�������·��·��־λ

	LDI	CHN1_FINAL_RET1,01H	
	SUB	CMP_BAT_FULL0		;�жϵ���Ƿ����
	LDI	CHN1_FINAL_RET2,01H
	SBC	CMP_BAT_FULL1
	BNC	BAT_FULL		;ADת���������1.44V������ѳ���
	ANDIM	BAT_STATE,	1101B	;�������ѳ�����־λ

	LDI	CHN1_FINAL_RET1,01H	
	SUB	CMP_BAT_CHARGE0		;�жϵ���Ƿ���ͣ���Ҫ�����
	LDI	CHN1_FINAL_RET2,01H
	SBC	CMP_BAT_CHARGE1
	BC	BAT_NEED_CHARGE		;ADת�����С��1.35V�������Ҫ���³��
	JMP	BAT_STATE_CHK_END

BAT_OPEN:
	ORIM	BAT_STATE,	0001B	;�ó���·��·��־λ
	JMP	BAT_STATE_CHK_END

BAT_FULL:
	ORIM	BAT_STATE,	0010B	;�õ���ѳ�����־λ
	ANDIM	BAT_STATE,	1011B	;������Ҫ���³���־λ
	JMP	BAT_STATE_CHK_END

BAT_NEED_CHARGE:
	ORIM	BAT_STATE,	0100B	;�õ����Ҫ���³���־λ
	JMP	BAT_STATE_CHK_END

BAT_STATE_CHK_END:
	ANDIM	FLAG_OCCUPIED,	1101B	;�ͷŶ�ͨ��1���ս��������
	RTNI


;***********************************************************
;����ͨ��0ת�����������Դ״̬�������ù�Դ���ϱ�־λ
;***********************************************************
PROCESS_LIGHT:

	ORIM	FLAG_OCCUPIED,	0001B	;����ͨ��0���ս��

	LDI	CHN1_FINAL_RET1,01H
	SUB	CMP_LIGHT0
	LDI	CHN1_FINAL_RET2,01H
	SBC	CMP_LIGHT1

	ANDIM	FLAG_OCCUPIED,	1110B	;�ͷŶ�ͨ��0���ս��������

	BC	ERROR_LIGHT		;��Դ����

	ANDIM	ALARM_STATE,	1101B	;�����Դ���ϱ�־λ
	JMP     PROCESS_LIGHT_END

ERROR_LIGHT:
	ORIM	ALARM_STATE,	0010B	;�ù�Դ���ϱ�־λ

PROCESS_LIGHT_END:

	RTNI

;***********************************************************
;��Դ״̬��⣬������Ӧ��־λ
;***********************************************************
LIGHT_STATE_CHK:

	LDI	TBR,		0101B	;��������0101B�����ۼ���A��
	AND	LIGHT_TYPE		;BIT0\2Ϊ1�������ƾ�Ϊ������

	BNZ	TYPE_ON			;Ϊ�����͵ƾ�
	JMP	TYPE_OFF		;Ϊ�����͵ƾ�
	
TYPE_ON:
	CALL	PROCESS_LIGHT		;����Դ����������Ӧ��־λ
	JMP     LIGHT_STATE_CHK_END

TYPE_OFF:
	ADI	SYSTEM_STATE,	01H	;�������Դ�����Ƿ�����
	BA0	LIGHT_STATE_CHK_END	;��������Դ��������״̬������Թ�Դ���м��
	CALL	PROCESS_LIGHT		;����Դ����������Ӧ��־λ

LIGHT_STATE_CHK_END:
	RTNI


;***********************************************************
;LED�����������
;����·�޹��ϵ�ǰ���£���ɫLED:δ���ʱ�رպ�ƣ��ڳ��ʱ�򿪺��
;����·��·/��·: ����𣬻Ƶ�1HZ��˸
;��Դ��·/��·:             �Ƶ�3HZ��˸
;�ŵ�ʱ�䲻��:              �ƵƳ���
;������ģʽ��־λ�����Ʒ�����
;***********************************************************
TIPS_PROCESS:
;��ƵĴ���
RED:
	LDA	ALARM_STATE 		;�жϵ�س���·�Ƿ��ڹ���״̬
	BA0	RED_ERROR		;����й��ϣ�����ת

	LDA	ALREADY_ENTER		;��س���·û�й��ϣ�
	BA1	RED_ON
	
RED_ERROR:	
	ANDIM	PORTC,		1110B	;�رպ��
	JMP	GREEN

RED_ON:
	ORIM	PORTC,		0001B	;�򿪺��	

;--------------------------------------------------------------------------
;�̵ƵĴ���
GREEN:
	LDA	GREEN_FLASH
	BA1	GREEN_1HZ
	BA2	GREEN_3HZ

	LDA	SYSTEM_STATE
	BNZ	GREEN_OFF		;�����ǰϵͳΪӦ��״̬�����̵���
	ORIM	PORTC,		0010B	;�����ǰϵͳ����Դ���������̵���
	JMP	ALARM_BAT

GREEN_OFF:
	ANDIM	PORTC,		1101B	;Ϩ���̵�
	JMP	ALARM_BAT

GREEN_1HZ:	
	ADI	F_168MS,	01H	;�ж��Ƿ���һ����168MS
	BA0 	TIPS_PROCESS_END	;��û�е�168MS��ֱ����������
	
	ADIM	CNT_LED_GREEN,	01H
	SBI	CNT_LED_GREEN,	03H

	BNC	ALARM_BAT
	LDI	CNT_LED_GREEN,	00H
	EORIM	PORTC,		0010B
	JMP	ALARM_BAT

GREEN_3HZ:	
	ADI	F_168MS,	01H	;�ж��Ƿ���һ����168MS
	BA0 	TIPS_PROCESS_END
	EORIM	PORTC,		0010B
	
;--------------------------------------------------------------------------
;��س���·���ϴ���
ALARM_BAT:	
	LDI	TBR,		0001B	;��0001B�����ۼ���A��
	AND	ALARM_STATE 		;�жϵ���Ƿ��ڹ���״̬
	BAZ	ALARM_LIGHT		;���û�й��ϣ�����ת

	ADI	F_168MS,	01H	;�ж��Ƿ���һ����168MS
	BA0	ALARM_TIME_NOT_ENOUGH	;��δ���µ�168MS,��ת

	ADIM	CNT_LED_YELLOW,	01H	;168MS�ѵ�����������1

	SBI	CNT_LED_YELLOW,	03H
	BNC	ALARM_LIGHT		;δ��500ms

	LDI	CNT_LED_YELLOW,	00H	;���������
	EORIM	PORTE,		0001B	;��1HZƵ�ʷ�ת�Ƶ�

;--------------------------------------------------------------------------
;��Դ���ϵĴ���
ALARM_LIGHT:
	LDI	TBR,		0010B	;��0010B�����ۼ���A��
	AND	ALARM_STATE		;�жϹ�Դ�Ƿ��ڹ���״̬
	BAZ	ALARM_TIME_NOT_ENOUGH	;��Դû�й��ϣ�����ת

	ADI	CNT0_168MS,	01H	;�ж��Ƿ���һ����168MS
	BA0	ALARM_TIME_NOT_ENOUGH	;��δ���µ�168MS,��ת

	EORIM	PORTE,		0001B	;��3HZƵ�ʷ�ת�Ƶ�

;--------------------------------------------------------------------------
;Ӧ��ʱ������Ĵ���
ALARM_TIME_NOT_ENOUGH:
	LDI	TBR,		0100B	;��0100B�����ۼ���A��
	AND	ALARM_STATE		;�ж��Ƿ���ַŵ�ʱ�䲻��֮����
	BAZ	OFF_LED_YELLOW		;û�г��ַŵ�ʱ�䲻��֮���ϣ�����ת
	
	ORIM	PORTE,		0001B	;�ƵƳ���
	JMP	TIPS_PROCESS_END

OFF_LED_YELLOW:
	LDA	ALARM_STATE		;���û���κι��ϣ���رջƵ�
	BNZ	TIPS_PROCESS_END
	ANDIM	PORTE,		1110B

;--------------------------------------------------------------------------

TIPS_PROCESS_END:
	ANDIM	F_168MS,	1110B	;���168MS��־
	RTNI



;***********************************************************
;����ɨ��
;***********************************************************
KEY_PROCESS:

	LDI 	PDCR,		1110B 	;����PD.0 Ϊ���룬PD.3 Ϊ���
	
KEY_CHECK:
	ADI	F_496MS_1S,	0001B	;���496MS��־λ
	BA0	KEY_PROCESS_END		;δ��496ms����ʱ��������ɨ��

	ANDIM	F_496MS_1S,	1110B	;��496MS��־λ
	CALL 	DELAY_5MS 		;������������
	
	LDA 	PORTD,		00H 	;��ȡPD ��״̬
	STA 	TEMP,		00H 	;��PD ��״̬�浽TEMP �Ĵ�����
	CALL 	DELAY_5MS 		;������������
	
	LDA 	PORTD,		00H 	;��ȡPD ��״̬
	SUB 	TEMP,		00H 	;�Ƚ϶�ȡPD.0 ��״ֵ̬������������
	BA0 	KEY_ERROR
	CALL 	DELAY_5MS 		;������������
	
	LDA 	PORTD,		00H 	;��ȡPD ��״̬
	SUB 	TEMP,		00H 	;�Ƚ϶�ȡPD.0 ��״ֵ̬������������
	BA0 	KEY_ERROR
	
	LDA 	TEMP		 	;��TEMP �е����ݴ������ۼ���A ��
	BA0	NO_KEY_PRESSED		;û�м�⵽����
	
	JMP	KEY_PRESSED		;��⵽�а�������

NO_KEY_PRESSED:
	LDA	BTN_PRE_STA		;����һ�ΰ���״̬�����ۼ���A ��
	ADD	TEMP			;TEMP + A -> A
	BA0	KEY_RELEASED		;��һ�ΰ��£�����δ����

	JMP 	ALWAYS_NO_KEY		;��һ��δ���£�����Ҳδ����

KEY_RELEASED:

	;���ݰ��������µ�ʱ��T�������������º���״̬:
	; T < 3s      -- "ģ��ͣ��"
	; 3s < T < 5s -- "�ֶ��¼�"
	; 5s < T < 7s -- "�ֶ����"
	; T > 7s      -- "�ض�Ӧ�����"
	SBI	BTN_PRESS_CNT,	06H	;
	BNC	LESS_3S			;��������ʱ��С��3S, 6.04 * 496ms = 3s
	SBI	BTN_PRESS_CNT,	0AH	;
	BNC	LESS_5S			;��������ʱ��С��5S, 10.08 * 496ms = 5s
	SBI	BTN_PRESS_CNT,	0EH	;
	BNC	LESS_7S			;��������ʱ��С��7S, 14.11 * 496ms = 7s

MORE_7S:
	LDI	PRESS_DURATION,	1000B	;��"����7��"״̬
	JMP	RELEASED_OVER	
LESS_3S:
	LDI	PRESS_DURATION,	0000B	;���"С��3��"״̬
	JMP	RELEASED_OVER
LESS_5S:
	LDI	PRESS_DURATION,	0010B	;��"����3�룬С��5��"״̬
	JMP	RELEASED_OVER
LESS_7S:
	LDI	PRESS_DURATION,	0100B	;��"����5�룬С��7��"״̬
	JMP	RELEASED_OVER
	
RELEASED_OVER:
	JMP	ON_RELEASED


KEY_PRESSED:
	;SBI	BTN_PRESS_CNT,	06H	
	;BC	MORE_3S			;��������ʱ������3S, 6.04 * 496ms = 3s
	;ORIM	PRESS_DURATION,	0001B	;��������ʱ��С��3S, ��"С��3��"״̬
	;JMP	PRESSED_DURATION_ADD_1
	
;MORE_3S:
	;ANDIM	PRESS_DURATION,	1110B	;��������ʱ������3S, ���"С��3��"״̬

PRESSED_DURATION_ADD_1:	
	SBI	BTN_PRESS_CNT,  0FH	;�Ƚ�BTN_PRESS_CNT �� 0x0F �Ĵ�С
	BC	KEY_CHECK_PROCESS_OVER	;���BTN_PRESS_CNT�Ѿ��ۼ���0x0F�������ۼ�
	ADIM	BTN_PRESS_CNT,	01H	;496MS��ʱ������1

KEY_PRESSED_CHK:
	SBI	BTN_PRESS_CNT,	06H	;
	BNC	KPC_LESS_3S		;��������ʱ��С��3S, 6.04 * 496ms = 3s
	SBI	BTN_PRESS_CNT,	0AH	;
	BNC	KPC_LESS_5S		;��������ʱ��С��5S, 10.08 * 496ms = 5s
	SBI	BTN_PRESS_CNT,	0EH	;
	BNC	KPC_LESS_7S		;��������ʱ��С��7S, 14.11 * 496ms = 7s

KPC_MORE_7S:
	LDI	PRESS_DURATION,	1000B	;��"����7��"״̬
	JMP	KEY_CHECK_PROCESS_OVER	
KPC_LESS_3S:
	LDI	PRESS_DURATION,	0001B	;��"С��3��"״̬
	JMP	KEY_CHECK_PROCESS_OVER
KPC_LESS_5S:
	LDI	PRESS_DURATION,	0010B	;��"����3�룬С��5��"״̬
	JMP	KEY_CHECK_PROCESS_OVER
KPC_LESS_7S:
	LDI	PRESS_DURATION,	0100B	;��"����5�룬С��7��"״̬
	JMP	KEY_CHECK_PROCESS_OVER

KEY_ERROR: 				;�����ֵ����
ALWAYS_NO_KEY:
ON_RELEASED:
	LDI	BTN_PRESS_CNT,	00H
	
KEY_CHECK_PROCESS_OVER: 		;����ɨ�輰��������������
	ANDIM	TEMP,		0001B	;
	STA	BTN_PRE_STA		;TEMP -> BTN_PRE_STA
	
KEY_PROCESS_END:
	RTNI

	


;***********************************************************
;�����Լ��־λ
;SELF_STATE
;
;
;***********************************************************
SELF_CHK_STATE:
	LDA	SYSTEM_STATE
	;BA0	SELF_CHK_STATE_END	;��ǰ����ͣ��״̬�������Լ��־λ���

	LDA	F_TIME
	BA2	SET_YEAR_BIT		;���1��ʱ���ѵ�������ת
	BA1	SET_MONTH_BIT		;���1��ʱ���ѵ�������ת

;--------------------------------------------------------------------------------------

MANUAL_CHK:
	LDA	PRESS_DURATION		
	BA0	SCS_LESS_3S		;�����������ʱ��С��3�룬����ת
	BA1	SCS_LESS_5S		;�����������ʱ������3�룬С��5�룬����ת
	BA2	SCS_LESS_7S		;�����������ʱ������5�룬С��7�룬����ת

	LDA	SELF_STATE
	BNZ	SCS_CLEAR_DURATION
	LDI	GREEN_FLASH,	00H	;�����ǰû���Լ죬�����̵�ֹͣ��˸
	
	JMP	SCS_CLEAR_DURATION
	
;--------------------------------------------------------------------------------------

SCS_LESS_3S:
	ADI	BTN_PRE_STA,	01H
	BA0	BTN_PRE_PRESSED		;�����ǰ�������ڰ���״̬������ת

	ANDIM	SELF_STATE,	0110B	;��ģ��Ӧ����־λ

	ADI	SELF_STATE,	1000B	;
	BA3	SCS_CLEAR_DURATION	;�����ǰ�����ֶ��¼���ֶ���죬����ת
	
	BA1	SCS_SIMU_MONTH		;�����ǰΪ�ֶ��¼죬����ת
	BA2	SCS_SIMU_YEAR		;�����ǰΪ�ֶ���죬����ת	
	JMP	SCS_CLEAR_DURATION

SCS_SIMU_MONTH:
	ANDIM	SELF_STATE,	0101B	;�˳��ֶ��¼�
	JMP	SCS_CLEAR_DURATION

SCS_SIMU_YEAR:
	ANDIM	SELF_STATE,	0011B	;�˳��ֶ����
	JMP	SCS_CLEAR_DURATION

BTN_PRE_PRESSED:
	LDI	SELF_STATE,	1001B	;��ģ��Ӧ����־λ
	JMP	SCS_CLEAR_DURATION

;--------------------------------------------------------------------------------------

SCS_LESS_5S:
	LDI	GREEN_FLASH,	0010B	;���̵���1HZ��Ƶ�ʿ�ʼ��˸

	ADI	BTN_PRE_STA,	01H
	BA0	SCS_CLEAR_DURATION	;�����ǰ����Ϊ����״̬������ת

	LDI	SELF_STATE,	1010B	;���ֶ��¼��־λ
	JMP	SCS_CLEAR_DURATION

;--------------------------------------------------------------------------------------

SCS_LESS_7S:
	LDI	GREEN_FLASH,	0100B	;���̵���3HZ��Ƶ�ʿ�ʼ��˸

	ADI	BTN_PRE_STA,	01H
	BA0	SCS_CLEAR_DURATION	;�����ǰ����Ϊ����״̬������ת

	LDI	SELF_STATE,	1100B	;���ֶ�����־λ
	JMP	SCS_CLEAR_DURATION

;--------------------------------------------------------------------------------------	

SET_MONTH_BIT:
	ANDIM	F_TIME,		1101B	;��1�µ���־λ
	LDI	SELF_STATE,	0010B	;���Զ��¼��־λ
	JMP	SELF_CHK_STATE_END

;--------------------------------------------------------------------------------------	

SET_YEAR_BIT:
	ANDIM	F_TIME,		1011B	;��1�굽��־λ
	LDI	SELF_STATE,	0100B	;���Զ�����־λ
	JMP	SELF_CHK_STATE_END

;--------------------------------------------------------------------------------------	

SCS_CLEAR_DURATION:
	ANDIM	PRESS_DURATION,	1000B	;�尴��ʱ����־����λ


SELF_CHK_STATE_END:
	RTNI




;***********************************************************
;�����Լ��־λ�������Լ�
;***********************************************************
SELF_CHK_PROCESS:

	LDA	SYSTEM_STATE
	BA0	SELF_CHK_PROCESS_END	;���ͣ�磬����ת

	LDA	SELF_STATE		;����Լ�״̬��־
	BA0	SCP_EMERGENCY		;���ģ��ͣ���־λΪ1������ת

	LDA	SELF_STATE
	BA1	SCP_MONTH		;����ֶ��¼��־Ϊ1������ת

	ADI	ALREADY_ENTER,	0100B	
	BA2	SCP_CHK_YEAR_BIT	;�����һ�β����¼죬����ת
	JMP	SCP_ARRIVE_120S		;�����һ���¼��־Ϊ1������Ϊ0�����˳��¼�	

SCP_CHK_YEAR_BIT:
	LDA	SELF_STATE
	BA2	SCP_YEAR		;����ֶ�����־Ϊ1������ת

	ADI	ALREADY_ENTER,	1000B	
	BA3	SCP_CLEAR_ALL		;�����һ�β�����죬����ת
	JMP	SCP_ARRIVE_30MIN	;�����һ������־Ϊ1������Ϊ0�����˳����

SCP_CLEAR_ALL:
	JMP	SCP_DIS_EMERGENCY	;����Լ��־��Ϊ0����ر�Ӧ��
	
;---------------------------------------------------------------------------

SCP_EMERGENCY:
	ORIM	PWMC0,		0001B	;ʹ��PWM0���
	JMP	SELF_CHK_PROCESS_END

;---------------------------------------------------------------------------

SCP_DIS_EMERGENCY:
	ANDIM	PWMC0,		1110B	;�ر�PWM0���
	JMP	SELF_CHK_PROCESS_END

;---------------------------------------------------------------------------

SCP_MONTH:
	LDA	ALREADY_ENTER
	BA2	SCP_MONTH_1S		;����Ѿ���Ӧ��������ת

	ORIM	ALREADY_ENTER,	0100B	;���Ѿ������ֶ��¼��־λ
	LDI	CNT0_EMERGENCY,	00H	;Ӧ��ʱ������
	LDI	CNT1_EMERGENCY,	00H
	LDI	CNT2_EMERGENCY,	00H
	ORIM	PWMC0,		0001B	;ʹ��PWM0���
	JMP	SELF_CHK_PROCESS_END
	
;---------------------------------------------------------------------------

SCP_MONTH_1S:
	ADI	F_496MS_1S,	0010B
	BA1	SELF_CHK_PROCESS_END	;��δ��1�룬����ת

	ANDIM	F_496MS_1S,	1101B	;�幩Ӧ����ʱ�õ�1���־λ

	SBI	CNT0_EMERGENCY,	08H	;��120��Ƚ�(0x78)
	LDI	TBR,		07H
	SBC	CNT1_EMERGENCY

	BC	SCP_ARRIVE_120S		;���Ӧ��ʱ������120�룬����ת

	ADIM	CNT0_EMERGENCY,	01H	;Ӧ��ʱ����1
	LDI	TBR,		00H
	ADCM	CNT1_EMERGENCY

	ORIM	FLAG_OCCUPIED,	0010B	;����ͨ��1���ս��

	LDI	CHN1_FINAL_RET1,01H
	SUB	CMP_EXIT_EMER0
	LDI	CHN1_FINAL_RET2,01H
	SBC	CMP_EXIT_EMER1

	ANDIM	FLAG_OCCUPIED,	1101B	;�ͷŶ�ͨ��1���ս��������

	;BNC	SELF_CHK_PROCESS_END	;�����ػ�δ�ľ�������ת
	JMP	SELF_CHK_PROCESS_END	;�����ػ�δ�ľ�������ת

	ORIM	ALARM_STATE,	0100B	;�÷ŵ�ʱ�������־λ
	
;---------------------------------------------------------------------------

SCP_ARRIVE_120S:
	ANDIM	PWMC0,		1110B	;�ر�PWM0���
	LDI	SELF_STATE,	0000B	;���¼��־λ
	ANDIM	GREEN_FLASH,	1101B	;���̵�ֹͣ��1HZ��Ƶ����˸	
	ANDIM	ALREADY_ENTER,	1011B	;���Ѿ������ֶ��¼��־λ

	ORIM	DURATION_EMER,	0001B	;Ӧ��ʱ��Ϊ2���ӣ���Ӧ��ʱ��С��5���ӱ�־λ
	CALL	RE_CALC_TIME		;����Ӧ��ʱ�������¼�������ʱ��
	JMP	SELF_CHK_PROCESS_END
	
;---------------------------------------------------------------------------

SCP_YEAR:
	LDA	ALREADY_ENTER
	BA3	SCP_YEAR_1S		;����Ѿ���Ӧ��������ת

	ORIM	ALREADY_ENTER,	1000B	;���Ѿ�����Ӧ����־λ
	LDI	CNT0_EMERGENCY,	00H	;Ӧ��ʱ������
	LDI	CNT1_EMERGENCY,	00H
	LDI	CNT2_EMERGENCY,	00H
	ORIM	PWMC0,		0001B	;ʹ��PWM0���
	JMP	SELF_CHK_PROCESS_END

SCP_YEAR_1S:
	ADI	F_496MS_1S,	0010B
	BA1	SELF_CHK_PROCESS_END	;��δ��1�룬����ת

	ANDIM	F_496MS_1S,	1101B	;�幩Ӧ����ʱ�õ�1���־λ

	ADIM	CNT0_EMERGENCY,	01H	;Ӧ��ʱ����1
	LDI	TBR,		00H
	ADCM	CNT1_EMERGENCY
	LDI	TBR,		00H
	ADCM	CNT2_EMERGENCY
	
	ORIM	FLAG_OCCUPIED,	0010B	;����ͨ��1���ս��

	LDI	CHN1_FINAL_RET1,01H
	SUB	CMP_EXIT_EMER0
	LDI	CHN1_FINAL_RET2,01H
	SBC	CMP_EXIT_EMER1

	ANDIM	FLAG_OCCUPIED,	1101B	;�ͷŶ�ͨ��1���ս��������

	;BNC	SELF_CHK_PROCESS_END	;�����ػ�δ�ľ�������ת
	JMP	SELF_CHK_PROCESS_END	;�����ػ�δ�ľ�������ת


	SBI	CNT0_EMERGENCY,	08H	;��30���ӱȽ�(0x708)
	LDI	TBR,		00H
	SBC	CNT1_EMERGENCY
	LDI	TBR,		07H
	SBC	CNT2_EMERGENCY	

	BC	SCP_ARRIVE_30MIN

	ORIM	ALARM_STATE,	0100B	;��Ӧ���ŵ�ʱ�������־λ
	
;---------------------------------------------------------------------------

SCP_ARRIVE_30MIN:
	ANDIM	PWMC0,		1110B	;�ر�PWM0���
	LDI	SELF_STATE,	0000B	;������־λ
	ANDIM	GREEN_FLASH,	1011B	;���̵�ֹͣ��3HZ��Ƶ����˸
	ANDIM	ALREADY_ENTER,	0111B	;���Ѿ������ֶ�����־λ	

	SBI	CNT0_EMERGENCY,	0CH	;��5���ӱȽ�(0x12C)
	LDI	TBR,		02H
	SBC	CNT1_EMERGENCY
	LDI	TBR,		01H
	SBC	CNT2_EMERGENCY

	BNC	YEAR_LESS_5_MINUTE	;Ӧ��ʱ��С��5����

	SBI	CNT0_EMERGENCY,	08H	;��30���ӱȽ�(0x708)
	LDI	TBR,		00H
	SBC	CNT1_EMERGENCY
	LDI	TBR,		07H
	SBC	CNT2_EMERGENCY

	BNC	YEAR_LESS_30_MINUTE	;Ӧ��ʱ��С��30����

YEAR_MORE_30_MINUTE:			;Ӧ��ʱ������30����
	ORIM	DURATION_EMER,	0100B
	CALL	RE_CALC_TIME		;������Ӧ���ŵ��¼������¼�������ʱ��
	JMP	SELF_CHK_PROCESS_END

YEAR_LESS_5_MINUTE:
	ORIM	DURATION_EMER,	0001B
	CALL	RE_CALC_TIME		;������Ӧ���ŵ��¼������¼�������ʱ��
	JMP	SELF_CHK_PROCESS_END
	
YEAR_LESS_30_MINUTE:
	ORIM	DURATION_EMER,	0010B
	CALL	RE_CALC_TIME		;������Ӧ���ŵ��¼������¼�������ʱ��
	JMP	SELF_CHK_PROCESS_END
	
;---------------------------------------------------------------------------
	
SELF_CHK_PROCESS_END:
	RTNI



;************************************************************
; ��ʱ5 �����ӳ���
;************************************************************
DELAY_5MS:
	LDI 	DELAY_TIMER2,	03H 	;���ó�ʼֵ
	LDI 	DELAY_TIMER1,	03H
	LDI 	DELAY_TIMER0,	0CH

DELAY_5MS_LOOP:
	SBIM 	DELAY_TIMER0,	01H 	;ÿ�μ�1
	LDI 	CLEAR_AC,	00H
	SBCM 	DELAY_TIMER1,	00H
	LDI 	CLEAR_AC,	00H
	SBCM 	DELAY_TIMER2,	00H
	BC 	DELAY_5MS_LOOP
	
	RTNI


;*******************************************
; �ӳ���: CAL_CHN0_ADCDATA
; ����: ������ƽ���˲�����N=4��ȥһ�����ֵ��һ����Сֵ��ʣ��������ƽ��ֵ��
;*******************************************
CAL_CHN0_ADCDATA:
	ADI	FLAG_OCCUPIED,		0001B
	BA0	CAL_CHN0_AD_MIN01
	JMP	CAL_CHN0_ADCDATA_END		;����ʹ��ת�����

;----------------------------
;Ѱ����Сֵ
CAL_CHN0_AD_MIN01:	
	LDA 	CHN0_RET1_BAK0,		01H
	SUB 	CHN0_RET1_BAK1,		01H
	LDA 	CHN0_RET2_BAK0,		01H
	SBC 	CHN0_RET2_BAK1,		01H
	BC 	CAL_CHN0_AD_MIN02 		;D0<D1	

CAL_CHN0_AD_MIN12:
	LDA 	CHN0_RET1_BAK1,		01H
	SUB 	CHN0_RET1_BAK2,		01H
	LDA 	CHN0_RET2_BAK1,		01H
	SBC 	CHN0_RET2_BAK2,		01H
	BC 	CAL_CHN0_AD_MIN13 		;D1<D2

CAL_CHN0_AD_MIN23:
	LDA 	CHN0_RET1_BAK2,		01H
	SUB 	CHN0_RET1_BAK3,		01H
	LDA 	CHN0_RET2_BAK2,		01H
	SBC 	CHN0_RET2_BAK3,		01H
	BC 	CAL_CHN0_AD_MIN2 		;D2<D3
	;D3<D2
	JMP 	CAL_CHN0_AD_MIN3

CAL_CHN0_AD_MIN13:
	LDA 	CHN0_RET1_BAK1,		01H
	SUB 	CHN0_RET1_BAK3,		01H
	LDA 	CHN0_RET2_BAK1,		01H
	SBC 	CHN0_RET2_BAK3,		01H
	BC 	CAL_CHN0_AD_MIN1 		;D1<D3
	;D3<D1
	JMP 	CAL_CHN0_AD_MIN3

;D0<D1
CAL_CHN0_AD_MIN02:
	LDA 	CHN0_RET1_BAK0,		01H
	SUB 	CHN0_RET1_BAK2,		01H
	LDA 	CHN0_RET2_BAK0,		01H
	SBC 	CHN0_RET2_BAK2,		01H
	BC 	CAL_CHN0_AD_MIN03 		;D0<D2
	;D3<D1
	JMP 	CAL_CHN0_AD_MIN23

;D0<D2
CAL_CHN0_AD_MIN03:
	LDA 	CHN0_RET1_BAK0,		01H
	SUB 	CHN0_RET1_BAK3,		01H
	LDA 	CHN0_RET2_BAK0,		01H
	SBC 	CHN0_RET2_BAK3,		01H
	BC 	CAL_CHN0_AD_MIN0 		;D0<D3
	;D3<D0
	JMP 	CAL_CHN0_AD_MIN3

;-----------------------
;����Сֵ����
CAL_CHN0_AD_MIN0:
	LDI 	TBR,			00H
	STA 	CHN0_RET0_BAK0,		01H
	STA 	CHN0_RET1_BAK0,		01H
	STA 	CHN0_RET2_BAK0,		01H
	JMP 	CAL_CHN0_AD_MAX01

CAL_CHN0_AD_MIN1:
	LDI 	TBR,			00H
	STA 	CHN0_RET0_BAK1,		01H
	STA 	CHN0_RET1_BAK1,		01H
	STA 	CHN0_RET2_BAK1,		01H
	JMP 	CAL_CHN0_AD_MAX01

CAL_CHN0_AD_MIN2:
	LDI 	TBR,			00H
	STA 	CHN0_RET0_BAK2,		01H
	STA 	CHN0_RET1_BAK2,		01H
	STA 	CHN0_RET2_BAK2,		01H
	JMP 	CAL_CHN0_AD_MAX01

CAL_CHN0_AD_MIN3:
	LDI 	TBR,			00H
	STA 	CHN0_RET0_BAK3,		01H
	STA 	CHN0_RET1_BAK3,		01H
	STA 	CHN0_RET2_BAK3,		01H
	JMP 	CAL_CHN0_AD_MAX01

;----------------------------
;Ѱ�����ֵ
CAL_CHN0_AD_MAX01:
	LDA 	CHN0_RET1_BAK0,		01H
	SUB 	CHN0_RET1_BAK1,		01H
	LDA 	CHN0_RET2_BAK0,		01H
	SBC 	CHN0_RET2_BAK1,		01H
	BC 	CAL_CHN0_AD_MAX12 		;D1>D0

;D0>D1
CAL_CHN0_AD_MAX02:
	LDA 	CHN0_RET1_BAK0,		01H
	SUB 	CHN0_RET1_BAK2,		01H
	LDA 	CHN0_RET2_BAK0,		01H
	SBC 	CHN0_RET2_BAK2,		01H
	BC 	CAL_CHN0_AD_MAX23 		;D2>D0

;D0>D2
CAL_CHN0_AD_MAX03:
	LDA 	CHN0_RET1_BAK0,		01H
	SUB 	CHN0_RET1_BAK3,		01H
	LDA 	CHN0_RET2_BAK0,		01H
	SBC 	CHN0_RET2_BAK3,		01H
	BC 	CAL_CHN0_AD_MAX3 		;D3>D0
	;D0>D3
	JMP 	CAL_CHN0_AD_MAX0

;D2>D0
CAL_CHN0_AD_MAX23:
	LDA 	CHN0_RET1_BAK2,		01H
	SUB 	CHN0_RET1_BAK3,		01H
	LDA 	CHN0_RET2_BAK2,		01H
	SBC 	CHN0_RET2_BAK3,		01H
	BC 	CAL_CHN0_AD_MAX3 		;D3>D2
	;D2>D3
	JMP 	CAL_CHN0_AD_MAX2

;D1>D0
CAL_CHN0_AD_MAX12:
	LDA 	CHN0_RET1_BAK1,		01H
	SUB 	CHN0_RET1_BAK2,		01H
	LDA 	CHN0_RET2_BAK1,		01H
	SBC 	CHN0_RET2_BAK2,		01H
	BC 	CAL_CHN0_AD_MAX23 		;D2>D1

;D1>D2
CAL_CHN0_AD_MAX13:
	LDA 	CHN0_RET1_BAK1,		01H
	SUB 	CHN0_RET1_BAK3,		01H
	LDA 	CHN0_RET2_BAK1,		01H
	SBC 	CHN0_RET2_BAK3,		01H
	BC 	CAL_CHN0_AD_MAX3 		;D3>D1
	;D1>D3
	JMP 	CAL_CHN0_AD_MAX1

;-----------------------
;�����ֵ����
CAL_CHN0_AD_MAX0:
	LDI 	TBR,			00H
	STA 	CHN0_RET0_BAK0,		01H
	STA 	CHN0_RET1_BAK0,		01H
	STA 	CHN0_RET2_BAK0,		01H
	JMP 	CAL_CHN0_AD_ADD

CAL_CHN0_AD_MAX1:
	LDI 	TBR,			00H
	STA 	CHN0_RET0_BAK1,		01H
	STA 	CHN0_RET1_BAK1,		01H
	STA 	CHN0_RET2_BAK1,		01H
	JMP 	CAL_CHN0_AD_ADD

CAL_CHN0_AD_MAX2:
	LDI 	TBR,			00H
	STA 	CHN0_RET0_BAK2,		01H
	STA 	CHN0_RET1_BAK2,		01H
	STA 	CHN0_RET2_BAK2,		01H
	JMP 	CAL_CHN0_AD_ADD

CAL_CHN0_AD_MAX3:
	LDI 	TBR,			00H
	STA 	CHN0_RET0_BAK3,		01H
	STA 	CHN0_RET1_BAK3,		01H
	STA 	CHN0_RET2_BAK3,		01H
	JMP 	CAL_CHN0_AD_ADD

;----------------------------
;�����ܺͲ������CHN0_RET0_BAK3,CHN0_RET1_BAK3 ��CHN0_RET2_BAK3����������������ģ�
CAL_CHN0_AD_ADD:
	LDI 	TEMP_SUM_CY,		00H

	;D0 + D1
	;LDA 	CHN0_RET0_BAK0,		01H
	;ADDM 	CHN0_RET0_BAK1,		01H
	LDA 	CHN0_RET1_BAK0,		01H
	ADDM 	CHN0_RET1_BAK1,		01H
	LDA 	CHN0_RET2_BAK0,		01H
	ADCM 	CHN0_RET2_BAK1,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

	;+ D2
	;LDA 	CHN0_RET0_BAK1,		01H
	;ADDM 	CHN0_RET0_BAK2,		01H
	LDA 	CHN0_RET1_BAK1,		01H
	ADDM 	CHN0_RET1_BAK2,		01H
	LDA 	CHN0_RET2_BAK1,		01H
	ADCM 	CHN0_RET2_BAK2,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

	;+ D3
	;LDA 	CHN0_RET0_BAK2,		01H
	;ADDM 	CHN0_RET0_BAK3,		01H
	LDA 	CHN0_RET1_BAK2,		01H
	ADDM 	CHN0_RET1_BAK3,		01H
	LDA 	CHN0_RET2_BAK2,		01H
	ADCM 	CHN0_RET2_BAK3,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

;----------------------------
;�ܺͳ���2���õ�ƽ��ֵ�������CHN0_FINAL_RET0(),CHN0_FINAL_RET1 ��CHN0_FINAL_RET2
CAL_CHN0_AD_DIV:
	;LDA 	CHN0_RET0_BAK3,		01H
	;SHR
	;STA 	CHN0_RET0_BAK3,		01H
	
	LDA 	CHN0_RET1_BAK3,		01H
	SHR
	STA 	CHN0_RET1_BAK3,		01H
	
	;BNC 	$+3
	;LDI 	TBR,			0010B
	;ORM 	CHN0_RET0_BAK3

	LDA 	CHN0_RET2_BAK3,		01H
	SHR
	STA 	CHN0_RET2_BAK3,		01H
	
	BNC 	$+3
	LDI 	TBR,			1000B
	ORM 	CHN0_RET1_BAK3,		01H

	LDA 	TEMP_SUM_CY
	SHR
	BNC 	$+3
	LDI 	TBR,			1000B
	ORM 	CHN0_RET2_BAK3,		01H


	;LDA	CHN0_RET0_BAK3,		01H
	;STA	CHN0_FINAL_RET0,		01H
	LDA	CHN0_RET1_BAK3,		01H
	STA	CHN0_FINAL_RET1,	01H
	LDA	CHN0_RET2_BAK3,		01H
	STA	CHN0_FINAL_RET2,	01H

;----------------------------
;����ΪCHN0_FINAL_RET0��ŵ�4λ��CHN0_FINAL_RET1�����4λ��CHN0_FINAL_RET2��Ÿ�2λ
	;LDA 	CHN0_FINAL_RET1,		01H
	;SHR
	;STA 	CHN0_FINAL_RET1,		01H

	;BNC 	$+3
	;LDI 	TBR,			0100B
	;ORM 	CHN0_FINAL_RET0,		01H

	;LDA 	CHN0_FINAL_RET1,		01H
	;SHR
	;STA 	CHN0_FINAL_RET1,		01H	

	;BNC 	$+3
	;LDI 	TBR,			1000B
	;ORM 	CHN0_FINAL_RET0,		01H


	;LDA 	CHN0_FINAL_RET2,		01H
	;SHR
	;STA 	CHN0_FINAL_RET2,		01H	

	;BNC 	$+3
	;LDI 	TBR,			0100B
	;ORM 	CHN0_FINAL_RET1,		01H

	;LDA 	CHN0_FINAL_RET2,		01H
	;SHR
	;STA 	CHN0_FINAL_RET2,		01H	

	;BNC 	$+3
	;LDI 	TBR,			1000B
	;ORM 	CHN0_FINAL_RET1,		01H
	
;----------------------------
CAL_CHN0_ADCDATA_END:	

	RTNI

;*******************************************
; �ӳ���: CAL_CHN1_ADCDATA
; ����: ������ƽ���˲�����N=4��ȥһ�����ֵ��һ����Сֵ��ʣ��������ƽ��ֵ��
;*******************************************
CAL_CHN1_ADCDATA:
	ADI	FLAG_OCCUPIED,		0010B
	BA1	CAL_CHN1_AD_MIN01
	JMP	CAL_CHN1_ADCDATA_END		;����ʹ��ת�����

;----------------------------
;Ѱ����Сֵ
CAL_CHN1_AD_MIN01:	
	LDA 	CHN1_RET1_BAK0,		01H
	SUB 	CHN1_RET1_BAK1,		01H
	LDA 	CHN1_RET2_BAK0,		01H
	SBC 	CHN1_RET2_BAK1,		01H
	BC 	CAL_CHN1_AD_MIN02 		;D0<D1	

CAL_CHN1_AD_MIN12:
	LDA 	CHN1_RET1_BAK1,		01H
	SUB 	CHN1_RET1_BAK2,		01H
	LDA 	CHN1_RET2_BAK1,		01H
	SBC 	CHN1_RET2_BAK2,		01H
	BC 	CAL_CHN1_AD_MIN13 		;D1<D2

CAL_CHN1_AD_MIN23:
	LDA 	CHN1_RET1_BAK2,		01H
	SUB 	CHN1_RET1_BAK3,		01H
	LDA 	CHN1_RET2_BAK2,		01H
	SBC 	CHN1_RET2_BAK3,		01H
	BC 	CAL_CHN1_AD_MIN2 		;D2<D3
	;D3<D2
	JMP 	CAL_CHN1_AD_MIN3

CAL_CHN1_AD_MIN13:
	LDA 	CHN1_RET1_BAK1,		01H
	SUB 	CHN1_RET1_BAK3,		01H
	LDA 	CHN1_RET2_BAK1,		01H
	SBC 	CHN1_RET2_BAK3,		01H
	BC 	CAL_CHN1_AD_MIN1 		;D1<D3
	;D3<D1
	JMP 	CAL_CHN1_AD_MIN3

;D0<D1
CAL_CHN1_AD_MIN02:
	LDA 	CHN1_RET1_BAK0,		01H
	SUB 	CHN1_RET1_BAK2,		01H
	LDA 	CHN1_RET2_BAK0,		01H
	SBC 	CHN1_RET2_BAK2,		01H
	BC 	CAL_CHN1_AD_MIN03 		;D0<D2
	;D3<D1
	JMP 	CAL_CHN1_AD_MIN23

;D0<D2
CAL_CHN1_AD_MIN03:
	LDA 	CHN1_RET1_BAK0,		01H
	SUB 	CHN1_RET1_BAK3,		01H
	LDA 	CHN1_RET2_BAK0,		01H
	SBC 	CHN1_RET2_BAK3,		01H
	BC 	CAL_CHN1_AD_MIN0 		;D0<D3
	;D3<D0
	JMP 	CAL_CHN1_AD_MIN3

;-----------------------
;����Сֵ����
CAL_CHN1_AD_MIN0:
	LDI 	TBR,			00H
	STA 	CHN1_RET0_BAK0,		01H
	STA 	CHN1_RET1_BAK0,		01H
	STA 	CHN1_RET2_BAK0,		01H
	JMP 	CAL_CHN1_AD_MAX01

CAL_CHN1_AD_MIN1:
	LDI 	TBR,			00H
	STA 	CHN1_RET0_BAK1,		01H
	STA 	CHN1_RET1_BAK1,		01H
	STA 	CHN1_RET2_BAK1,		01H
	JMP 	CAL_CHN1_AD_MAX01

CAL_CHN1_AD_MIN2:
	LDI 	TBR,			00H
	STA 	CHN1_RET0_BAK2,		01H
	STA 	CHN1_RET1_BAK2,		01H
	STA 	CHN1_RET2_BAK2,		01H
	JMP 	CAL_CHN1_AD_MAX01

CAL_CHN1_AD_MIN3:
	LDI 	TBR,			00H
	STA 	CHN1_RET0_BAK3,		01H
	STA 	CHN1_RET1_BAK3,		01H
	STA 	CHN1_RET2_BAK3,		01H
	JMP 	CAL_CHN1_AD_MAX01

;----------------------------
;Ѱ�����ֵ
CAL_CHN1_AD_MAX01:
	LDA 	CHN1_RET1_BAK0,		01H
	SUB 	CHN1_RET1_BAK1,		01H
	LDA 	CHN1_RET2_BAK0,		01H
	SBC 	CHN1_RET2_BAK1,		01H
	BC 	CAL_CHN1_AD_MAX12 		;D1>D0

;D0>D1
CAL_CHN1_AD_MAX02:
	LDA 	CHN1_RET1_BAK0,		01H
	SUB 	CHN1_RET1_BAK2,		01H
	LDA 	CHN1_RET2_BAK0,		01H
	SBC 	CHN1_RET2_BAK2,		01H
	BC 	CAL_CHN1_AD_MAX23 		;D2>D0

;D0>D2
CAL_CHN1_AD_MAX03:
	LDA 	CHN1_RET1_BAK0,		01H
	SUB 	CHN1_RET1_BAK3,		01H
	LDA 	CHN1_RET2_BAK0,		01H
	SBC 	CHN1_RET2_BAK3,		01H
	BC 	CAL_CHN1_AD_MAX3 		;D3>D0
	;D0>D3
	JMP 	CAL_CHN1_AD_MAX0

;D2>D0
CAL_CHN1_AD_MAX23:
	LDA 	CHN1_RET1_BAK2,		01H
	SUB 	CHN1_RET1_BAK3,		01H
	LDA 	CHN1_RET2_BAK2,		01H
	SBC 	CHN1_RET2_BAK3,		01H
	BC 	CAL_CHN1_AD_MAX3 		;D3>D2
	;D2>D3
	JMP 	CAL_CHN1_AD_MAX2

;D1>D0
CAL_CHN1_AD_MAX12:
	LDA 	CHN1_RET1_BAK1,		01H
	SUB 	CHN1_RET1_BAK2,		01H
	LDA 	CHN1_RET2_BAK1,		01H
	SBC 	CHN1_RET2_BAK2,		01H
	BC 	CAL_CHN1_AD_MAX23 		;D2>D1

;D1>D2
CAL_CHN1_AD_MAX13:
	LDA 	CHN1_RET1_BAK1,		01H
	SUB 	CHN1_RET1_BAK3,		01H
	LDA 	CHN1_RET2_BAK1,		01H
	SBC 	CHN1_RET2_BAK3,		01H
	BC 	CAL_CHN1_AD_MAX3 		;D3>D1
	;D1>D3
	JMP 	CAL_CHN1_AD_MAX1

;-----------------------
;�����ֵ����
CAL_CHN1_AD_MAX0:
	LDI 	TBR,			00H
	STA 	CHN1_RET0_BAK0,		01H
	STA 	CHN1_RET1_BAK0,		01H
	STA 	CHN1_RET2_BAK0,		01H
	JMP 	CAL_CHN1_AD_ADD

CAL_CHN1_AD_MAX1:
	LDI 	TBR,			00H
	STA 	CHN1_RET0_BAK1,		01H
	STA 	CHN1_RET1_BAK1,		01H
	STA 	CHN1_RET2_BAK1,		01H
	JMP 	CAL_CHN1_AD_ADD

CAL_CHN1_AD_MAX2:
	LDI 	TBR,			00H
	STA 	CHN1_RET0_BAK2,		01H
	STA 	CHN1_RET1_BAK2,		01H
	STA 	CHN1_RET2_BAK2,		01H
	JMP 	CAL_CHN1_AD_ADD

CAL_CHN1_AD_MAX3:
	LDI 	TBR,			00H
	STA 	CHN1_RET0_BAK3,		01H
	STA 	CHN1_RET1_BAK3,		01H
	STA 	CHN1_RET2_BAK3,		01H
	JMP 	CAL_CHN1_AD_ADD

;----------------------------
;�����ܺͲ������CHN1_RET0_BAK3,CHN1_RET1_BAK3 ��CHN1_RET2_BAK3����������������ģ�
CAL_CHN1_AD_ADD:
	LDI 	TEMP_SUM_CY,		00H

	;D0 + D1
	;LDA 	CHN1_RET0_BAK0,		01H
	;ADDM 	CHN1_RET0_BAK1,		01H
	LDA 	CHN1_RET1_BAK0,		01H
	ADDM 	CHN1_RET1_BAK1,		01H
	LDA 	CHN1_RET2_BAK0,		01H
	ADCM 	CHN1_RET2_BAK1,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

	;+ D2
	;LDA 	CHN1_RET0_BAK1,		01H
	;ADDM 	CHN1_RET0_BAK2,		01H
	LDA 	CHN1_RET1_BAK1,		01H
	ADDM 	CHN1_RET1_BAK2,		01H
	LDA 	CHN1_RET2_BAK1,		01H
	ADCM 	CHN1_RET2_BAK2,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

	;+ D3
	;LDA 	CHN1_RET0_BAK2,		01H
	;ADDM 	CHN1_RET0_BAK3,		01H
	LDA 	CHN1_RET1_BAK2,		01H
	ADDM 	CHN1_RET1_BAK3,		01H
	LDA 	CHN1_RET2_BAK2,		01H
	ADCM 	CHN1_RET2_BAK3,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

;----------------------------
;�ܺͳ���2���õ�ƽ��ֵ�������CHN1_FINAL_RET0(),CHN1_FINAL_RET1 ��CHN1_FINAL_RET2
CAL_CHN1_AD_DIV:
	;LDA 	CHN1_RET0_BAK3,		01H
	;SHR
	;STA 	CHN1_RET0_BAK3,		01H
	
	LDA 	CHN1_RET1_BAK3,		01H
	SHR
	STA 	CHN1_RET1_BAK3,		01H
	
	;BNC 	$+3
	;LDI 	TBR,			0010B
	;ORM 	CHN1_RET0_BAK3

	LDA 	CHN1_RET2_BAK3,		01H
	SHR
	STA 	CHN1_RET2_BAK3,		01H
	
	BNC 	$+3
	LDI 	TBR,			1000B
	ORM 	CHN1_RET1_BAK3,		01H

	LDA 	TEMP_SUM_CY
	SHR
	BNC 	$+3
	LDI 	TBR,			1000B
	ORM 	CHN1_RET2_BAK3,		01H


	;LDA	CHN1_RET0_BAK3,		01H
	;STA	CHN1_FINAL_RET0,		01H
	LDA	CHN1_RET1_BAK3,		01H
	STA	CHN1_FINAL_RET1,	01H
	LDA	CHN1_RET2_BAK3,		01H
	STA	CHN1_FINAL_RET2,	01H

;----------------------------
;����ΪCHN1_FINAL_RET0��ŵ�4λ��CHN1_FINAL_RET1�����4λ��CHN1_FINAL_RET2��Ÿ�2λ
	;LDA 	CHN1_FINAL_RET1,		01H
	;SHR
	;STA 	CHN1_FINAL_RET1,		01H

	;BNC 	$+3
	;LDI 	TBR,			0100B
	;ORM 	CHN1_FINAL_RET0,		01H

	;LDA 	CHN1_FINAL_RET1,		01H
	;SHR
	;STA 	CHN1_FINAL_RET1,		01H	

	;BNC 	$+3
	;LDI 	TBR,			1000B
	;ORM 	CHN1_FINAL_RET0,		01H


	;LDA 	CHN1_FINAL_RET2,		01H
	;SHR
	;STA 	CHN1_FINAL_RET2,		01H	

	;BNC 	$+3
	;LDI 	TBR,			0100B
	;ORM 	CHN1_FINAL_RET1,		01H

	;LDA 	CHN1_FINAL_RET2,		01H
	;SHR
	;STA 	CHN1_FINAL_RET2,		01H	

	;BNC 	$+3
	;LDI 	TBR,			1000B
	;ORM 	CHN1_FINAL_RET1,		01H
	
;----------------------------
CAL_CHN1_ADCDATA_END:	

	RTNI


;*******************************************
; �ӳ���: CAL_CHN6_ADCDATA
; ����: ������ƽ���˲�����N=4��ȥһ�����ֵ��һ����Сֵ��ʣ��������ƽ��ֵ��
;*******************************************
CAL_CHN6_ADCDATA:
	ADI	FLAG_OCCUPIED,		0100B
	BA2	CAL_CHN6_AD_MIN01
	JMP	CAL_CHN6_ADCDATA_END		;����ʹ��ת�����
	
;----------------------------
;Ѱ����Сֵ
CAL_CHN6_AD_MIN01:	
	LDA 	CHN6_RET1_BAK0,		01H
	SUB 	CHN6_RET1_BAK1,		01H
	LDA 	CHN6_RET2_BAK0,		01H
	SBC 	CHN6_RET2_BAK1,		01H
	BC 	CAL_CHN6_AD_MIN02 		;D0<D1	

CAL_CHN6_AD_MIN12:
	LDA 	CHN6_RET1_BAK1,		01H
	SUB 	CHN6_RET1_BAK2,		01H
	LDA 	CHN6_RET2_BAK1,		01H
	SBC 	CHN6_RET2_BAK2,		01H
	BC 	CAL_CHN6_AD_MIN13 		;D1<D2

CAL_CHN6_AD_MIN23:
	LDA 	CHN6_RET1_BAK2,		01H
	SUB 	CHN6_RET1_BAK3,		01H
	LDA 	CHN6_RET2_BAK2,		01H
	SBC 	CHN6_RET2_BAK3,		01H
	BC 	CAL_CHN6_AD_MIN2 		;D2<D3
	;D3<D2
	JMP 	CAL_CHN6_AD_MIN3

CAL_CHN6_AD_MIN13:
	LDA 	CHN6_RET1_BAK1,		01H
	SUB 	CHN6_RET1_BAK3,		01H
	LDA 	CHN6_RET2_BAK1,		01H
	SBC 	CHN6_RET2_BAK3,		01H
	BC 	CAL_CHN6_AD_MIN1 		;D1<D3
	;D3<D1
	JMP 	CAL_CHN6_AD_MIN3

;D0<D1
CAL_CHN6_AD_MIN02:
	LDA 	CHN6_RET1_BAK0,		01H
	SUB 	CHN6_RET1_BAK2,		01H
	LDA 	CHN6_RET2_BAK0,		01H
	SBC 	CHN6_RET2_BAK2,		01H
	BC 	CAL_CHN6_AD_MIN03 		;D0<D2
	;D3<D1
	JMP 	CAL_CHN6_AD_MIN23

;D0<D2
CAL_CHN6_AD_MIN03:
	LDA 	CHN6_RET1_BAK0,		01H
	SUB 	CHN6_RET1_BAK3,		01H
	LDA 	CHN6_RET2_BAK0,		01H
	SBC 	CHN6_RET2_BAK3,		01H
	BC 	CAL_CHN6_AD_MIN0 		;D0<D3
	;D3<D0
	JMP 	CAL_CHN6_AD_MIN3

;-----------------------
;����Сֵ����
CAL_CHN6_AD_MIN0:
	LDI 	TBR,			00H
	STA 	CHN6_RET0_BAK0,		01H
	STA 	CHN6_RET1_BAK0,		01H
	STA 	CHN6_RET2_BAK0,		01H
	JMP 	CAL_CHN6_AD_MAX01

CAL_CHN6_AD_MIN1:
	LDI 	TBR,			00H
	STA 	CHN6_RET0_BAK1,		01H
	STA 	CHN6_RET1_BAK1,		01H
	STA 	CHN6_RET2_BAK1,		01H
	JMP 	CAL_CHN6_AD_MAX01

CAL_CHN6_AD_MIN2:
	LDI 	TBR,			00H
	STA 	CHN6_RET0_BAK2,		01H
	STA 	CHN6_RET1_BAK2,		01H
	STA 	CHN6_RET2_BAK2,		01H
	JMP 	CAL_CHN6_AD_MAX01

CAL_CHN6_AD_MIN3:
	LDI 	TBR,			00H
	STA 	CHN6_RET0_BAK3,		01H
	STA 	CHN6_RET1_BAK3,		01H
	STA 	CHN6_RET2_BAK3,		01H
	JMP 	CAL_CHN6_AD_MAX01

;----------------------------
;Ѱ�����ֵ
CAL_CHN6_AD_MAX01:
	LDA 	CHN6_RET1_BAK0,		01H
	SUB 	CHN6_RET1_BAK1,		01H
	LDA 	CHN6_RET2_BAK0,		01H
	SBC 	CHN6_RET2_BAK1,		01H
	BC 	CAL_CHN6_AD_MAX12 		;D1>D0

;D0>D1
CAL_CHN6_AD_MAX02:
	LDA 	CHN6_RET1_BAK0,		01H
	SUB 	CHN6_RET1_BAK2,		01H
	LDA 	CHN6_RET2_BAK0,		01H
	SBC 	CHN6_RET2_BAK2,		01H
	BC 	CAL_CHN6_AD_MAX23 		;D2>D0

;D0>D2
CAL_CHN6_AD_MAX03:
	LDA 	CHN6_RET1_BAK0,		01H
	SUB 	CHN6_RET1_BAK3,		01H
	LDA 	CHN6_RET2_BAK0,		01H
	SBC 	CHN6_RET2_BAK3,		01H
	BC 	CAL_CHN6_AD_MAX3 		;D3>D0
	;D0>D3
	JMP 	CAL_CHN6_AD_MAX0

;D2>D0
CAL_CHN6_AD_MAX23:
	LDA 	CHN6_RET1_BAK2,		01H
	SUB 	CHN6_RET1_BAK3,		01H
	LDA 	CHN6_RET2_BAK2,		01H
	SBC 	CHN6_RET2_BAK3,		01H
	BC 	CAL_CHN6_AD_MAX3 		;D3>D2
	;D2>D3
	JMP 	CAL_CHN6_AD_MAX2

;D1>D0
CAL_CHN6_AD_MAX12:
	LDA 	CHN6_RET1_BAK1,		01H
	SUB 	CHN6_RET1_BAK2,		01H
	LDA 	CHN6_RET2_BAK1,		01H
	SBC 	CHN6_RET2_BAK2,		01H
	BC 	CAL_CHN6_AD_MAX23 		;D2>D1

;D1>D2
CAL_CHN6_AD_MAX13:
	LDA 	CHN6_RET1_BAK1,		01H
	SUB 	CHN6_RET1_BAK3,		01H
	LDA 	CHN6_RET2_BAK1,		01H
	SBC 	CHN6_RET2_BAK3,		01H
	BC 	CAL_CHN6_AD_MAX3 		;D3>D1
	;D1>D3
	JMP 	CAL_CHN6_AD_MAX1

;-----------------------
;�����ֵ����
CAL_CHN6_AD_MAX0:
	LDI 	TBR,			00H
	STA 	CHN6_RET0_BAK0,		01H
	STA 	CHN6_RET1_BAK0,		01H
	STA 	CHN6_RET2_BAK0,		01H
	JMP 	CAL_CHN6_AD_ADD

CAL_CHN6_AD_MAX1:
	LDI 	TBR,			00H
	STA 	CHN6_RET0_BAK1,		01H
	STA 	CHN6_RET1_BAK1,		01H
	STA 	CHN6_RET2_BAK1,		01H
	JMP 	CAL_CHN6_AD_ADD

CAL_CHN6_AD_MAX2:
	LDI 	TBR,			00H
	STA 	CHN6_RET0_BAK2,		01H
	STA 	CHN6_RET1_BAK2,		01H
	STA 	CHN6_RET2_BAK2,		01H
	JMP 	CAL_CHN6_AD_ADD

CAL_CHN6_AD_MAX3:
	LDI 	TBR,			00H
	STA 	CHN6_RET0_BAK3,		01H
	STA 	CHN6_RET1_BAK3,		01H
	STA 	CHN6_RET2_BAK3,		01H
	JMP 	CAL_CHN6_AD_ADD

;----------------------------
;�����ܺͲ������CHN6_RET0_BAK3,CHN6_RET1_BAK3 ��CHN6_RET2_BAK3����������������ģ�
CAL_CHN6_AD_ADD:
	LDI 	TEMP_SUM_CY,		00H

	;D0 + D1
	;LDA 	CHN6_RET0_BAK0,		01H
	;ADDM 	CHN6_RET0_BAK1,		01H
	LDA 	CHN6_RET1_BAK0,		01H
	ADDM 	CHN6_RET1_BAK1,		01H
	LDA 	CHN6_RET2_BAK0,		01H
	ADCM 	CHN6_RET2_BAK1,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

	;+ D2
	;LDA 	CHN6_RET0_BAK1,		01H
	;ADDM 	CHN6_RET0_BAK2,		01H
	LDA 	CHN6_RET1_BAK1,		01H
	ADDM 	CHN6_RET1_BAK2,		01H
	LDA 	CHN6_RET2_BAK1,		01H
	ADCM 	CHN6_RET2_BAK2,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

	;+ D3
	;LDA 	CHN6_RET0_BAK2,		01H
	;ADDM 	CHN6_RET0_BAK3,		01H
	LDA 	CHN6_RET1_BAK2,		01H
	ADDM 	CHN6_RET1_BAK3,		01H
	LDA 	CHN6_RET2_BAK2,		01H
	ADCM 	CHN6_RET2_BAK3,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

;----------------------------
;�ܺͳ���2���õ�ƽ��ֵ�������CHN6_FINAL_RET0(),CHN6_FINAL_RET1 ��CHN6_FINAL_RET2
CAL_CHN6_AD_DIV:
	;LDA 	CHN6_RET0_BAK3,		01H
	;SHR
	;STA 	CHN6_RET0_BAK3,		01H
	
	LDA 	CHN6_RET1_BAK3,		01H
	SHR
	STA 	CHN6_RET1_BAK3,		01H
	
	;BNC 	$+3
	;LDI 	TBR,			0010B
	;ORM 	CHN6_RET0_BAK3

	LDA 	CHN6_RET2_BAK3,		01H
	SHR
	STA 	CHN6_RET2_BAK3,		01H
	
	BNC 	$+3
	LDI 	TBR,			1000B
	ORM 	CHN6_RET1_BAK3,		01H

	LDA 	TEMP_SUM_CY
	SHR
	BNC 	$+3
	LDI 	TBR,			1000B
	ORM 	CHN6_RET2_BAK3,		01H


	;LDA	CHN6_RET0_BAK3,		01H
	;STA	CHN6_FINAL_RET0,		01H
	LDA	CHN6_RET1_BAK3,		01H
	STA	CHN6_FINAL_RET1,	01H
	LDA	CHN6_RET2_BAK3,		01H
	STA	CHN6_FINAL_RET2,	01H

;----------------------------
;����ΪCHN6_FINAL_RET0��ŵ�4λ��CHN6_FINAL_RET1�����4λ��CHN6_FINAL_RET2��Ÿ�2λ
	;LDA 	CHN6_FINAL_RET1,		01H
	;SHR
	;STA 	CHN6_FINAL_RET1,		01H

	;BNC 	$+3
	;LDI 	TBR,			0100B
	;ORM 	CHN6_FINAL_RET0,		01H

	;LDA 	CHN6_FINAL_RET1,		01H
	;SHR
	;STA 	CHN6_FINAL_RET1,		01H	

	;BNC 	$+3
	;LDI 	TBR,			1000B
	;ORM 	CHN6_FINAL_RET0,		01H


	;LDA 	CHN6_FINAL_RET2,		01H
	;SHR
	;STA 	CHN6_FINAL_RET2,		01H	

	;BNC 	$+3
	;LDI 	TBR,			0100B
	;ORM 	CHN6_FINAL_RET1,		01H

	;LDA 	CHN6_FINAL_RET2,		01H
	;SHR
	;STA 	CHN6_FINAL_RET2,		01H	

	;BNC 	$+3
	;LDI 	TBR,			1000B
	;ORM 	CHN6_FINAL_RET1,		01H
	
;----------------------------
CAL_CHN6_ADCDATA_END:	

	RTNI


;*******************************************
; �ӳ���: CAL_CHN7_ADCDATA
; ����: ������ƽ���˲�����N=4��ȥһ�����ֵ��һ����Сֵ��ʣ��������ƽ��ֵ��
;*******************************************
CAL_CHN7_ADCDATA:
	ADI	FLAG_OCCUPIED,		1000B
	BA3	CAL_CHN7_AD_MIN01
	JMP	CAL_CHN7_ADCDATA_END		;����ʹ��ת�����

;----------------------------
;Ѱ����Сֵ
CAL_CHN7_AD_MIN01:	
	LDA 	CHN7_RET1_BAK0,		01H
	SUB 	CHN7_RET1_BAK1,		01H
	LDA 	CHN7_RET2_BAK0,		01H
	SBC 	CHN7_RET2_BAK1,		01H
	BC 	CAL_CHN7_AD_MIN02 		;D0<D1	

CAL_CHN7_AD_MIN12:
	LDA 	CHN7_RET1_BAK1,		01H
	SUB 	CHN7_RET1_BAK2,		01H
	LDA 	CHN7_RET2_BAK1,		01H
	SBC 	CHN7_RET2_BAK2,		01H
	BC 	CAL_CHN7_AD_MIN13 		;D1<D2

CAL_CHN7_AD_MIN23:
	LDA 	CHN7_RET1_BAK2,		01H
	SUB 	CHN7_RET1_BAK3,		01H
	LDA 	CHN7_RET2_BAK2,		01H
	SBC 	CHN7_RET2_BAK3,		01H
	BC 	CAL_CHN7_AD_MIN2 		;D2<D3
	;D3<D2
	JMP 	CAL_CHN7_AD_MIN3

CAL_CHN7_AD_MIN13:
	LDA 	CHN7_RET1_BAK1,		01H
	SUB 	CHN7_RET1_BAK3,		01H
	LDA 	CHN7_RET2_BAK1,		01H
	SBC 	CHN7_RET2_BAK3,		01H
	BC 	CAL_CHN7_AD_MIN1 		;D1<D3
	;D3<D1
	JMP 	CAL_CHN7_AD_MIN3

;D0<D1
CAL_CHN7_AD_MIN02:
	LDA 	CHN7_RET1_BAK0,		01H
	SUB 	CHN7_RET1_BAK2,		01H
	LDA 	CHN7_RET2_BAK0,		01H
	SBC 	CHN7_RET2_BAK2,		01H
	BC 	CAL_CHN7_AD_MIN03 		;D0<D2
	;D3<D1
	JMP 	CAL_CHN7_AD_MIN23

;D0<D2
CAL_CHN7_AD_MIN03:
	LDA 	CHN7_RET1_BAK0,		01H
	SUB 	CHN7_RET1_BAK3,		01H
	LDA 	CHN7_RET2_BAK0,		01H
	SBC 	CHN7_RET2_BAK3,		01H
	BC 	CAL_CHN7_AD_MIN0 		;D0<D3
	;D3<D0
	JMP 	CAL_CHN7_AD_MIN3

;-----------------------
;����Сֵ����
CAL_CHN7_AD_MIN0:
	LDI 	TBR,			00H
	STA 	CHN7_RET0_BAK0,		01H
	STA 	CHN7_RET1_BAK0,		01H
	STA 	CHN7_RET2_BAK0,		01H
	JMP 	CAL_CHN7_AD_MAX01

CAL_CHN7_AD_MIN1:
	LDI 	TBR,			00H
	STA 	CHN7_RET0_BAK1,		01H
	STA 	CHN7_RET1_BAK1,		01H
	STA 	CHN7_RET2_BAK1,		01H
	JMP 	CAL_CHN7_AD_MAX01

CAL_CHN7_AD_MIN2:
	LDI 	TBR,			00H
	STA 	CHN7_RET0_BAK2,		01H
	STA 	CHN7_RET1_BAK2,		01H
	STA 	CHN7_RET2_BAK2,		01H
	JMP 	CAL_CHN7_AD_MAX01

CAL_CHN7_AD_MIN3:
	LDI 	TBR,			00H
	STA 	CHN7_RET0_BAK3,		01H
	STA 	CHN7_RET1_BAK3,		01H
	STA 	CHN7_RET2_BAK3,		01H
	JMP 	CAL_CHN7_AD_MAX01

;----------------------------
;Ѱ�����ֵ
CAL_CHN7_AD_MAX01:
	LDA 	CHN7_RET1_BAK0,		01H
	SUB 	CHN7_RET1_BAK1,		01H
	LDA 	CHN7_RET2_BAK0,		01H
	SBC 	CHN7_RET2_BAK1,		01H
	BC 	CAL_CHN7_AD_MAX12 		;D1>D0

;D0>D1
CAL_CHN7_AD_MAX02:
	LDA 	CHN7_RET1_BAK0,		01H
	SUB 	CHN7_RET1_BAK2,		01H
	LDA 	CHN7_RET2_BAK0,		01H
	SBC 	CHN7_RET2_BAK2,		01H
	BC 	CAL_CHN7_AD_MAX23 		;D2>D0

;D0>D2
CAL_CHN7_AD_MAX03:
	LDA 	CHN7_RET1_BAK0,		01H
	SUB 	CHN7_RET1_BAK3,		01H
	LDA 	CHN7_RET2_BAK0,		01H
	SBC 	CHN7_RET2_BAK3,		01H
	BC 	CAL_CHN7_AD_MAX3 		;D3>D0
	;D0>D3
	JMP 	CAL_CHN7_AD_MAX0

;D2>D0
CAL_CHN7_AD_MAX23:
	LDA 	CHN7_RET1_BAK2,		01H
	SUB 	CHN7_RET1_BAK3,		01H
	LDA 	CHN7_RET2_BAK2,		01H
	SBC 	CHN7_RET2_BAK3,		01H
	BC 	CAL_CHN7_AD_MAX3 		;D3>D2
	;D2>D3
	JMP 	CAL_CHN7_AD_MAX2

;D1>D0
CAL_CHN7_AD_MAX12:
	LDA 	CHN7_RET1_BAK1,		01H
	SUB 	CHN7_RET1_BAK2,		01H
	LDA 	CHN7_RET2_BAK1,		01H
	SBC 	CHN7_RET2_BAK2,		01H
	BC 	CAL_CHN7_AD_MAX23 		;D2>D1

;D1>D2
CAL_CHN7_AD_MAX13:
	LDA 	CHN7_RET1_BAK1,		01H
	SUB 	CHN7_RET1_BAK3,		01H
	LDA 	CHN7_RET2_BAK1,		01H
	SBC 	CHN7_RET2_BAK3,		01H
	BC 	CAL_CHN7_AD_MAX3 		;D3>D1
	;D1>D3
	JMP 	CAL_CHN7_AD_MAX1

;-----------------------
;�����ֵ����
CAL_CHN7_AD_MAX0:
	LDI 	TBR,			00H
	STA 	CHN7_RET0_BAK0,		01H
	STA 	CHN7_RET1_BAK0,		01H
	STA 	CHN7_RET2_BAK0,		01H
	JMP 	CAL_CHN7_AD_ADD

CAL_CHN7_AD_MAX1:
	LDI 	TBR,			00H
	STA 	CHN7_RET0_BAK1,		01H
	STA 	CHN7_RET1_BAK1,		01H
	STA 	CHN7_RET2_BAK1,		01H
	JMP 	CAL_CHN7_AD_ADD

CAL_CHN7_AD_MAX2:
	LDI 	TBR,			00H
	STA 	CHN7_RET0_BAK2,		01H
	STA 	CHN7_RET1_BAK2,		01H
	STA 	CHN7_RET2_BAK2,		01H
	JMP 	CAL_CHN7_AD_ADD

CAL_CHN7_AD_MAX3:
	LDI 	TBR,			00H
	STA 	CHN7_RET0_BAK3,		01H
	STA 	CHN7_RET1_BAK3,		01H
	STA 	CHN7_RET2_BAK3,		01H
	JMP 	CAL_CHN7_AD_ADD

;----------------------------
;�����ܺͲ������CHN7_RET0_BAK3,CHN7_RET1_BAK3 ��CHN7_RET2_BAK3����������������ģ�
CAL_CHN7_AD_ADD:
	LDI 	TEMP_SUM_CY,		00H

	;D0 + D1
	;LDA 	CHN7_RET0_BAK0,		01H
	;ADDM 	CHN7_RET0_BAK1,		01H
	LDA 	CHN7_RET1_BAK0,		01H
	ADDM 	CHN7_RET1_BAK1,		01H
	LDA 	CHN7_RET2_BAK0,		01H
	ADCM 	CHN7_RET2_BAK1,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

	;+ D2
	;LDA 	CHN7_RET0_BAK1,		01H
	;ADDM 	CHN7_RET0_BAK2,		01H
	LDA 	CHN7_RET1_BAK1,		01H
	ADDM 	CHN7_RET1_BAK2,		01H
	LDA 	CHN7_RET2_BAK1,		01H
	ADCM 	CHN7_RET2_BAK2,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

	;+ D3
	;LDA 	CHN7_RET0_BAK2,		01H
	;ADDM 	CHN7_RET0_BAK3,		01H
	LDA 	CHN7_RET1_BAK2,		01H
	ADDM 	CHN7_RET1_BAK3,		01H
	LDA 	CHN7_RET2_BAK2,		01H
	ADCM 	CHN7_RET2_BAK3,		01H
	LDI 	TBR,			00H
	ADCM 	TEMP_SUM_CY

;----------------------------
;�ܺͳ���2���õ�ƽ��ֵ�������CHN7_FINAL_RET0(),CHN7_FINAL_RET1 ��CHN7_FINAL_RET2
CAL_CHN7_AD_DIV:
	;LDA 	CHN7_RET0_BAK3,		01H
	;SHR
	;STA 	CHN7_RET0_BAK3,		01H
	
	LDA 	CHN7_RET1_BAK3,		01H
	SHR
	STA 	CHN7_RET1_BAK3,		01H
	
	;BNC 	$+3
	;LDI 	TBR,			0010B
	;ORM 	CHN7_RET0_BAK3

	LDA 	CHN7_RET2_BAK3,		01H
	SHR
	STA 	CHN7_RET2_BAK3,		01H
	
	BNC 	$+3
	LDI 	TBR,			1000B
	ORM 	CHN7_RET1_BAK3,		01H

	LDA 	TEMP_SUM_CY
	SHR
	BNC 	$+3
	LDI 	TBR,			1000B
	ORM 	CHN7_RET2_BAK3,		01H


	;LDA	CHN7_RET0_BAK3,		01H
	;STA	CHN7_FINAL_RET0,		01H
	LDA	CHN7_RET1_BAK3,		01H
	STA	CHN7_FINAL_RET1,	01H
	LDA	CHN7_RET2_BAK3,		01H
	STA	CHN7_FINAL_RET2,	01H

;----------------------------
;����ΪCHN7_FINAL_RET0��ŵ�4λ��CHN7_FINAL_RET1�����4λ��CHN7_FINAL_RET2��Ÿ�2λ
	;LDA 	CHN7_FINAL_RET1,		01H
	;SHR
	;STA 	CHN7_FINAL_RET1,		01H

	;BNC 	$+3
	;LDI 	TBR,			0100B
	;ORM 	CHN7_FINAL_RET0,		01H

	;LDA 	CHN7_FINAL_RET1,		01H
	;SHR
	;STA 	CHN7_FINAL_RET1,		01H	

	;BNC 	$+3
	;LDI 	TBR,			1000B
	;ORM 	CHN7_FINAL_RET0,		01H


	;LDA 	CHN7_FINAL_RET2,		01H
	;SHR
	;STA 	CHN7_FINAL_RET2,		01H	

	;BNC 	$+3
	;LDI 	TBR,			0100B
	;ORM 	CHN7_FINAL_RET1,		01H

	;LDA 	CHN7_FINAL_RET2,		01H
	;SHR
	;STA 	CHN7_FINAL_RET2,		01H	

	;BNC 	$+3
	;LDI 	TBR,			1000B
	;ORM 	CHN7_FINAL_RET1,		01H
	
;----------------------------
CAL_CHN7_ADCDATA_END:	

	RTNI

	
	END

	