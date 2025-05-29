<?php

beforeAll(function() {
  
  /*
  You can't use $this in beforeAll() and afterAll() hooks because
  each of them runs either before or after test instances so we no longer have access to instance objects to which the $this variable could refer to. 
   */
});
/* In order for you to be able to connect to the db while running from tests file, you should use 127.0.0.1 
instead of localhost as  the former uses unix sockets*, which allows connecting to the db for code not just the browser

Regarding unix sockets, they are explained in a good way in the book "Computer Networking A top down approach 8th-edition" . You can check it out there

*/
$dbConn = new PDO(
  'pgsql:host=127.0.0.1;dbname=universe',
  'mohammedlashein',
  '',
  [PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]
);

const GET_DB_TABLES = "select * from information_schema.tables where table_schema ='public' and table_type='BASE TABLE';";

it('should contain the specified tables', function() use ($dbConn){
  $stmt = $dbConn->query(GET_DB_TABLES);
  /* 
    Is number 2 a magic number ?
    It is corresponding to the col having the table names from the returned result of running the query . 
  */
  $res = $stmt->fetchAll(PDO::FETCH_COLUMN, 2);
  // var_dump($res);
  expect($res)->toMatchArray(['galaxy', 'star', 'planet', 'moon']);
});