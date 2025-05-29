## Here I document project-specific notes about issues I encountered . 

**Note 1**

Beware of the differences between mysql and pgsql :   
**Mysql**
```sql
ALTER TABLE galaxy ADD COLUMN id int not null auto_increment;
```
**Pgsql**
```sql
alter table galaxy add column id serial;
```

You can also use `serial` in mysql as it was added in v8, but I like to stick to `auto_increment` in mysql.

____
**Note 2**  
How can I create a column and make it a foreign key in one sql statement ?  
```sql
ALTER TABLE star 
ADD COLUMN galaxy_id INTEGER, -- notice the importance of the comma here as without it you will get a syntax error
ADD FOREIGN KEY (galaxy_id) REFERENCES galaxy(id);
```