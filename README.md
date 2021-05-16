# EVE Static Database

CCP provides [Static Data Export(SDE)](https://developers.eveonline.com/resource/resources),
but the original data is in YAML format, it is cumbersome to create a third party tool.

This tool converts SDE to MySQL database.
You can also download the converted MySQL Database file from [here](https://doc.densan-labs.net/eve/TODO).

# Prerequisite

- Ruby 2.7 or higher
- MySQL 5.7 or higher


# How to use it

First, download the SDE, extract it, and place it in the ./data directory as follows.

```
data/
└── sde
    ├── bsd
    │   ├── invFlags.yaml
    │   ├── invItems.yaml
    │   ├── invNames.yaml
    │   ├── invPositions.yaml
    │   ├── invUniqueNames.yaml
    │   └── staStations.yaml
    └── fsd
        ├── agentsInSpace.yaml
        ├── agents.yaml
        ├── ancestries.yaml
        ├── bloodlines.yaml
        ├── blueprints.yaml
        ├── categoryIDs.yaml
        ├── certificates.yaml
        ├── characterAttributes.yaml
        ├── contrabandTypes.yaml
        ├── controlTowerResources.yaml
        ├── corporationActivities.yaml
        ├── dogmaAttributeCategories.yaml
        ├── dogmaAttributes.yaml
        ├── dogmaEffects.yaml
        ├── factions.yaml
        ├── graphicIDs.yaml
        ├── groupIDs.yaml
        ├── iconIDs.yaml
        ├── landmarks
        ├── marketGroups.yaml
        ├── metaGroups.yaml
        ├── npcCorporationDivisions.yaml
        ├── npcCorporations.yaml
        ├── planetSchematics.yaml
        ├── races.yaml
        ├── researchAgents.yaml
        ├── skinLicenses.yaml
        ├── skinMaterials.yaml
        ├── skins.yaml
        ├── stationOperations.yaml
        ├── stationServices.yaml
        ├── tournamentRuleSets.yaml
        ├── translationLanguages.yaml
        ├── typeDogma.yaml
        ├── typeIDs.yaml
        ├── typeMaterials.yaml
        └── universe
```

Next, run setup.sh, and edit database.yml.

```
bin/setup.sh
```

And run rebuild\_database.rb.

```
bundle exec ruby bin/rebuild_database.rb
```

Finally, run the following command to import the yaml data into your MySQL database.

```
bundle exec ruby importer.rb
```

# Supported Data

- Blueprint: 100%
- typeIDs: traits is not supported.


# SDE LICENSE

For the license of SDE provided by CCP, please refer to https://developers.eveonline.com/resource/license-agreement.
