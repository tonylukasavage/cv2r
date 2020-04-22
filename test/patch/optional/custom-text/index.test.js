const _ = require('lodash');
const assert = require('assert');
const fs = require('fs');
const path = require('path');

const PATCH_DIR = path.join(__dirname, '..', '..', '..', '..', 'patch', 'optional', 'custom-text');
const ITEMS_MODULE = path.join(__dirname, '..', '..', '..', '..', 'patch', 'core', 'itemizer', 'items');
const helpers = require(path.join(PATCH_DIR, 'helpers'));
const itemsModule = require(ITEMS_MODULE);

describe.only('[patch] custom-text', function() {

	describe('#prepText', function() {
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
			it (`correctly preps "${test[0]}"`, function() {
				assert.equal(helpers.prepText(test[0]), test[1]);
			});
		});

		it('throws error on text that is too long', function() {
			try {
				helpers.prepText('This is just way too much text. This is just way too much text. This is just way too much text. This is just way too much text. ');
				assert.equals(0, 'should never get here');
			} catch (err) {
				assert.equal(err.message.indexOf('too long') !== -1, true);
			}
		});

		// test every item and text combination
		const items = itemsModule.allItems().map(i => i.name);
		const textFilePath = path.join(PATCH_DIR, 'data');
		const textFiles = fs.readdirSync(textFilePath).filter(f => path.extname(f) === '.txt');
		let text = [];
		for (let f of textFiles) {
			const file = path.join(PATCH_DIR, 'data', f);
			const lines = fs.readFileSync(file, 'utf8').split('\n').filter(l => l);
			text = text.concat(lines);
		}

		text.forEach(t => {
			items.forEach(item => {
				const newText = _.template(t)({item});
				it(newText, function() {
					try {
						helpers.prepText(newText);
					} catch (err) {
						assert.equal(0, 'should never get here');
					}
				});
			});
		});
	});

});