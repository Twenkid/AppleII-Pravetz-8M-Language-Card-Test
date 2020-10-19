REM AppleII-Pravetz-8M-Language-Card-Test by Todor Arnaudov, 18.10.2020

REM With AppleWin, Clone mode Pravetz-8M (Apple][e, 64 KB RAM, built-in CP/M card)

REM http://www.applelogic.org/files/LANGCARDMAN.pdf

REM Appendix C,D - Thanks to Svetoslav Enkov 

REM p. 31-34

REM (Bank 1)

REM C080 - Select RAM read, Write-protect RAM
REM C081 - Deselect RAM read (Enable ROM). Two or more successive reads -> write-enable RAM.
	   
REM C082 - Select RAM read, Write-protect RAM
REM C083 - Select RAM read, Two or more successive reads -> write-enable RAM.


CALL-151

*4100: 00 00

*4000L

4000-   AD 81 C0    LDA   $C081
4003-   AD 81 C0    LDA   $C081
4006-   A9 33       LDA   #$33
4008-   8D 00 D0    STA   $D000
400B-   AD 80 C0    LDA   $C080
400E-   AD 00 D0    LDA   $D000
4011-   8D 00 41    STA   $4100
4014-   AD 81 C0    LDA   $C081
4017-   AD 00 D0    LDA   $D000
401A-   8D 01 41    STA   $4101
401D-   60          RTS   
401E-   00          BRK   
401F-   00          BRK   

*4000G

*4100

4100- 33 6F

1. Enable RAM, bank 1 for Writing - two accesses to $C081
2. Store the accumulator $33 at $D000 (in the ROM space)
3. Enable Reading, Disables writing C080
4. Read from that address $D000 (6F in ROM, should be 33 in the RAM)
5. Store what's read to $4100 (not-bank-switched memory space)
6. Disable RAM, Enable ROM C081
7. Load from $D000, now should read from the ROM
8. Store to $4101
9. Return

