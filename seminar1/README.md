## Fill data


conections : postgresql://postgres:123@localhost:5432/"name"


Naplnenie tabuliek dátami z CSV súborov pomocou `\copy` (poradie je dôležité kvôli cudzím kľúčom — `customers` a `products` musia byť naplnené pred `orders`):

```sql
\copy customers FROM '/Users/ixsaiw/ukf/DatabazoveTechnologie/seminar1/zadanie_a/data/customers.csv' DELIMITER ',' CSV HEADER;
\copy products FROM '/Users/ixsaiw/ukf/DatabazoveTechnologie/seminar1/zadanie_a/data/products.csv' DELIMITER ',' CSV HEADER;
\copy orders FROM '/Users/ixsaiw/ukf/DatabazoveTechnologie/seminar1/zadanie_a/data/orders.csv' DELIMITER ',' CSV HEADER;
```
