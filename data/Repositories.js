var constructors = require('../factories/RepositoryFactory.js');
var StringUtils = require('../utils/StringUtils.js');

module.exports.Hero = new constructors.Repository({
    table: 'hero'
});

module.exports.Contract = new constructors.Repository({
    table: 'contract'
});

module.exports.Equipment = new constructors.Repository({
    table: 'equipment'
});

module.exports.Building = new constructors.Repository({
    table: 'building'
});

module.exports.Guild = new constructors.Repository({
    table: 'guild',
    queries: {
        getGuildHeroes: function (id, callback, error) {
            var sql = "SELECT * from hero h JOIN guild_hero gh ON h.uuid = gh.hero_uuid WHERE gh.guild_uuid = '{0}'";
            this.query(StringUtils.format(sql, id), callback, error);
        },
        getGuildContracts: function (id, callback, error) {
            var sql = "SELECT * from contract c JOIN guild_contract gc ON c.uuid = gc.contract_uuid WHERE gc.guild_uuid = '{0}'";
            this.query(StringUtils.format(sql, id), callback, error);
        },
        getGuildBuildings: function (id, callback, error) {
            var sql = "SELECT * from building b JOIN guild_building gb ON b.uuid = gb.building_uuid WHERE gb.guild_uuid = '{0}'";
            this.query(StringUtils.format(sql, id), callback, error);
        }
    }
});

