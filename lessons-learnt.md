1. PDO is an interface and there are different drivers 

How do we use each driver ?  
=> When we mention which driver we are using in the `dsn` like **mysql** or **pgsql**, we are using that specific driver . 


We can check available drivers for us on our php installation using : 
```php
print_r(PDO::getAvailableDrivers());
// For me, it returned this 
/* Array
(
    [0] => mysql
    [1] => sqlite
    [2] => pgsql
) */
```


- mention the code chat provided in index.php