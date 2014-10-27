var mysql = require('mysql');
var restify = require('restify');
var _ = require('underscore');

var Root = '/api/v0/';

var S = restify.createServer();
var connection =  mysql.createConnection({
    host: "localhost",
    user: "root",
    password: ""
});

connection.connect();
connection.query('use guild_manager');

var Repositories = require('./data/Repositories');
var HeroRepository = Repositories.Hero.bindConnection(connection);
var GuildRepository = Repositories.Guild.bindConnection(connection);
var ContractRepository = Repositories.Contract.bindConnection(connection);

S.get(Root+'guild', function (req, res) {
    GuildRepository.findAll(function (guilds) {
        res.send({ success: true, data: guilds });
    });
});

S.get(Root+'hero', function (req, res) {
    HeroRepository.findAll(function (heroes) {
        res.send({ success: true, data: heroes });
    });
});

S.get(Root+'contract', function (req, res){
    ContractRepository.findAll(function (contract){
        res.send({ success: true, data: contract });
    });
});

S.get(Root+'contract/by/open', function (req, res) {
    ContractRepository.findWhere([{
        column: 'state',
        value: 0
    }],function (contracts) {
        res.send({ success: true, data: contracts });
    });
});

S.get(Root+'contract/by/guild/:guild', function (req, res) {
    var guild =  req.params.guild;

    GuildRepository.getGuildContracts(guild, function (contracts) {
        res.send({ success: true, data: contracts });
    }, function (error) {
        res.send({ success: false, message: error });
    });
});

S.get(Root+'hero/by/guild/:guild', function (req, res){
    var guild =  req.params.guild;

    GuildRepository.getGuildHeroes(guild, function (heroes) {
        res.send({ success: true, data: heroes });
    }, function (error) {
        res.send({ success: false, message: error });
    });
});

S.get(Root+'building/by/guild/:guild', function (req, res){
    var guild =  req.params.guild;

    GuildRepository.getGuildBuildings(guild, function (buildings) {
        res.send({ success: true, data: buildings });
    }, function (error) {
        res.send({ success: false, message: error });
    });
});



S.listen(8080, function() {
    console.log('%s listening at %s', S.name, S.url);
});