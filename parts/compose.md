# DOCKER COMPOSE

## Enjeu

* docker compose est un plugin qui permet 
  - de piloter l'installation de microservices 
  - à partir d'un fichier de configuration nommé **docker-compose.yml**
  - au format **YAML**

## Rappel sur YAML

* YAML est un format de données basé sur les paires clés / valeur, comme JSON
  - ex. `key: value` en YAML correspond à `{"key": "value"} en JSON`
  - '{}' et '""' ne sont pas utilisés
  - l'imbrication est assurée par l'indentation

  `{"obj": {"param 1": 1,"param 2": "bonjour","param 3": 3.14}}`
  
  ```json
  {
    "obj": {
        "param 1": 1,
        "param 2": "bonjour",
        "param 3": 3.14
    }
  }
  ```

  - correspond à

```yaml
obj:
  param 1: 1
  param 2: bonjour
  param 3: 3.14
```

- les listes sont gérées par indentation plus préfixage par "- " ex:

`{"obj": {"param 1": ["bonjour", 44, {"key": "value", "key2": "value2"}]}`

- soit

```json
  {
    "obj": {
        "param 1": [
            "bonjour", 44, {"key": "value", "key2": "value2"}
        ]
    }
  }
  ```

  - correspond à 

```yaml
obj:
  param 1:
    - bonjour
    - 44
    - key: value
      key2: value2
```