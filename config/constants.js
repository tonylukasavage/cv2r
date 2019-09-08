const patchTemplate = `
module.exports = {
	id: '<%= id %>',
	name: '<%= name %>',
	description: '<%= desc %>',
	patch: <%= patch %>
};
`;

module.exports = {
	PATCH_TEMPLATE: patchTemplate,
	SPRITE_TABLE_OFFSET: 0x20010
};