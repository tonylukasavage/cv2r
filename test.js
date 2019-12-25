// base functions
const base = {};
base.HOLY_WATER = function HOLY_WATER(v) { return funcs.HOLY_WATER(v) || funcs.NAIL(v); };
base.WHITE_CRYSTAL = function WHITE_CRYSTAL() { return false; };
base.BLUE_CRYSTAL = function BLUE_CRYSTAL() { return true; };
base.RED_CRYSTAL = function RED_CRYSTAL() { return true; };
base.OAK_STAKE = function OAK_STAKE() { return true; };
base.LAURELS = function LAURELS(v) { return (funcs.HOLY_WATER(v) || funcs.NAIL(v)) && ((funcs.WHITE_CRYSTAL(v) && funcs.BLUE_CRYSTAL(v) && funcs.RED_CRYSTAL(v)) || false); };
base.NAIL = function NAIL(v) { return ((funcs.WHITE_CRYSTAL(v) && funcs.BLUE_CRYSTAL(v) && funcs.RED_CRYSTAL(v)) || funcs.LAURELS(v)) && funcs.OAK_STAKE(v); };

// generate logic functions with node checks
const items = [ 'HOLY_WATER', 'WHITE_CRYSTAL', 'BLUE_CRYSTAL', 'RED_CRYSTAL', 'OAK_STAKE', 'LAURELS', 'NAIL' ];
const funcs = {};
items.forEach(item => {
	funcs[item] = function(v) {
		if (v[item]) { return false; }
		v[item] = true;
		return base[item](v);
	};
});

// execute logic check
const visited = { WHITE_CRYSTAL: true };
const clone = () => Object.assign({}, visited);
// console.log((funcs.HOLY_WATER(clone()) || funcs.NAIL(clone())));
console.log(funcs.OAK_STAKE(clone()));