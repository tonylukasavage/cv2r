const assert = require('assert');
const helpers = require('../../../../patch/optional/custom-text/helpers');

describe.only('[patch] custom-text', function() {

	it('#prepText properly prepares text', function() {
		const tests = [
			[
				'',
				''
			],
			[
				'12345678901234567890',
				'123456789012\n34567890'
			],
			[
				'123456789012345678901234567890',
				'123456789012\n345678901234\n567890'
			],
			[
				'BSAC is a mad scientist who needs a real hobby',
				'BSAC is a mad\nscientist\nwho needs a\nreal hobby'
			],
			[
				'Freeland has played an unreasonable amount of seeds',
				'Freeland has\nplayed an\nunreasonable\namount of\nseeds'
			],
			[
				'Burb has gone AWOL and we miss him deeply',
				'Burb has gone\nAWOL and we\nmiss him\ndeeply'
			],
			[
				'Kaelari did the trackers for CV2R so I don\'t have to.',
				'Kaelari did\nthe trackers\nfor CV2R so I\ndon\'t have\nto.'
			],
			[
				'2snek is my spirit animal. HISSSSSSSSSSSSSSSS!',
				'2snek is my\nspirit\nanimal. HISS\nSSSSSSSSSSSS\nSS!',
			],
			[
				'Sathdresh is the god king of the brutal CV2R patches',
				'Sathdresh is\nthe god king\nof the brutal\nCV2R patches',
			],
		];

		tests.forEach(test => {
			assert.equal(helpers.prepText(test[0]), test[1]);
		});

		try {
			helpers.prepText('This is just way too much text. This is just way too much text. This is just way too much text. This is just way too much text. ')
			assert.equals(0, 'should never get here');
		} catch (err) {
			assert.equal(err.message.indexOf('too long') !== -1, true);
		}
	});

});