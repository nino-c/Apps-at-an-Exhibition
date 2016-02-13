import json

dbfile = '/home/ninopq/Projects/plsys/db_backup/datadump-02-05-16.json'
db = json.loads(open(dbfile, 'r').read())

game = filter(lambda item: item['model'] == 'game.zeroplayergame', db)
instances = filter(lambda item: item['model'] == 'game.gameinstance', db)
snapshots = filter(lambda item: item['model'] == 'game.gameinstancesnapshot', db)
print len(game), len(instances), len(snapshots)

print [item['pk'] for item in game]
