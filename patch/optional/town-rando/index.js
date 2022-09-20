const { core, utils: { shuffleArray} } = require('../../../lib');

const { log } = require('../../../lib/utils');

const towns = {
	Jova: {
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
	Aljiba: {
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
	Alba: {
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
	Ondol: {
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
	Veros: {
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
	Doina: {
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
	Yomi: {
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
	},
	"Berkeley Mansion - Door": {
		height: 1,
		leftoffset: 0x8D4D,
		rightoffset: 0x8D50,
		leftvalue: [0xFF, 0x02,0x01],
		rightvalue: [0xFF, 0x02,0x04],
		fromleftoffset: 0xA170,
		fromrightoffset: 0xA6C9,
		fromleftvalue: [0xFF,0x01,0x01],
		fromrightvalue: [0xFF,0x01,0x01],  
		leftheightoffset: 0xA1C6,
	},
	'Brahm Mansion - Door' : {
		height: 1,
		leftoffset: 0x968E,
		rightoffset: 0x9691,
		leftvalue: [0xFF, 0x04,0x00],
		rightvalue: [0xFF, 0x02,0x06],
		fromleftoffset: 0xAE82,
		fromrightoffset: 0xA178,
		fromleftvalue: [0xFF,0x01,0x03],
		fromrightvalue: [0xFF,0x01,0x03],  
		leftheightoffset: 0xAEB6,
		nojova: true,
	},
	'Laruba Mansion - Door': {
		height: 1,
		leftoffset: 0x88DA,
		rightoffset: 0x88DD,
		leftvalue: [0xFF, 0x03,0x00],
		rightvalue: [0xFF, 0x03,0x03],
		fromleftoffset: 0xB388,
		fromrightoffset: 0xB7DA,
		fromleftvalue: [0xFF,0x01,0x00],
		fromrightvalue: [0xFF,0x01,0x00],  
		leftheightoffset: 0xB3BD,
		nojova: true,
		
	}
}



function copytown (town1, town2, pm, logic){
		if (town1 == town2) {
			log(town1+" is staying put");
			//we can't just return here in case we looped.
			//return;
			
		}
		log(town2+" is being put where "+town1+" was");
		var leftvalue =towns[town1].leftvalue;
		var rightvalue =towns[town1].rightvalue;
		var fromrightvalue = towns[town2].fromrightvalue;
		var fromleftvalue = towns[town2].fromleftvalue;
		if (towns[town1].leftheightoffset > 0) {
			
			var value=towns[town2].height-1;
			pm.add([value] , towns[town1].leftheightoffset);
			
		}
		
		if (town2.torightheightchange>0){ 
			//pm.add([towns[town1].height-1] , towns[town2].torightheightchange);
		}
		
		pm.add(leftvalue, towns[town2].leftoffset);
		pm.add(rightvalue, towns[town2].rightoffset);
		pm.add(fromleftvalue, towns[town1].fromleftoffset);
		pm.add(fromrightvalue, towns[town1].fromrightoffset);
		
		
		//adjust logic
		towns[town2].reqs = core.find(c => c.name == town1).doors.requirements[logic];
		//console.log("new town reqs:" +towns[town2].reqs);
		
		
}

module.exports = {
	pre: true,
	order:1,
	id: 'town-rando',
	name: 'Town Randomizer',
	description: 'Towns in random places',
	patch: function (pm, opts) {
	
		const { logic, rng } = opts;
		var attempts = 0;
		while (1){
			const townnames = ["Jova","Yomi","Veros", "Doina", 'Brahm Mansion - Door', 'Laruba Mansion - Door',"Berkeley Mansion - Door", "Alba", "Ondol", "Aljiba", ];
			const townnames2 =  ["Jova", "Alba", "Ondol", "Aljiba", "Doina", 'Brahm Mansion - Door', "Yomi", "Veros", "Berkeley Mansion - Door", 'Laruba Mansion - Door'];
			attempts = 0;
			shuffleArray(townnames2, rng);
			while (townnames.length > 0 && attempts <20){
				
				for (j=0; j<townnames2.length; j++){
				
					if (towns[townnames2[j]].onlyheight1){
						if (towns[townnames[0]].height > 1){
							console.log( townnames[0]+" "+townnames2[j]+" hieght 1");
							continue;
						}
					}
					if (townnames[0] === townnames2[j] && (j+1) < townnames2.length){
						
							continue;
						
					}
					if (townnames[0] == "Jova"){
						if (towns[townnames2[j]].nojova){
						
							continue;
						
						}
					
					}
					copytown(townnames2[j], townnames[0], pm, logic);
					townnames.shift();
					townnames2.splice(j, 1);
					break;
				}
				attempts +=1;
			}
			if (attempts <30 ){
				break;
				
			}
			console.log("looping");
		}
		
		
		
		for (let town in towns){
			
			let townReqs = towns[town].reqs;
			let location = core.find(c=> c.name ===town );
			location.doors.requirements[logic] = townReqs;
				
				
			
			const actors = core
				.filter(loc => loc.name === town)
				.reduce((a, c) => {
					return a.concat(c.actors || []);
				}, []);
		actors.filter(a => a.holdsItem).forEach(actor => {
				const actorReqs = actor.actorRequirements[logic];
				
				let newReqs;
				if (townReqs && actorReqs) {
					newReqs = `(${townReqs}) && (${actorReqs})`;
				} else if (townReqs) {
					newReqs = townReqs;
				} else if (actorReqs) {
					newReqs = actorReqs;
				} else {
					newReqs = '';
				}
				actor.requirements[logic] = newReqs;
//				console.log(actor.name + "now logic: " +newReqs);
			});
			//now do the same with each door which now has a new requirement 
			let doors = core.find(c => c.name == town).doors;
			
			doors.requirements[logic] = towns[town].reqs;
			doors.data.forEach(door => {
				const actors = core
				.filter(loc => loc.objset === door.target.objset && loc.area === door.target.area)
				.reduce((a, c) => {
					return a.concat(c.actors || []);
				}, []);
			actors.filter(a => a.holdsItem).forEach(actor => {
				const actorReqs = actor.actorRequirements[logic];
				let newReqs;
				if (townReqs && actorReqs) {
					newReqs = `(${townReqs}) && (${actorReqs})`;
				} else if (townReqs) {
					newReqs = townReqs;
				} else if (actorReqs) {
					newReqs = actorReqs;
				} else {
					newReqs = '';
				}
				actor.requirements[logic] = newReqs;
				if (newReqs){
					log(door.name + " "+ actor.name + "now logic: " +newReqs);
				}
			});
				
				
				
			});
		
		};
		
	}
};
