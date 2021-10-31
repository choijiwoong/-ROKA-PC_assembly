global _dmax

segment .text
;function _damx-> return big double
;origin C: dobule dmax(double d1, double d2)
;arguments:
;	d1 first doble
;	d2 second double
;return:
;	bigger double by ST0
%define d1 ebp+8
%define d2 ebp+16;double

_dmax:
	enter 0,0
	
	fld qword [d2]
	fld qword [d1];ST0=d1, ST1=d2
	fcomip st1;ST0=d2
	jna short d2_bigger
	fcomp st0;pop d2
	fld qword [d1]; ST0=d1
	jmp short exit
d2_bigger: ;if d2 is bigger, noting to work!
exit:
	leave ret