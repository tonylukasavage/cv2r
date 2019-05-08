module.exports = {
    name: 'tester',
    description: 'tester description',
    flags: '-t, --test',
    patch: [
       // { offset: 0x60D5, value: "0B" },
       // { offset: 0x60D9, value: "07" },
        { offset: 0x60D9, value: "47" }
    ]
};