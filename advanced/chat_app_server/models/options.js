const Option = require("./option");

class Options {
    constructor() {
        this.options = [];
    }

    addOption(option = new Option()) {
        this.options.push(option);
    }

    getOptions() {
        return this.options;
    }

    deleteOption(id = '') {
        this.options = this.options.filter(op => op.id !== id);
        return this.options;
    }

    voteOption(id = '') {
        this.options = this.options.map(op => {
            if (op.id === id) {
                op.votes++;
                return op;
            } else {
                return op;
            }
        });
    }
}

module.exports = Options;
