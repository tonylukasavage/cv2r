const { utils: { shuffleArray} } = require('../../../lib');


const towns= {
    jova: {
            leftoffset: 0x1FA12, 
            rightoffset: 0x01FA15, 
            leftvalue:[0xff,0x02,0x07], 
            rightvalue: [0xff,0x02,0x00], 
            fromleftoffset: 0xA15C, 
            fromrightoffset: 0xA186, 
            fromleftvalue: [0xFF, 0x00, 0x00], 
            fromrightvalue: [0xFF, 0x00, 0x00],
            height:2,  
            leftheightoffset: 0xA1C5,
    },
    aljiba: {
        height: 2,
        leftoffset: 0x1FAD5,
        rightoffset: 0x1FAD8,
        leftvalue: [0xFF,0x02,0x02],
        rightvalue: [0xFF, 0x03, 0x00],
        fromleftoffset: 0xA6B0,
        fromrightoffset: 0xB385,
        fromleftvalue: [0xFF,0x00,0x02],
        fromrightvalue: [0xFF,0x00,0x02],     
        leftheightoffset: 0xA6F1,
    },
    alba: {
        height: 3,
        leftoffset: 0x1FA1D,
        rightoffset: 0x1FA20,
        leftvalue: [0xFF,0x03,0x02],
        rightvalue: [0xFF, 0x02, 0x07],
        fromleftoffset: 0xB3A0,
        fromrightoffset: 0xA183,
        fromleftvalue: [0xFF,0x00,0x03],
        fromrightvalue: [0xFF,0x00,0x03],  
        leftheightoffset: 0xB3C0,
        
    },
    ondol: {
        height: 3,
        leftoffset: 0x8675,
        rightoffset: 0x8678,
        leftvalue: [0xFF,0x04,0x01],
        rightvalue: [0xFF, 0x03, 0x04],
        fromleftoffset: 0xB3AA,
        fromrightoffset: 0xAE8F,
        fromleftvalue: [0xFF,0x00,0x04],
        fromrightvalue: [0xFF,0x00,0x04],        
        leftheightoffset: 0xAEB9,
        
    },
    veros: {
        height: 1,
        leftoffset: 0x866A,
        rightoffset: 0x866D,
        leftvalue: [0xFC,0x02,0x00],
        rightvalue: [0xFC, 0x02, 0x03],
        fromleftoffset: 0xA1B5,
        fromrightoffset: 0xA6E3,
        fromleftvalue: [0xFF,0x00,0x01],
        fromrightvalue: [0xFF,0x00,0x01], 
        torightheightchange: 0x1FB34,
        onlyheight1: true,
    },
    doina: {
        height: 1,
        leftoffset: 0x1FAE0,
        rightoffset: 0x1FAE3,
        leftvalue: [0xFF,0x04,0x02],
        rightvalue: [0xFF, 0x02, 0x08],
        
        fromleftoffset: 0xAE9C,
        fromrightoffset: 0xA192,
        fromleftvalue: [0xFF,0x00,0x05],
        fromrightvalue: [0xFF,0x00,0x05],        
        
        leftheightoffset: 0xAEBA,
        nojova: true,
    },
    yomi: {
        height: 1,
        leftoffset: 0x1FAEB,
        rightoffset: 0x1FAEE,
        leftvalue: [0xfc, 0x02,0x08],
        rightvalue: [0xff, 0x04,0x03],
        fromleftoffset: 0xA1BD,
        fromrightoffset: 0xAEA4,
        fromleftvalue: [0xFF,0x00,0x06],
        fromrightvalue: [0xFF,0x00,0x06],        
        onlyheight1: true,
        nojova: true,
    }
}



function copytown (town1, town2, pm){
        if (town1 == town2) {
            //console.log(town1+" is staying put");
            return;
            
        }
        //console.log(town2+" is being put where "+town1+" was");
        var leftvalue =towns[town1].leftvalue;
        var rightvalue =towns[town1].rightvalue;
        var fromrightvalue = towns[town2].fromrightvalue;
        var fromleftvalue = towns[town2].fromleftvalue;
        if (towns[town2].leftheightoffset > 0) {
            
            var value=towns[town1].height-1
            pm.add([value] , towns[town2].leftheightoffset);
        }
        if (town2.torightheightchange>0){ 
            pm.add([towns[town1].height-1] , towns[town2].torightheightchange);
        }
        
        pm.add(leftvalue, towns[town2].leftoffset);
        pm.add(rightvalue, towns[town2].rightoffset);
        pm.add(fromleftvalue, towns[town1].fromleftoffset);
        pm.add(fromrightvalue, towns[town1].fromrightoffset);
        
    
}

module.exports = {
	
	id: 'town-rando',
	name: 'Town Randomizer',
	description: 'Towns in random places',
	patch: function (pm, opts) {
    
        const { rng } = opts;
        
        const townnames = ["jova","doina", "yomi","veros", "alba", "ondol", "aljiba"];
        const townnames2 =  ["jova", "alba", "ondol", "aljiba", "doina", "yomi", "veros"];

        shuffleArray(townnames2, rng);
        
        while (townnames.length > 0){
            
            for (j=0; j<townnames2.length; j++){
                if (towns[townnames[0]].onlyheight1){
                    if (towns[townnames2[j]].height > 1){
                        //console.log(townnames2[j]+" not height 1");
                        continue;
                    }
                }
                if (townnames[0] == "jova"){
                    if (towns[townnames2[j]].nojova){
                        continue;
                        
                    }
                    
                }
                copytown(townnames2[j], townnames[0], pm);
                townnames.shift();
                townnames2.splice(j, 1);
                break;
            }
        }
        
        
    }
};
