PHP

LDA *$92
ORA #$<%= value %>
STA *$92
AND #$1
BEQ NO_BAG
LDA #$8
BNE DOCODE
NO_BAG LDA #$4
DOCODE STA *$D0
LDA *$<%= memory %>
CMP *$D0
BCS C_DONE
INC *$<%= memory %>
LDA *$<%= memory %>
CMP *$D0
BCS C_DONE
INC *$<%= memory %>

C_DONE PLP
LDA *$<%= memory %>

RTS