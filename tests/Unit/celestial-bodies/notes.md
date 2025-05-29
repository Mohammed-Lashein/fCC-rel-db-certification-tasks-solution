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