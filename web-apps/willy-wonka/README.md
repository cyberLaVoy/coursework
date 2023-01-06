# Ticket Management Application Documentation

## Resources:

#### tickets
##### Attributes:
* entrant_name
* entrant_age
* guest_name
* random_token


## Database Schema:
```SQL
CREATE TABLE tickets
(id INTEGER PRIMARY KEY,
 entrant_name VARCHAR(255),
 entrant_age INTEGER,
 guest_name VARCHAR(255),
 random_token INTEGER);
```


## REST Endpoints:
Name | HTTP Method | Path
------------ | ------------- | -------------
List | GET | /tickets
Create | POST | /tickets
