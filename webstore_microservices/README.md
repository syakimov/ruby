# webstore_microservices

## Brief

This is an oversimplified example of a service oriented design for an online store.

There are two rails apps in this repo - _users_ and _orders_, each of which consists of the following:

1. single model (User or Order) with a few columns;
2. single index view (http://localhost:3000/users or http://localhost:3001/orders);
3. prepoluted sqlite database.

The _users_ app is meant to run on port 3000, while the _orders_ one on port 3001. The two apps are meant to interact dynamically with each other through an API (non existent).

## Task

Create an API connection between the two apps so that the user fields (Client first name, Client last name, Client email) on the orders page (http://localhost:3001/orders) show the actual user data form the _users_ app. That's all.

Beware of couple rules:

1. do not change schemas, migrations nor the records in the dbs;
2. **do not fork this repo - clone it instead**.
