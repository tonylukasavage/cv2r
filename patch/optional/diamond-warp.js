module.exports = {
	id: 'diamond-warp',
	name: 'Diamond Warp',
	description: 'If you own the magic cross and equip the diamond, pressing SELECT->up+A+B will send you to Bordia Mountains instead of Jova.',
	// There is no code for patch here. The core game-state-checks patch includes all the code necessary
	// to execute the diamond warp. The core sram patch is where the value $6006 is written to in order to
	// enable it, but only if this patch is in the patch list.
	patch: []
};
