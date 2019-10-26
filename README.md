# deli database app

## notice
### settings environment variables

database password
google map api key

## definition document

- concept

> personal app, db of restraurants serve foods we wanna eat  
without extra info, extra property  
secret


- tool

|name|field|
|:-:|:-:|
|ruby|server|
|rails|server|
|mysql|server|
|react(as possible)|front|
|bootstrap|front|
|docker|infra|
|github|manage|
|clickup|manage|

- system design
	- user authentication
	- tagged kinds of foodse
	- only restraurant url
	- like board

## dev internal design

### view

- top
	- login form(*1)
	- to create user form(*1)

- board
	- search articles
	- articles
	- to create article(*2)

- article
	- article
	- create comment
	- to edit this(*2)

- setting
	- user setting(*1)
	- tag setting

### db model

- users

|name|type|etc|
|:-:|:-:|:-:|
|id|integer|not null, primary key|
|name|string|not null, unique|
|password_digest|string|not null|
|created_at|datetime|not null|
|updated_at|datatime|not null|

- articles

|name|type|etc|
|:-:|:-:|:-:|
|id|integer|not null, primary key|
|name|string| |
|title|string|not null|
|url|string| |
|body|text| |
|area_id|string| |
|created_at|datetime|not null|
|updated_at|datatime|not null|

- comments

|name|type|etc|
|:-:|:-:|:-:|
|id|integer|not null, primary key|
|name|string| |
|comment|text|not null|
|article_id|integer|foreign key|
|created_at|datetime|not null|
|updated_at|datatime|not null|

- tags

|name|type|etc|
|:-:|:-:|:-:|
|id|integer|not null, primary key|
|name|string|not null|
|created_at|datetime|not null|
|updated_at|datatime|not null|

- article_tag_relations

|name|type|etc|
|:-:|:-:|:-:|
|id|integer|not null, primary key|
|article_id|integer|not null|
|tag_id|integer|not null|
|created_at|datetime|not null|
|updated_at|datatime|not null|

- favorite_article_relations

|name|type|etc|
|:-:|:-:|:-:|
|id|integer|not null, primary key|
|user_id|integer|not null|
|article_id|integer|not null|
|created_at|datetime|not null|
|updated_at|datatime|not null|

- prefecture(*active_hash*)

|name|type|etc|
|:-:|:-:|:-:|
|id|integer|not null, primary key|
|name|string|not null|
