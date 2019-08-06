module.exports = {
	patch: {
		core: [
	    'sram',
	    'clear-objects',
	    'title-screen',
	    'room-palette-fix',
	    'fast-day-night',
	  	'fast-text',
	  	'night-party',
	    'game-state-checks',
	    'enemizer',
	    'itemizer'
	  ]
	},
	difficulty: {
		easy: [
			'double-hearts',
			'hearts-patch',
			'penalty-reduction'
		],
		standard: [
			'enemy-hp',
			'hearts-patch',
			'penalty-reduction',
			'price-rando'
		],
		hard: [
			'enemy-hp',
			'price-rando'
		]
	}
}