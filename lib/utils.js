const crypto = require('crypto');

exports.randomString = function randomString(len) {
	len = len || 16;
	return crypto
		.randomBytes(Math.ceil((len * 3) / 4))
		.toString('base64') // convert to base64 format
		.slice(0, len) // return required number of characters
		.replace(/\+/g, '0') // replace '+' with '0'
		.replace(/\//g, '0'); // replace '/' with '0'
};

exports.randomInt = function randomInt(min, max) {
	return Math.floor(Math.random() * (max - min + 1)) + min;
};