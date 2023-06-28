// How to use: 
// node elf_reader.js [elf file name or path] [output file name or path]

// Reads a custom ELF file format and creates a new output file containing 
// the initial memory state.   
// The ELF file can contain the following fields: 
// - .text (followed by the instructions of a program); 
// - .data (followed by the static data of a program). 
// Jal instructions in the text sections will be relocated (if needed). 
// An example of an ELF file is: 
//
// .text
// 00100000100001000000000000000010
// 00001100000100000000000000001000
// 00100000010100000000000000000000
// 10101111101100000000000000000000
// .data
// 00001100000100000000010000010011
// 

const fs = require('fs');
const { TextState, DataState } = require('./parse_states'); 

const text_field = '.text';
const data_field = '.data';

const text_base_addr = 32; // 0x0000 0080 / 4
const data_base_addr = 128; // 0x0000 0200 / 4

// size in 32 bit words 
const text_size = 96;
const data_size = 64;
const mem_size = 256;

const mem_init_val = '00000000000000000000000000000000';

let mem_buff = [];

const in_filename_arg = 2;   
const out_filename_arg = 3; 
let in_file = process.argv[in_filename_arg];
let out_file = process.argv[out_filename_arg]; 

initMemBuff(mem_buff);
parseELF(in_file);

fs.writeFile(out_file, mem_buff.join('\n'), (err) => { 
    if (err) console.error(err); 
    else console.log("Initial memory state compiled successfully"); 
});

// ---

function parseELF(filename) {
    let data = fs.readFileSync(filename, 'utf-8');
    let lines = data.split('\n');

    let curr_state = null;
    lines.forEach(line => {
        line = line.trim();
        if (line.toLowerCase() === text_field) {
            curr_state = new TextState(text_base_addr, text_size, mem_buff);
            return; 
        }
        else if (line.toLowerCase() === data_field) {
            curr_state = new DataState(data_base_addr, data_size, mem_buff);
            return; 
        }

        if (curr_state == null) {
            throw new Error('Invalid ELF file format');
        }

        curr_state.parseLine(line);
    });
}

function initMemBuff(mem_buff) {
    for (let i = 0; i < mem_size; i++) {
        mem_buff[i] = mem_init_val;
    }
}

