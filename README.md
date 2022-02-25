
# Desafio final

## APIs
https://servicodados.ibge.gov.br/api/v1/localidades/estados
https://servicodados.ibge.gov.br/api/v1/localidades/estados/35/distritos

## Tabelas
Escolha uma das propostass e resolva os detalhes. Duvidas na comunidade.

### Proposta 1
```
CREATE TABLE estado (
  id int not null primary key auto_increment,
  uf varchar(2),
  nome varchar(255)
);


CREATE TABLE cidade (
  id int not null primary key auto_increment,
  id_uf int,
  nome varchar(255),
   FOREIGN KEY (id_uf)
      REFERENCES estado(id)
);​
```
### Proposta 2
No campo uuid usem este package: https://pub.dev/packages/uuid
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


# Resumo dos jsons
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
# Estrutura
```
[d] lib
  [d] data
    [d] model
      [d] repository
      [-] estado_repository(source:)
        [d] api1
          [-] estado_source()
        [d] db1
```
