module.exports = {
    name: 'tester',
    description: 'tester description',
    flags: '-t, --test',
    patch: [
        //{ offset: 0x60D5, value: "1C" },
        { offset: 0x60D9, value: "1E" },
        { offset: 0x60DD, value: "2D" }
    ]
};