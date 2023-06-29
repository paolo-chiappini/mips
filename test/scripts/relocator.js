// How to use: 
// node ./relocator.js [binary file name or path]

// The script will overwrite the specified file by changing 
// the address field of JAL instructions to match with the 
// reduced memory structure. 

const fs = require('fs'); 

const mips_text_addr = 4194304; // 0x0040 0000
const reduced_text_addr = 128; // 0x0000 0080 

const jal_opcode = "000011"; 
const addr_len = 26; 

const is_jal = (instruction) => instruction.substring(0, jal_opcode.length) === (jal_opcode);  

const bin_to_dec = (bin) => parseInt(bin, 2); 

const dec_to_bin = (dec) => dec.toString(2).padStart(addr_len, '0'); 

const relocate = (instruction) => {
    if (!is_jal(instruction)) return instruction; 
    
    let addr = instruction.slice(-addr_len); 
    let dec_addr = (bin_to_dec(addr) - 1) * 4; 
    let offset = dec_addr - mips_text_addr; 
    
    if (offset < 0) {
        // instruction may already have been relocated 
        console.log(`>> Skipping ${dec_addr.toString(16).toUpperCase()}`); 
        return instruction; 
    }

    let new_addr_dec = (reduced_text_addr + offset) / 4; 
    addr = dec_to_bin(new_addr_dec); 

    console.log(`Relocated jal from addr ${dec_addr.toString(16).toUpperCase()} to ${(new_addr_dec * 4).toString(16).toUpperCase()}`); 

    return [jal_opcode, addr].join('');  
}


const filename_arg = 2; 
const this_script_name = "relocator.js";
const script_name_arg = 1;  
let script_name = process.argv[script_name_arg];

// check if script has been launched from console
if (script_name.includes(this_script_name)) {
    let filename = process.argv[filename_arg];     
    relocateFile (filename); 
    return; 
}

function relocateFile (filename) {
    fs.readFile(filename, 'utf8', (err, data) => {
        if (err) {
            console.error(err); 
            return; 
        }
    
        let lines = data.split('\n');
        let relocated_lines = []; 
    
        lines.forEach(line => relocated_lines.push(relocate(line)));
        
        let new_data = relocated_lines.join('\n'); 
        fs.writeFile(filename, new_data, (err) => {
            if (err) console.error(err); 
            else console.log(`Instructions in file ${filename} relocated successfully`); 
        });
    }); 
}

module.exports = {
    relocate 
}; 
