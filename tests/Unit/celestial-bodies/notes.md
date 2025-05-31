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
____

**Note 3**
- How to create a column in a table and make that column a foreign key in one sql command ?
=> There is 1 gotcha and that is we need to make the connecting col in the other table as **unique** or a **pk** in order to be able to refer to it in the foreign key constraint (The code is much clearer than the description :) .  

so how can I alter the id col in the star table ?  
wrong commands : 
```sql
alter table star alter column id add constraint primary key;
-- Don't use add constraint if you won't give an explicit name to the pk
alter table star add constraint primary key(id);
```

The correct sql : 
```sql
 alter table star add primary key(id);
 alter table galaxy add column star_id int not null, add foreign key(star_id) references star(id);
```