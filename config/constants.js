const patchTemplate = `
module.exports = {
	id: '<%= id %>',
	name: '<%= name %>',
	description: '<%= description %>',
	patch: <%= patch %>
};
`;

module.exports = {
	PATCH_TEMPLATE: patchTemplate
};