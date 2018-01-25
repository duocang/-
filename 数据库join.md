####Table A

   id | name
  --- | ---        
1  | Pirate     
2  | Monkey     
3  | Ninja      
4  | Spaghetti  

###Table B

 id | name
 ---  |----
 1   |Rutabaga
 2   |Pirate
 3   |Darth Vader
 4   |Ninja
 
 
####1. Inner join产生的结果集中，是A和B的交集。
 
 ```sql
SELECT * FROM TableA
INNER JOIN TableB
ON TableA.name = TableB.name
 
 ```
id | name    |   id |  name
--- | ----    |  --- |  ----
1  | Pirate  |   2  |  Pirate
3  | Ninja   |   4  |  Ninja
 ![](https://coolshell.cn/wp-content/uploads/2011/01/Inner_Join.png)
 
####2.  Full outer join 产生A和B的并集。但是需要注意的是，对于没有匹配的记录，则会以null做为值。
 
```sql
SELECT * FROM TableA
FULL OUTER JOIN TableB
ON TableA.name = TableB.name
```

id   | name     | id   | name
---  | ----     | ---  | ----
1    | Pirate   | 2    | Pirate
2    | Monkey   | null | null
3    | Ninja    | 4    | Ninja
4    | Spaghetti| null | null
null | null     | 1    | Rutabaga
null | null     | 3    | Darth Vader

![](https://coolshell.cn/wp-content/uploads/2011/01/Full_Outer_Join.png)

####3. Left outer join 产生表A的完全集，而B表中匹配的则有值，没有匹配的则以null值取代。

```sql
SELECT * FROM TableA
LEFT OUTER JOIN TableB
ON TableA.name = TableB.name
```
id | name      | id   | name
---| ----      | ---  | ----
1  | Pirate    | 2    | Pirate
2  | Monkey    | null | null
3  | Ninja     | 4    | Ninja
4  | Spaghetti | null | null

![](https://coolshell.cn/wp-content/uploads/2011/01/Left_Outer_Join.png)

####4. 产生在A表中有而在B表中没有的集合。

```sql
SELECT * FROM TableA
LEFT OUTER JOIN TableB
ON TableA.name = TableB.name
WHERE TableB.id IS null 
```

id | name      | id   |  name
---| ----      | ---  |  ----
2  | Monkey    | null |  null
4  | Spaghetti | null |  null

![](https://coolshell.cn/wp-content/uploads/2011/01/Left_Out_Join_2.png)

####5. 产生A表和B表都没有出现的数据集。

```sql
SELECT * FROM TableA
FULL OUTER JOIN TableB
ON TableA.name = TableB.name
WHERE TableA.id IS null
OR TableB.id IS null
```
id   | name      | id   | name
---  | ----      | ---  | ----
2    | Monkey    | null | null
4    | Spaghetti | null | null
null | null      | 1    | Rutabaga
null | null      | 3    | Darth Vader

![](https://coolshell.cn/wp-content/uploads/2011/01/Full_Outer_Join_2.png)


















