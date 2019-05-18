// 6502 assembler
// n. landsteiner, mass:werk / electronic tradion 2005; e-tradion.net

// lookup tables

var hextab= ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'];
var instrtab = {
	ADC:[  -1,  -1,0x69,0x6d,0x7d,0x79,0x65,0x75,  -1,  -1,0x61,0x71,  -1],
	AND:[  -1,  -1,0x29,0x2d,0x3d,0x39,0x25,0x35,  -1,  -1,0x21,0x31,  -1],
	ASL:[  -1,0x0a,  -1,0x0e,0x1e,  -1,0x06,0x16,  -1,  -1,  -1,  -1,  -1],
	BCC:[  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,0x90],
	BCS:[  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,0xb0],
	BEQ:[  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,0xf0],
	BIT:[  -1,  -1,  -1,0x2c,  -1,  -1,0x24,  -1,  -1,  -1,  -1,  -1,  -1],
	BMI:[  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,0x30],
	BNE:[  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,0xd0],
	BPL:[  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,0x10],
	BRK:[0x00,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	BVC:[  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,0x50],
	BVS:[  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,0x70],
	CLC:[0x18,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	CLD:[0xd8,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	CLI:[0x58,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	CLV:[0xb8,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	CMP:[  -1,  -1,0xc9,0xcd,0xdd,0xd9,0xc5,0xd5,  -1,  -1,0xc1,0xd1,  -1],
	CPX:[  -1,  -1,0xe0,0xec,  -1,  -1,0xe4,  -1,  -1,  -1,  -1,  -1,  -1],
	CPY:[  -1,  -1,0xc0,0xcc,  -1,  -1,0xc4,  -1,  -1,  -1,  -1,  -1,  -1],
	DEC:[  -1,  -1,  -1,0xce,0xde,  -1,0xc6,0xd6,  -1,  -1,  -1,  -1,  -1],
	DEX:[0xca,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	DEY:[0x88,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	EOR:[  -1,  -1,0x49,0x4d,0x5d,0x59,0x45,0x55,  -1,  -1,0x41,0x51,  -1],
	INC:[  -1,  -1,  -1,0xee,0xfe,  -1,0xe6,0xf6,  -1,  -1,  -1,  -1,  -1],
	INX:[0xe8,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	INY:[0xc8,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	JMP:[  -1,  -1,  -1,0x4c,  -1,  -1,  -1,  -1,  -1,0x6c,  -1,  -1,  -1],
	JSR:[  -1,  -1,  -1,0x20,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	LDA:[  -1,  -1,0xa9,0xad,0xbd,0xb9,0xa5,0xb5,  -1,  -1,0xa1,0xb1,  -1],
	LDX:[  -1,  -1,0xa2,0xae,  -1,0xbe,0xa6,  -1,0xb6,  -1,  -1,  -1,  -1],
	LDY:[  -1,  -1,0xa0,0xac,0xbc,  -1,0xa4,0xb4,  -1,  -1,  -1,  -1,  -1],
	LSR:[  -1,0x4a,  -1,0x4e,0x5e,  -1,0x46,0x56,  -1,  -1,  -1,  -1,  -1],
	NOP:[0xea,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	ORA:[  -1,  -1,0x09,0x0d,0x1d,0x19,0x05,0x15,  -1,  -1,0x01,0x11,  -1],
	PHA:[0x48,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	PHP:[0x08,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	PLA:[0x68,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	PLP:[0x28,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	ROL:[  -1,0x2a,  -1,0x2e,0x3e,  -1,0x26,0x36,  -1,  -1,  -1,  -1,  -1],
	ROR:[  -1,0x6a,  -1,0x6e,0x7e,  -1,0x66,0x76,  -1,  -1,  -1,  -1,  -1],
	RTI:[0x40,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	RTS:[0x60,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	SBC:[  -1,  -1,0xe9,0xed,0xfd,0xf9,0xe5,0xf5,  -1,  -1,0xe1,0xf1,  -1],
	SEC:[0x38,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	SED:[0xf8,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	SEI:[0x78,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	STA:[  -1,  -1,  -1,0x8d,0x9d,0x99,0x85,0x95,  -1,  -1,0x81,0x91,  -1],
	STX:[  -1,  -1,  -1,0x8e,  -1,  -1,0x86,  -1,0x96,  -1,  -1,  -1,  -1],
	STY:[  -1,  -1,  -1,0x8c,  -1,  -1,0x84,0x94,  -1,  -1,  -1,  -1,  -1],
	TAX:[0xaa,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	TAY:[0xa8,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	TSX:[0xba,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	TXA:[0x8a,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	TXS:[0x9a,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1],
	TYA:[0x98,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1]
};

var steptab = [1,1,2,3,3,3,2,2,2,3,2,2,2];

var addrtab = {
	imp:0,
	acc:1,
	imm:2,
	abs:3,
	abx:4,
	aby:5,
	zpg:6,
	zpx:7,
	zpy:8,
	ind:9,
	inx:10,
	iny:11,
	rel:12
};

// globals

var codesrc, code, srcl, srcc, pc, symtab, listing;

// functions

module.exports = function assemble(src) {
	symtab={};
	// listing=document.forms.ass.listing;
	listing = {};
	// var codefield=document.forms.ass.codefield;
	codefield = {};

	codesrc = src.split(/[\r\n]+/);
	codefield.value=' \n';
	listing.value='starting assembly\npass 1\n';
	var pass1=false;
	var pass2=false;
	code=[];
	pass1=doPass(1);
	if (pass1) {
		listing.value='pass 2\n';
		pass2=doPass(2);
		if (pass2) {
			var c='';
			var n=1;
			for (var i=0; i<code.length; i++) {
				c+=getHexByte(code[i]);
				if (((n>0) && (n%8==0)) || (i==code.length-1)) {
					c+='\n';
				}
				else {
					c+=' ';
				}
				n++;
			}
			codefield.value=c;
			listing.value+='\ndone.';
		}
	}
	if ((pass1) && (pass2)) {
		//alert('6502 Assembler:\ndone.');
		return code;
	}
	else {
		listing.value+='\nfailed.\n';
		// alert('6502 Assembler:\nfailed (see listing).');
		throw new Error(listing.value);
	}
}

function displayError(er) {
	listing.value+='\n'+er+'\n';
}

function getChar() {
	if (srcl>=codesrc.length) return 'EOF';
	if (srcc>=codesrc[srcl].length) {
		srcc=0;
		srcl++;
		return '\n';
	}
	else {
		var c=codesrc[srcl].charAt(srcc);
		srcc++;
		return c.toUpperCase();
	}
}

function getSym() {
	var c=getChar();
	if (c=='EOF') return null;
	var sym=[''];
	var s=0;
	var m=0;
	while ((c!=';') && (c!='\n') && (c!='EOF')) {
		if ((c==' ') || (c=='\t')) {
			if (m>0) {
				m=0;
				s++;
				sym[s]='';
			}
		}
		else if (c=='=') {
			if (m>0) s++;
			sym[s]=c;
			m=0;
			s++;
			sym[s]='';
		}
		else {
			m=1;
			sym[s]+=c;
		}
		c=getChar();
	}
	while ((sym.length) && (sym[sym.length-1]=='')) sym.length--;
	return (c=='EOF')? null: sym;
}

function getNumber(n) {
	var r;
	if (n==null) r=0;
	if (n.charAt(0)=='$') {
		for (var i=1; i<n.length; i++) {
			var c=n.charAt(i);
			if ((c<'A') && (c>'Z') && (c<'0') && (c>'9')) return 'NaN';
		}
		r=parseInt(n.substring(1),16);
	}
	else if (n.charAt(0)=='%') {
		for (var i=1; i<n.length; i++) {
			var c=n.charAt(i);
			if ((c!='1') && (c!='0')) return 'NaN';
		}
		r=parseInt(n.substring(1),2);
	}
	else if (n.charAt(0)=='0') {
		for (var i=1; i<n.length; i++) {
			var c=n.charAt(i);
			if ((c<'0') && (c>'7')) return 'NaN';
		}
		r=parseInt(n,8);
	}
	else {
		for (var i=1; i<n.length; i++) {
			var c=n.charAt(i);
			if ((c<'0') && (c>'9')) return 'NaN';
		}
		r=parseInt(n,10);
	}
	return (isNaN(r))? 'NaN' : r;
}

function getIdentifier(n) {
	for (var i=0; i<n.length; i++) {
		var c=n.charAt(i);
		if ((c<'A') && (c>'Z') && (c<'0') && (c>'9') && (c!='_')) return '';
	}
	if (n.length>6) {
		n=n.substring(0,6);
	}
	return n;
}

function paddRight(s,l) {
	if (typeof s == 'undefined') s='';
	while (s.length<l) s+=' ';
	return s;
}

function doPass(pass) {
	srcl=srcc=pc=0;
	var sym=getSym();
	while (sym) {
		listing.value+='\n';
		if (sym.length==0) {
			sym=getSym();
			continue;
		}
		pc&=0xffff;
		var ofs=0;
		var c1=sym[0].charAt(0);
		var padd=0;
		if (sym[0]=='*') {
			// set pc
			listing.value+='*';
			if ((sym.length>2) && (sym[1]=='=')) {
				listing.value+=' = ';
				var a=getNumber(sym[2]);
				if (a=='NaN') {
					displayError('syntax error:\nnumber expected');
					return false;
				}
				else if (sym.length>3) {
					displayError('syntax error:\ntoo many arguments');
					return false;
				}
				listing.value+='$'+getHexWord(a);
				pc=a;
			}
			else {
				displayError('syntax error:\nassignment expected');
				return false;
			}
			sym=getSym();
			continue;
		}
		listing.value+=getHexWord(pc)+' ';
		if (c1=='.') {
			// pragma
			var pragma=sym[0];
			listing.value+=pragma;
			if (pragma=='.END') {
				return true;
			}
			else if ((pragma!='.WORD') && (pragma!='.BYTE')) {
				displayError('syntax error:\ninvalid pragma "'+pragma+'"');
				return false;
			}
			if (sym.length==2) {
				if (pass==2) {
					var v;
					if (sym[1]=='*') {
						v=pc;
					}
					else {
						v=sym[1];
						var v1=v.charAt(0);
						var bt=0;
						if ((v1=='>') || (v1=='<')) {
							bt=(v1=='>')? 1:-1;
							v=v.substr(1);
							v1=v.charAt(0);
						}
						if ((v1=='$') || (v1=='%') || ((v1>='0') && (v1<='9'))) {
							// number
							v=getNumber(v);
							if (v=='NaN') {
								displayError('syntax error:\ninvalid value');
								return false;
							}
						}
						else {
							// identifier
							v=getIdentifier(v);
							if (v=='') {
								displayError('syntax error:\ninvalid identifier');
								return false;
							}
							else if (typeof symtab[v] == 'undefined') {
								displayError('compile error:\nundefined identifier: "'+v+'"');
								return false;
							}
							v=symtab[v];
						}
						if (bt<0) {
							// lo-byte
							v&=0xff;
						}
						else if (bt>0) {
							// hi-byte
							v=Math.floor(v/256)&0xff;
						}
					}
					v&=0xffff;
					var hi=Math.floor(v/256)&0xff;
					var lo=v&0xff;
					code[code.length]=lo;
					if (pragma=='.WORD') {
						code[code.length]=hi;
						listing.value += ' $'+getHexWord(v)+'            '+getHexByte(lo)+' '+getHexByte(hi);
					}
					else {
						listing.value += ' $'+getHexByte(lo)+'              '+getHexByte(lo);
					}
				}
				else {
					listing.value+=' '+sym[1];
				}
				pc+=(pragma=='.WORD')? 2:1;
				sym=getSym();
				continue;
			}
			else if (sym.length==1) {
				displayError('syntax error:\nvalue expected');
				return false;
			}
			else {
				displayError('syntax error:\ntoo many arguments');
				return false;
			}
		}
		else if ((c1<'A') || (c1>'Z')) {
			listing.value+=sym[0];
			displayError('syntax error:\ncharacter expected');
			return false;
		}
		if (instrtab[sym[0]]==null) {
			// identifier
			var l=getIdentifier(sym[0]);
			if (l=='') {
				displayError('syntax error:\ninvalid identifier: '+sym[0]);
				return false;
			}
			listing.value+=paddRight(l,6)+' ';
			ofs++;
			if ((sym.length>1) && (sym[ofs]=='=')) {
				ofs++;
				listing.value+='= ';
				if (sym.length<3) {
					displayError('syntax error:\nunexpected end of line');
					return false;
				}
				else if (sym.length>3) {
					displayError('syntax error:\ntoo many arguments');
					return false;
				}
				var v;
				if (sym[2]=='*') {
					v=pc;
				}
				else {
					v=getNumber(sym[2]);
				}
				if (v=='NaN') {
					displayError('syntax error:\nnumber expected');
					return false;
				}
				if (pass==1) symtab[l]=v;
				listing.value+=getHexWord(v);
				sym=getSym();
				continue;
			}
			else {
				if (pass==1) symtab[l]=pc;
				if (sym.length>=ofs+1) {
					c1=sym[ofs].charAt(0);
				}
				else {
					sym=getSym();
					continue
				}
				padd=7;
			}
		}
		if (sym.length<ofs) {
			// end of line
			sym=getSym();
			continue;
		}
		if (padd==0) listing.value+='       ';
		padd=0;
		if ((c1<'A') || (c1>'Z')) {
			listing.value+=sym[0];
			displayError('syntax error:\ncharacter expected');
			return false;
		}
		else {
			// opcode
			var opc=sym[ofs];
			listing.value+=opc+' ';
			var opctab=instrtab[opc];
			if (opctab==null) {
				displayError('syntax error:\nopcode expected');
				return false;
			}
			var addr=sym[ofs+1];
			var mode=0;
			if (typeof addr=='undefined') {
				// implied
				if (opctab[0]<0) {
					displayError('syntax error:\nunexpected end of line');
					return false;
				}
				else if (pass==2) {
					// compile
					listing.value+='            '+getHexByte(opctab[0]);
					code[code.length]=opctab[0];
				}
				pc++;
			}
			else if (sym.length>ofs+2) {
				displayError('syntax error:\ntoo many operands');
				return false;
			}
			else {
				var a1=addr.charAt(0);
				var b1=0;
				var b2=addr.length;
				if (addr=='A') {
					if (pass==2) { listing.value+='A'; padd=1; }
					mode=1;
				}
				else if (a1=='#') {
					if (pass==2) { listing.value+=a1; padd=1; }
					b1=1;
					mode=2;
				}
				else if (a1=='*') {
					if (pass==2) { listing.value+=a1; padd=1; }
					b1=1;
					mode=6;
				}
				else if (a1=='(') {
					if (pass==2) { listing.value+=a1; padd=1; }
					b1=1;
					mode=9;
				}
				else {
					mode=(opctab[12]<0)? 3:12;
				}
				if (pass==1) listing.value+=addr;
				if (mode==9) {
					var b3=addr.indexOf(',X)');
					if ((b3>0) && (b3==addr.length-3)) {
						mode+=1;
					}
					else {
						b3=addr.indexOf('),Y');
						if ((b3>0) && (b3==addr.length-3)) {
							mode+=2;
						}
						else {
							b3=addr.indexOf(')');
						}
					}
					if (b3<0) {
						displayError('syntax error:\ninvalid address');
						return false;
					}
					b2=b3;
				}
				else if (mode>2) {
					var b3=addr.indexOf(',X');
					if ((b3>0) && (b3==addr.length-2)) {
						mode+=1;
					}
					else {
						b3=addr.indexOf(',Y');
						if ((b3>0) && (b3==addr.length-2)) mode+=2;
					}
					if (b3>0) b2=b3;
				}
				if (pass==2) {
					var instr=opctab[mode];
					if (instr<0) {
						displayError('compile error:\ninvalid address mode for '+opc);
						return false;
					}
					else {
						code[code.length]=instr;
					}
					if (mode>1) {
						// operand
						addr=addr.substring(b1,b2);
						var bt=0;
						var adp=addr.charAt(0);
						var oper=0;
						if ((adp=='>') || (adp=='<')) {
							bt=(adp=='>')? 1:-1;
							listing.value+=adp; padd++;
							addr=addr.substr(1);
							adp=addr.charAt(0);
						}
						if ((adp=='$') || (adp=='%') || ((adp>='0') && (adp<='9'))) {
							// number
							oper=getNumber(addr);
							if (oper=='NaN') {
								displayError('syntax error:\nnumber expected');
								return false;
							}
							oper&=0xffff;
							var s=(steptab[mode]>2)? '$'+getHexWord(oper):'$'+getHexByte(oper);
							listing.value+=s;
							padd+=s.length;
						}
						else {
							// identifier
							addr=getIdentifier(addr);
							if (addr=='') {
								displayError('syntax error:\ninvalid identifier');
								return false;
							}
							else if (typeof symtab[addr] == 'undefined') {
								displayError('compile error:\nundefined identifier "'+addr+'"');
								return false;
							}
							oper=symtab[addr];
							listing.value+=addr;
							addr=''+addr;
							padd+=addr.length;
						}
						if (bt<0) {
							// lo-byte
							oper&=0xff;
						}
						else if (bt>0) {
							// hi-byte
							oper=Math.floor(oper/256)&0xff;
						}
						if (mode==12) {
							// rel
							oper=oper-((pc+2)&0xffff);
							if ((oper>127) || (oper<-128)) {
								displayError('error: branch target out of range');
								return false;
							}
						}
						if ((mode==4) || (mode==7)) {
							listing.value+=',X';
							padd+=2;
						}
						else if ((mode==5) || (mode==8)) {
							listing.value+=',Y';
							padd+=2;
						}
						else if (mode==9) {
							listing.value+=')';
							padd+=1;
						}
						else if (mode==10) {
							listing.value+=',X)';
							padd+=3;
						}
						else if (mode==11){
							listing.value+='),Y';
							padd+=3;
						}
					}
					// compile
					for (var i=padd; i<12; i++) listing.value+=' ';
					listing.value+=getHexByte(instr);
					if (mode>1) {
						var op=oper&0xff;
						code[code.length]=op;
						listing.value+=' '+getHexByte(op);
						if (steptab[mode]>2) {
							op=(Math.floor(oper/256))&0xff;
							code[code.length]=op;
							listing.value+=' '+getHexByte(op);
						}
					}
				}
				pc+=steptab[mode];
			}
		}
		sym=getSym();
	}
	return true;
}

function getHexByte(v) {
	return ''+hextab[Math.floor(v/16)]+hextab[v&0x0f];
}

function getHexWord(v) {
	return ''+hextab[Math.floor(v/0x1000)]+hextab[Math.floor((v&0x0f00)/256)]+hextab[Math.floor((v&0xf0)/16)]+hextab[v&0x000f];
}

// eof