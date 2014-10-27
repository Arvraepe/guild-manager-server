exports.format = function (string) {
    for (var i = 1; i < arguments.length; i += 1) {
        string = string.replace(new RegExp("\\{" + (i-1) + "\\}", "gm"), arguments[i]);
    }
    return string;
};

exports.makeValuesString = function (values) {
    return values.map(function (item) {
        if (typeof item === 'string') {
            return "'"+item+"'";
        } else if (item === null) {
            return 'null';
        }
        return item;
    }).join(', ');
};
