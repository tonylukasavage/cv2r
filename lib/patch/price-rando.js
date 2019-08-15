const core = require('../core');
const { randomDecimal } = require('../utils');

// random prices
// merchant prices will be +/-25% based on the base price in lib/patch/itemizer/items.js
module.exports = {
	patch: function(pm, opts) {
		const { rng } = opts;

		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.filter(a => a.sale).forEach(merchant => {
				let price = Math.floor((merchant.sale[1] * 100 + merchant.sale[2]) * randomDecimal(rng, 0.75, 1.25));
				if (price > 255) { price = 255; }
				else if (price < 1) { price = 1; }
				merchant.sale = [ merchant.sale[0], Math.floor(price / 100), parseInt(price % 100, 16) ];
				pm.add(merchant.sale, merchant.salePointer);
			});
		});
	}
};