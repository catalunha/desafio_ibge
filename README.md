# api
Estado
```json
[
  {
    "id": 11,
    "sigla": "RO",
    "nome": "Rondônia",
    "regiao": {
      "id": 1,
      "sigla": "N",
      "nome": "Norte"
    }
  },
]
```


Distrito
```json
[
  {
    "id": "110001505",
    "nome": "Alta Floresta D'Oeste",
    "municipio": {
      "id": "1100015",
      "nome": "Alta Floresta D'Oeste",
      "microrregiao": {
        "id": 11006,
        "nome": "Cacoal",
        "mesorregiao": {
          "id": 1102,
          "nome": "Leste Rondoniense",
          "UF": {
            "id": 11,
            "sigla": "RO",
            "nome": "Rondônia",
            "regiao": {
              "id": 1,
              "sigla": "N",
              "nome": "Norte"
            }
          }
        }
      },
]
```

# tabelas
123e4567-e89b-12d3-a456-426655440000
```
drop table estado;
CREATE TABLE estado (
  uuid varchar(36) not null primary key,
  id int,
  sigla varchar(2),
  nome varchar(255)
);
drop table distrito;
CREATE TABLE distrito (
  uuid varchar(36) not null primary key,
  uuidEstado varchar(36),
  id varchar(25),
  nome varchar(255),
   FOREIGN KEY (uuidEstado)
      REFERENCES estado(uuid)
);​
```
