var StringUtils = require('../utils/StringUtils');
var ArrayUtils = require('../utils/ArrayUtils.js');
var _ = require('underscore');

/**
 * Repository Constructor
 * @constructor
 */
module.exports.Repository = function (config) {

    var idColumn = config.idColumn || 'uuid';
    var scope = config.scope || {};
    var table = config.table;
    var custom = config.queries || {};
    var overrides = config.overrides || {};
    var connection;

    var repository = this;

    var NamedQueries = {
        findAll: "SELECT * FROM {0}",
        find: "SELECT * FROM {0} WHERE {1} = {2}",
        findWhere: "SELECT * FROM {0} WHERE {1}",
        insert: "INSERT INTO {0} VALUES ({1})",
        remove: "DELETE FROM {0} WHERE {1} = {2}",
        update: "UPDATE {0} SET {1} WHERE {2} = {3}"
    };

    var queryCallback = function (err, rows, callback, error) {
        if(err)	{
            error.call(scope, err);
        }else{
            callback.call(scope, rows);
        }
    };

    repository.query = function (sql, callback, error) {
        connection.query(sql, function (err, rows){
            queryCallback(err, rows, callback, error);
        });
    };

    repository.bindConnection = function (mysqlConnection) {
        connection = mysqlConnection;
        return repository;
    };

    repository.update = overrides.update || function (id, updates, callback, error) {

        var sqlUpdates = ArrayUtils.asArray(updates).reduce(function (elements, item) {
            if (item.column && typeof item.value != undefined)
                elements.push(StringUtils.format(typeof item.value === 'number' ? "`{0}` = {1}" : "`{0}` = '{1}'", item.column, item.value));
            return elements;
        }, []);

        connection.query(StringUtils.format(NamedQueries.update, table, sqlUpdates.join(', '), idColumn, id), function (err, rows){
            queryCallback(err, rows, callback, error);
        });
    };

    // TODO
//    repository.updateObject = overrides.updateObject || function (obj, updates, callback, error) {
//        var id = obj[idColumn];
//    };

    repository.findAll = overrides.findAll || function (callback, error) {
        connection.query(StringUtils.format(NamedQueries.findAll, table), function(err, rows){
            queryCallback(err, rows, callback, error);
        });
    };

    repository.find = overrides.find || function (id, callback, error) {
        connection.query(StringUtils.format(NamedQueries.find, table, idColumn, id), function(err, rows){
            queryCallback(err, rows, callback, error);
        });
    };

    repository.findWhere = overrides.findWhere || function (wheres, callback, error) {
        var sqlWheres = ArrayUtils.asArray(wheres).reduce(function (elements, item) {
            if (item.column && typeof item.value != undefined)
                elements.push(StringUtils.format(typeof item.value === 'number' ? "`{0}` {1} {2}" : "`{0}` {1} '{1}'", item.column, item.operator || '=', item.value));
            return elements;
        }, []);

        connection.query(StringUtils.format(NamedQueries.findWhere, table, sqlWheres.join(', ')), function (err, rows){
            queryCallback(err, rows, callback, error);
        });
    };

    repository.insert = overrides.insert || function (values, callback, error) {
        connection.query(StringUtils.format(NamedQueries.insert, table, StringUtils.makeValuesString(values)), function (err, rows){
            queryCallback(err, rows, callback, error);
        });
    };

    repository.remove = overrides.remove || function (id, callback, error) {
        connection.query(StringUtils.format(NamedQueries.remove, table, idColumn, id), function (err, rows){
            queryCallback(err, rows, callback, error);
        });
    };

    // Custom functions
    _.each(custom, function (func, name) {
        if (repository[name]) return;

        repository[name] = function () {
            var args = Array.prototype.slice.call(arguments);
            func.apply(repository, args);
        };
    });

};
