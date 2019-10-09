module.exports = {
	patch: function(pm) {
		const { utils: { TEXT_MAP_ENDING, textToBytes } } = require('../../lib');

		// convert text string to bytes and add the patch
		const endingPrint = (text, rom) => pm.add(textToBytes(text, TEXT_MAP_ENDING), rom);
		endingPrint('simon\'s quest', 0x126C2);
		endingPrint('of revenge &', 0x126D2);
		endingPrint('narcissism is ', 0x126E1);
		endingPrint('finally done.', 0x126F2);

		endingPrint('his bloodlust ', 0x12702);
		endingPrint('momentarily   ', 0x12713);
		endingPrint('sated after', 0x12724);
		endingPrint('resurrecting ', 0x12732);

		endingPrint('Dracula, only', 0x12742);
		endingPrint('to execute', 0x12752);
		endingPrint('him yet again ', 0x1275F);
		endingPrint('moments later.', 0x12770);

		endingPrint('he now plans a', 0x12781);
		endingPrint('Doina PR tour', 0x12792);
		endingPrint('to restore the', 0x127A2);
		endingPrint('Belmont name.', 0x127B3);
	}
};
