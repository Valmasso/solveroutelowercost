# SolveRouteLowerCost
[![Code Climate](https://codeclimate.com/github/Valmasso/solveroutelowercost/badges/gpa.svg)](https://codeclimate.com/github/Valmasso/solveroutelowercost) [![Test Coverage](https://codeclimate.com/github/Valmasso/solveroutelowercost/badges/coverage.svg)](https://codeclimate.com/github/Valmasso/solveroutelowercost/coverage) [![Build Status](https://travis-ci.org/Valmasso/solveroutelowercost.svg)](https://travis-ci.org/Valmasso/solveroutelowercost)

Este repositório contém uma aplicação web simples, cujo o intuito é resolver o menor valor de entrega e seu caminho.

## Ruby version

* ruby 2.1.2

### Configuration

```bash
git clone git@github.com:Valmasso/solveroutelowercost.git
cd solveroutelowercost
bundle install
```

### Database creation

```bash
bundle exec rake db:create
```

### Database initialization

```bash
bundle exec rake db:migrate
```

### How to run the test suite

```bash
bundle exec rspec
```

## Executando

Iniciando o servidor:

```bash
cd solveroutelowercost
bundle exec rails server
```

Um servidor web estará escutando na porta 3000 da máquina local.

## Execução

O formato de malha logística é bastante simples, cada linha mostra uma rota: ponto de origem, ponto de destino e distância entre os pontos em quilômetros. O arquivo ``data.txt`` na raíz do projeto, contém os seguintes dados:

```
D E 30
A C 20
C D 30
A B 10
B E 50
B D 15
```

A entrada dos dados utiliza a regra: ``ORIGEM DESTINO DISTANCIA``.

### Listando os mapas cadastrados (#index)

```bash
curl -i http://localhost:3000/maps
```

### Criando um mapa (#create)

```bash
curl -i http://localhost:3000/maps/mymap -X POST -d "`cat data.txt`"
```

### Exibindo um mapa (#show)

```bash
curl -i http://localhost:3000/maps/mymap
```

### Atualizando um mapa (#update)

```bash
curl -i http://localhost:3000/maps/mymap -X PUT -d "`cat data.txt`"
```

### Removendo um mapa (#destroy)

```bash
curl -i http://localhost:3000/maps/mymap -X DELETE
```

### Resolvendo o menor valor de entrega e seu caminho (#search)

A entrada segue o formato:

```
ORIGEM DESTINO AUTONOMIA VALOR_LITRO
```

Para os dados contidos em ``data.txt``, faça a seguinte requisição:

```bash
curl -i http://localhost:3000/maps/mymap/search -X POST -d 'A D 10 2.5'
```

Resposta ``A B D 6.25``.
