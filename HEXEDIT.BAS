cls
call OpngScrn
call InputFilename(filename$)
cls
color 15,1:print " HEX EDITOR(R) WormGuy (C)Copyright WormGuy 2000-2001. V1.29.8928, 07-28-2000 "

sub OpngScrn
	screen 0
	for w = 2 to 79
		locate 1,w:print chr$(196)
		locate 2,w:print chr$(205)
		locate 1,1:print chr$(214)
		locate 1,80:print chr$(183)
		locate 2,1:print chr$(200)
		locate 2,80:print chr$(188)
	next w
	for gl = 1 to 15
		read FE$
		color 15:locate 1,3:print "[ "
		color 8:locate 1,4+gl:print FE$
		color 15:locate 1,5+gl:print "]"
		delay .05
		color 7:locate 1,4+gl:print FE$
		delay .05
		color 15:locate 1,4+gl:print FE$
		delay .05
	next gl
	for wy = 1 to 19
		read worm$
		for wx = 1 to 31
			color val(mid$(worm$,wx,1)):locate wy+3,wx:print chr$(219)
			if mid$(worm$,wx,1) = "e" then color 14:locate wy+3,wx:print chr$(219)
		next wx
	next wy
	color 2:locate 6,2:print "CREATED BY THE"
	color 15:locate 6,36:print "Version 1.29.8929"
	locate 7,36:print "Date Released 07-28-2000"
	locate 8,36:print "e-mail me : WORMGUY17@YAHOO.COM"
	locate 12,36:print "HE (r) Copyright 2000-2001 Jayson Ragasa,"
	locate 13,36:print "Philippines. All rights reserved."
	locate 17,36:print "Credits... [ Press '1'... ]
	locate 22,36:print "Press any key...."
	a$=input$(1)
	if a$ = "1" then Call Credits
end sub

data "F","I","L","E"," ","E","D","I","T","O","R",".",".","."," "
data "                       2222    "
data "                      22ee222  "
data "                      2eeeeee22"
data " 2   2                2eeeeeee2"
data " 2 2 2 22   22 2222   2e2eee2e2"
data " 22222 2 2 2   2 2 2  2eeeeeee2"
data "  2 2  222 2   2 2 2  2e2eeeee2"
data "                      2e2222ee2"
data "     22   2 2 2 2     2eeeeeee2"
data "     2  2 2 2  2     22eeeeeee2"
data "     2222 22   2    222eeeeeee2"
data "                   22e22eeeeee2"
data "      22222222222222eee22eeee22"
data "    222e2eeee2eeee2eeeee2222222"
data "    2eee2eeee2eeeee2eeeeeeee2  "
data "    22ee2eeee2eeeee22eeeeeee2  "
data "     22e2eeee22eeeee22eeee222  "
data "      222eeeeee222222222222    "
data "         222222                "


sub InputFilename(filename$)
	cls
	width 80
	color 7
	for w = 2 to 79
		locate 1,w:print chr$(196)
		locate 2,w:print chr$(205)
		locate 1,1:print chr$(214)
		locate 1,80:print chr$(183)
		locate 2,1:print chr$(200)
		locate 2,80:print chr$(188)
	next w
	color 15:locate 1,3:print "[ Filename :                                                                ]"
	locate 1,16:input "",Filename$
	if filename$ = "" then
			call InputFilename(filename$)
		elseif ucase$(filename$) = "EXIT" then
			cls
			color 15,1:print " HEX EDITOR(R) WormGuy (C)Copyright WormGuy 2000-2001. V1.29.8928, 07-28-2000 "
			end
			
	end if
	call CheckFile(filename$)
end sub

sub CheckFile(filename$)
open filename$ for binary as #1
		if lof(1) = 0 then
				locate 1,3:print "[ File not found!                                                           ]"
				kill filename$
				delay 1
				color 15:locate 1,3:print "[ Filename :                                                                ]"
				locate 1,16:input "",filename$
				close #1
				call CheckFile(filename$)
			else
				close #1
				call LoadChar(filename$)
		end if
		call LoadChar(filename$)
	close #1
end sub

sub LoadChar(filename$)
	call WindowGrafix
	color 15,0
	open filename$ for binary as #1
		b = 0
		call Seeker(b)
		do until opt$ = chr$(27)
			locate 21,77-21:print "["time$"]-["date$"]"
			opt$ = inkey$
			if opt$ = chr$(0) + chr$(80) then
					locate 7,79:color 7:print chr$(25):color 15
					call Seeker(b)
					b = b + 16
					if b >= lof(1) then b = lof(1) - 258
				elseif opt$ = chr$(0) + chr$(72) then
					locate 6,79:color 7:print chr$(24):color 15
					if b = 0 then b = 16
					call Seeker(b-16)
					b = b - 16
				elseif opt$ = chr$(0) + chr$(81) then
					locate 7,79:color 7:print chr$(25):color 15
					call Seeker(b+256)
					b = b + 256
				elseif opt$ = chr$(0) + chr$(asc("I")) then
					locate 6,79:color 7:print chr$(24):color 15
					call Seeker(b-256)
					b = b - 256
				elseif opt$ = chr$(0) + chr$(60) then
					locate 8,2:color 14:print "F2 Seek"
					locate 22,3:input ">",b
					locate 8,2:color 15,1:print "F2 Seek":color 15,0
					locate 22,3:color 0:print tab(78)
					call Seeker(b)
				elseif opt$ = chr$(0) + chr$(61) then
					call Find
				elseif opt$ = chr$(0) + chr$(62) then
					call Change
				elseif opt$ = chr$(0) + chr$(71) then
					b = 0
					call Seeker(b)
				elseif opt$ = chr$(0) + chr$(79) then
					b = lof(1)-256
					call Seeker(b)
				elseif opt$ = chr$(0) + chr$(68) then
					close #1
					call InputFilename(filename$)
				elseif opt$ = chr$(0) + chr$(64) then
					call FEDOSPrompt
					call Gf
					call Seeker(b)
			end if
			locate 6,79:color 15,1:print chr$(24)
			locate 7,79:color 15,1:print chr$(25)
			color 15,0			
		loop
	close #1
end sub
			

sub Seeker(b)
	if b < 0 then b = 0
	if (b >= lof(1)) then b = lof(1) - 258
	seek #1,b
	color 7
	for y = 1 to 16
		get$ #1,16,byte$
		hx = 1
		for h = 1 to 16*3 step 3
			if (asc(mid$(byte$,hx,1)) <= 31) or (asc(mid$(byte$,hx,1)) >= 127) then
					color 8:locate 4+y,12+h:print hex$(asc(byte$))
				else
					color 7:locate 4+y,12+h:print hex$(asc(mid$(byte$,hx,1)))
			end if
			hx = hx + 1
		next h
		for s = 1 to 16
			if (asc(mid$(byte$,s,1)) <= 31) or (asc(mid$(byte$,s,1)) >= 127) then
					color 8:locate 4+y,61+s:print "."		
				else
					color 15:locate 4+y,61+s:print mid$(byte$,s,1)
			end if
			next s
		next y
end sub

sub WindowGrafix
	color 0,15:locate 3,1:print "  D'WormGuy 0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F   þþþþþþþþþþþþþþþþ   "
	color 15,15:locate 3,62:print "0123456789ABCDEF" '"þþþþþþþþþþþþþþþþ"
	color 15,1:locate 5,78:print chr$(213)+chr$(205)+chr$(184)
	locate 6,78:print chr$(179)+chr$(24)+chr$(179)
	locate 7,78:print chr$(179)+chr$(25)+chr$(179)
	locate 8,78:print chr$(212)+chr$(205)+chr$(190)
	for l = 5 to 20
		locate 5,1:print "ÖÄÄÄÄÄÄÄÄÄÄ·"
		locate l,1:print chr$(186)tab(12):print chr$(186)'º
		locate 20,1:print "ÓÄÄÄÄÄÄÄÄÄÄ½"
	next l                       	
	color 15,0
	locate 21,2:print "Ö"tab(79)"·"
	locate 22,2:print "º"tab(79)"º"
	locate 23,2:print "Ó"tab(79)"½"
	for l = 3 to 78
		locate 21,l:print "Ä"
		locate 23,l:print "Ä"
	next l
	color 15,1:
	locate 6,2:print "[COMMANDS]"
	locate 8,2:print "F2 Seek"
	locate 10,2:print "F3 Find"
	locate 12,2:print "F4 Change"
	locate 14,2:print "F6 FE-DOS"
	locate 16,2:print "F10 >File"
	locate 18,2:print "ESC quit"
	color 15,0
end sub

sub Find
	dim SeekMem(1:50)
	sm = 1
	locate 10,2:color 14:print "F3 Find"	
	locate 22,3:color 14:input ">",find$
	seek #1,0
	for a = 1 to len(find$)
		s$ = mid$(find$,a,1)+chr$(0)
		find2$ = find2$ + s$
	next a
	for f = 1 to lof(1)
		seek #1,f
		get$ #1,len(find$),byte$
		'seek #1,f
		'get$ #1,len(find$)-1,byte2$
		'if byte2$ = mid$(find$,len(find$)-1,len(find$)-1) then
		'	b = loc(1)
		'	locate 22,3:print find$ + " Found at :"b - len(find$)
		'	call Seeker(b - len(find$))
		'	SeekMem(sm) = b - len(find$)
		'	sm = sm + 1
		'end if
		if byte$ = find$ then
			b = loc(1)
			locate 22,3:print find$ + " Found at :"b - len(find$)
			call Seeker(b - len(find$))
			SeekMem(sm) = b - len(find$)
			sm = sm + 1
		end if
	next f
	locate 22,3:color 0:print tab(78)
	locate 22,3:color 14,0:input "Change the string [yn]: ",y$
	if ucase$(y$) = "Y" then
		locate 22,3:color 0:print tab(78)
		locate 22,3:color 14,0:input "Replace to what: ",rep$
		for r = 1 to sm-1
			seek #1,SeekMem(r)
			put$ #1,rep$
		next r
	end if
	locate 10,2:color 15,1:print "F3 Find"	
	locate 22,3:color 0,0:print tab(78):color 15,0
	erase SeekMem
end sub

sub Change
	locate 12,2:color 14:print "F4 Change"
	locate 22,3:color 14,0:input "Seek #: ",b
	call Seeker(b)
	locate 22,3:color 0:print tab(78)
	locate 22,3:color 14,0:input "Replace to: ",rep$
	seek #1,b
	put$ #1,rep$
	locate 12,2:color 15,1:print "F3 Change"	
	locate 22,3:color 0,0:print tab(78):color 15,0
end sub

sub FEDOSPrompt
	cls
	locate 1,1:print "HE-DOS v1.29.8929"
	locate 2,1:print "Type <Exit> to Return in HEX Editor"
	locate 3,1:print "Press any key to continue..."
	a$ = input$(1)
	shell
end sub

sub Gf
	cls
	for w = 2 to 79
		locate 1,w:print chr$(196)
		locate 2,w:print chr$(205)
		locate 1,1:print chr$(214)
		locate 1,80:print chr$(183)
		locate 2,1:print chr$(200)
		locate 2,80:print chr$(188)
	next w
	color 15:locate 1,3:print "[ Filename :                                                                ]"
	call WindowGrafix
end sub

sub Credits
	cls
	screen 7
	'window screen (3,3)-(91,121)
	call Image
	call Text
	screen 0
end sub

sub Text
	dim crd$(1:4),crdt2$(1:4)
	call Credit(crdt$(),crdt2$())
	l = 2
	for text = 1 to 4
		locate l,7+(20 - len(crdt$(text)) / 2):color 8:print crdt$(text)
		l = l + 2
		locate l,7+(20 - len(crdt2$(text)) / 2):color 15:print crdt2$(text)
		l = l + 2
	next text
	locate 23,2:print "Press any key to Exit...."
	a$ = input$(1)
end sub

sub Image
	dim dta$(1:113)
	call Face(dta$())
	for y = 1 to 113
		for x = 1 to 88
			pset (5+x,5+y),val(mid$(dta$(y),x,1))
			if mid$(dta$(y),x,1) = " " then pset (5+x,5+y),0
			if mid$(dta$(y),x,1) = "f" then pset (5+x,5+y),15
		next x
	next y  	
	call Frame
end sub

sub Frame
	line (4,4)-(90,120),,b
	line (5,119)-(5,5),7
	line -(89,5),7
	pset (89,6)
	line -(89,119),8
	line -(6,119),8
	line (3,121)-(3,3),7
	line -(91,3),7
	pset (91,4)
	line -(91,121),8
	line -(4,121),8
end sub

'My Face 88x115
sub Face(dta$(1))
	dta$(1)    = "                                                                                   "
	dta$(2)    = "                                                                                   "
	dta$(3)    = "                                                                                   "
	dta$(4)    = "                                                                                   "
	dta$(5)    = "                                                                                   "
	dta$(6)    = "                                                                                   "
	dta$(7)    = "                                                                                   "
	dta$(8)    = "                                                                                   "
	dta$(9)    = "                                                                                   "
	dta$(10)   = "          f                                                                        "
	dta$(11)   = "         ff   f                           f                                    ffff"
	dta$(12)   = "          f   f                        ffffffff                                ffff"
	dta$(13)   = "                                     fffffffffffff                             f ff"
	dta$(14)   = "             f                     ffffffffffffffff                             ff "
	dta$(15)   = "                                   ffffffffffffffffff                            f "
	dta$(16)   = "                                   ffff ff      fffff                              "
	dta$(17)   = "                                   fffffffff f fffffff                             "
	dta$(18)   = "                                   fffffffffffffffffff                             "
	dta$(19)   = "                                     ffffffffffffffffff                            "
	dta$(20)   = "                                          ffffffffffff                             "
	dta$(21)   = "                                              ffffffff                             "
	dta$(22)   = "                                                                                   "
	dta$(23)   = "                                                                                   "
	dta$(24)   = "                                                                                   "
	dta$(25)   = "                                                                                   "
	dta$(26)   = "                                                                                   "
	dta$(27)   = "                                                                                   "
	dta$(28)   = "                                                                                   "
	dta$(29)   = "                                                                                   "
	dta$(30)   = "                                                                                   "
	dta$(31)   = "                                                                                   "
	dta$(32)   = "                                                                                   "
	dta$(33)   = "                                                                                   "
	dta$(34)   = "                                                                                   "
	dta$(35)   = "                                                                                   "
	dta$(36)   = "                                                                                   "
	dta$(37)   = "                                   fffffffff                                       "
	dta$(38)   = "                                 ffffffffffff                                      "
	dta$(39)   = "                               fffffffffffffffffff                                 "
	dta$(40)   = "                              ffffffffffffffffffffff                               "
	dta$(41)   = "                              ffffffffffffffffffffff                               "
	dta$(42)   = "                              fffffffffffffffffffffff                              "
	dta$(43)   = "                             ffffffffffffffffffffffff                              "
	dta$(44)   = "  f                         ffffffffffffffffffffffffff                             "
	dta$(45)   = "                           ffffffffffffffffffffffffffff                            "
	dta$(46)   = "                           fffffffffffffffffffffffffffff                           "
	dta$(47)   = "                          fffffffffffffffffffffffffffffff                          "
	dta$(48)   = "                            fffffffffffffffffffffffffffffff                        "
	dta$(49)   = "                              ffffffffffffffffffffffffffffffff                     "
	dta$(50)   = "                                ffffffffffffffffffffffffffffffffff                 "
	dta$(51)   = "                                   fffffffffff             ffffffff                "
	dta$(52)   = "                                    fffffffff               ffffffff               "
	dta$(53)   = "                                     fffffff                  ffffff               "
	dta$(54)   = "                         ffff        fffffff                   fffff               "
	dta$(55)   = "                         ffffff      fffffff         fffff     ffffff              "
	dta$(56)   = "              f               fff     fffffff  fffffffffffffff ffffff              "
	dta$(57)   = "              ff                      fffffff fffffffffffffffffffffff              "
	dta$(58)   = "      f      fff                      ffffffff          fffffffffffff              "
	dta$(59)   = "      f      fff              ff ff   ffffffff           ffffffffffff              "
	dta$(60)   = "     fff     ffff             fffff   ffffffff             ffffffffff       ff     "
	dta$(61)   = "     fff     ffffff          fffffff  ffffffff  ff         ffffffffff    ffffff    "
	dta$(62)   = "    ffff     fffffffffffffffffffffff  fffffffffffff   fff  ffffffffff   fff fff    "
	dta$(63)   = "    ffff     fffffffffffffffffffffff ffffffffffffffffffffffffffffffff   fffffff    "
	dta$(64)   = "    fffff    ffffffffffffffffffffffffffffffffffffffffffffffffffffffff  ffffffff    "
	dta$(65)   = "    fffff    ffffffffffffffffffffffffffffffffffffffffffffffffffffffff  ffffffff    "
	dta$(66)   = "    ffffff   ffffffffffffffffffffffffffffffffffffffffffffffffffffffff  ffffffff    "
	dta$(67)   = "     fffff    fffffffffffffffffffffffffffffffffffffffffffffffffffffff ffffffff     "
	dta$(68)   = "     ff ff    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff     "
	dta$(69)   = "      f ff    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff     "
	dta$(70)   = "       fff    fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff      "
	dta$(71)   = "       ffff    fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff       "
	dta$(72)   = "       ffff    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff        "
	dta$(73)   = "        fff    fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff         "
	dta$(74)   = "        ffff   fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff         "
	dta$(75)   = "         fff   ffffffffffffffffffffffffffffffffffffffffffffffffffffffffff          "
	dta$(76)   = "                fffffffffffffffffff fffffffffffffffffffffffffffffffffffff          "
	dta$(77)   = "                fffffffffffffffff     ffffffffffffffffffffffffffffffffff           "
	dta$(78)   = "                 ffffffffffffffffffffffffffffffffffffffffffffffffffffff            "
	dta$(79)   = "                 fffffffffffffffffffffffffffffffffffffffffffffffffffff             "
	dta$(80)   = "                 fffffffffffffffffffffffffffffffffffffffffffffffffffff             "
	dta$(81)   = "                 ffffffffffffffffffffffffffffffffffffffffffffff                    "
	dta$(82)   = "                    fffffffffffffffffffffffffffffffffffffffffff                    "
	dta$(83)   = "                   fffffffffffffffffffffffffffffffffffffffffff                     "
	dta$(84)   = "                 f fffffff    f f ffffffffffffffffffffffffffff                     "
	dta$(85)   = "                   fffffff   fffffffffffffffffffffffffffffffff                     "
	dta$(86)   = "                   ffffffff   fffffffffffffffff   fffffffffff                      "
	dta$(87)   = "                  ffffffffff  fffffffffffffffff fffffffffffff                      "
	dta$(88)   = "                     fffffffffffffffffffffffffffffffffffffff                       "
	dta$(89)   = "                     ffffffffffffffffffffffffffffffffffffff                        "
	dta$(90)   = "                       ffffffff fffffffffffffffffffffffffff                        "
	dta$(91)   = "                        ffffffff fffffffffffffffffffffffff                         "
	dta$(92)   = "                        ffffffffffffffffffffffffffffffffff                         "
	dta$(93)   = "                        ffffffffffffffffffffffffffffffffff                         "
	dta$(94)   = "                        ffffffffffffffffffffffffffffffffff                         "
	dta$(95)   = "                        ffffffffffffffffffffffffffffffffff                         "
	dta$(96)   = "                         fffffffffffffffffffffffffffffffff                         "
	dta$(97)   = "                         fffffffffffffffffffffffffffffffff                         "
	dta$(98)   = "                          ffffffffffffffffffffffffffffffff                         "
	dta$(99)   = "                           fffffffffffffffffffffffffffffff                         "
	dta$(100)  = "                    f       ffffffffffffffffffffffffffffff                         "
	dta$(101)  = "                   fff        ffffffffffffffffff fffffffff                         "
	dta$(102)  = "                   ffff         fffffffffffff  fffffffffff                         "
	dta$(103)  = "                    ffff           fffffffff  fffffffffff                          "
	dta$(104)  = "                 ffffffff                   fffffffffffff                          "
	dta$(105)  = "               f  fffffff    ff           ffffffffffffffff                         "
	dta$(106)  = "               ffffffffff  fffffffffffffffffffffffffffffff                         "
	dta$(107)  = "              fffffffffffffffffffffffffffffffffffffffffffff                        "
	dta$(108)  = "              fff fffffffffffffffffffffffffffffffffffffffff                        "
	dta$(109)  = "            ffff fffffffffffffffffffffffffffffffffffffffffff                       "
	dta$(110)  = "           ffffffffffffffffffffffffffffffffffffffffffffffffff                      "
	dta$(111)  = "          ffffffffffffffffffffffffffffffffffffffffffffffffffff                     "
	dta$(112)  = "     f  fffffffffffffffffffffffffffffffffffffffffffffffffffffff                    "
	dta$(113)  = "    fff ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff               "
end sub
sub Credit(crdt$(1),crdt2$(1))
	crdt$(1) = "þ PROGRAMMER þ"
	crdt2$(1) = "Jayson Ragasa"
	crdt$(2) = "þ AGE þ"
	crdt2$(2) = "17"
	crdt$(3) = "þ GRAFIX þ"
	crdt2$(3) = "Jayson Ragasa"
	crdt$(4) = "þ E-MAIL þ"
	crdt2$(4) = "WORMGUY17@YAHOO.COM"
end sub
end