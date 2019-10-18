
const { assemble, core, object, utils: { randomInt, textToBytes }} = require('../../lib');

module.exports = {
	patch: function(pm, opts) {
            const { rng } = opts;
            clues=[];
            global.spoiler.forEach(a =>{
                var holds = a[0];
                var where = a[2];
                where=where.replace(/-.*/, "");
                where=where.replace(/\(.*/, "");
                where=where.replace(/Mansion.*/, "");
                where=where.replace(/ $/, "");
                if (holds.match("whip")){
                    holds="a whip";
                }
                if (holds.match("crystal")){
                    holds="a crystal";
                }
                
                if (a[1] == "Death"){
                    clues.push("Death guards\n"+holds);
                }
                if (a[1] == "Camilla"){
                
                    clues.push("Camilla holds\n"+holds);
                }
                if (a[1] == "merchant"){
                    
                    clues.push("A merchant\nsells\n"+holds+"\nin "+where);
                }
                if (a[1] =="sacred flame"){
                    clues.push(holds+"\nis hidden\non Dabi's Path");
                    
                }
                if (a[1] == "orb"){
                    clues.push(where+" hides\n"+holds);
                    
                }
                if (a[1] == "crystal dude"){
                    clues.push("someone is\ngiving away\n"+holds+"\nin "+where);
                    
                }
                
            });
            
//             console.log(clues);
            
            core.forEach(loc => {
//                 console.log(loc);
                if (!loc.actors){
                    return;
                    
                }
                loc.actors.forEach(a => {
                    if (!a.fixture){
                        return;
                    }
                    if ( a.name == "book"){
                        index = randomInt(rng, 0, clues.length-1);
                        maxlength=a.text.length;
                        while (clues[index].length > maxlength){
                            
                            clues[index]=clues[index].slice(0, -1);
                            
                        }
                        
                        const textBytes = textToBytes(clues[index]);
                                              
                        pm.add(textBytes, a.textPointer);
                          
//                           delete so we don't give the same clue twice
                        clues.splice(index, 1);
                    }
                                        

                });
                
                
            });
            
	}
};
