const test = require('ava');
const utils = require('../../lib/utils');

const logicTests = [
	{
		input: '',
		output: []
	},
	{
		input: 'HOLY_WATER',
		output: [ 'holy water' ]
	},
	{
		input: 'HOLY_WATER || NAIL',
		output: [ 'holy water', 'OR', 'nail' ]
	},
	{
		input: 'HOLY_WATER || EYEBALL',
		output: [ 'holy water', 'OR', 'eyeball' ]
	},
	{
		input: 'HOLY_WATER || NAIL || EYEBALL',
		output: [ 'holy water', 'OR', 'nail', 'OR', 'eyeball' ]
	},
	{
		input: 'WHITE_CRYSTAL && BLUE_CRYSTAL && RED_CRYSTAL',
		output: [ 'white crystal', 'blue crystal', 'red crystal' ]
	},
	{
		input: 'LAURELS || (WHITE_CRYSTAL && BLUE_CRYSTAL && RED_CRYSTAL)',
		output: [ 'laurels', 'OR', '(', 'white crystal', 'blue crystal', 'red crystal', ')' ]
	},
	{
		input: '(HOLY_WATER || NAIL)',
		output: [ '(', 'holy water', 'OR', 'nail', ')' ]
	},
	{
		input: '(HOLY_WATER || NAIL) && OAK_STAKE && WHITE_CRYSTAL && BLUE_CRYSTAL && RED_CRYSTAL',
		output: [ '(', 'holy water', 'OR', 'nail', ')', 'oak stake', 'white crystal', 'blue crystal', 'red crystal' ]
	},
	{
		input: '(HOLY_WATER || NAIL || EYEBALL) && (LAURELS || (WHITE_CRYSTAL && BLUE_CRYSTAL && RED_CRYSTAL))',
		output: [ '(', 'holy water', 'OR', 'nail', 'OR', 'eyeball', ')', '(', 'laurels', 'OR', '(', 'white crystal', 'blue crystal', 'red crystal', ')', ')' ]
	},
	{
		input: 'LAURELS && WHITE_CRYSTAL && BLUE_CRYSTAL && RED_CRYSTAL && (HOLY_WATER || NAIL)',
		output: [ 'laurels', 'white crystal', 'blue crystal', 'red crystal', '(', 'holy water', 'OR', 'nail', ')' ]
	},
	{
		input: '(HOLY_WATER || NAIL || EYEBALL) && WHITE_CRYSTAL',
		output: [ '(', 'holy water', 'OR', 'nail', 'OR', 'eyeball', ')', 'white crystal' ]
	},
	{
		input: 'LAURELS',
		output: [ 'laurels' ]
	},
	{
		input: 'GARLIC',
		output: [ 'garlic' ]
	},
	{
		input: '(HOLY_WATER || NAIL) && OAK_STAKE && ((WHITE_CRYSTAL && BLUE_CRYSTAL && RED_CRYSTAL) || LAURELS)',
		output: [ '(', 'holy water', 'OR', 'nail', ')', 'oak stake', '(', '(', 'white crystal', 'blue crystal', 'red crystal', ')', 'OR', 'laurels', ')' ]
	},
	{
		input: '(HOLY_WATER || NAIL || EYEBALL) && HEART',
		output: [ '(', 'holy water', 'OR', 'nail', 'OR', 'eyeball', ')', 'heart' ]
	},
	{
		input: '\t(   HOLY_WATER || NAIL   )  &&\t\t OAK_STAKE  && \t  (  ( \tWHITE_CRYSTAL  &&  BLUE_CRYSTAL\t\t\t\t && RED_CRYSTAL    )    || LAURELS)\t',
		output: [ '(', 'holy water', 'OR', 'nail', ')', 'oak stake', '(', '(', 'white crystal', 'blue crystal', 'red crystal', ')', 'OR', 'laurels', ')' ]
	},
	{
		input: '\t\t    \tHOLY_WATER\t  ',
		output: [ 'holy water' ]
	}
];

logicTests.forEach(({ input, output }) => {
	test(`#parseLogic('${input.replace(/\t/g, '')}')`, async t => {
		t.plan(1);
		t.deepEqual(utils.parseLogic(input), output);
	});
});