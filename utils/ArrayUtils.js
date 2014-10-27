var _ = require('underscore');

exports.asArray = function (obj) {
    if (_.isArray(obj)) return obj;
    return [obj];
};
