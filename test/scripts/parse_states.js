const { relocate } = require('./relocator');

class ParseState {
    constructor(base, max_size, mem_buff, enable_relocate, section_comment) {
        this.base = base;
        this.max_size = max_size;
        this.mem_buff = mem_buff;
        this.enable_relocate = enable_relocate;
        this.section_comment = section_comment; 

        this.offset = 0;
    }

    parseLine(line) {
        if (this.offset + 1 >= this.max_size) return;

        if (this.enable_relocate) line = relocate(line);
        
        if (this.offset == 0) line += ' ' + this.section_comment; 
        this.mem_buff[this.base + this.offset] = line;
        this.offset++;
    }
}

class DataState extends ParseState {
    constructor(base, max_size, mem_buff) {
        super(base, max_size, mem_buff, false, 'FIRST DATA');
    }
}

class TextState extends ParseState {
    constructor(base, max_size, mem_buff) {
        super(base, max_size, mem_buff, true, 'FIRST TEXT');
    }
}

module.exports = {
    ParseState, 
    DataState,
    TextState
}; 