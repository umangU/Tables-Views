CREATE VIEW old_books(first_name,last_name,book_title, edition)
AS SELECT a.first_name, a.last_name, b.title, e.edition 
FROM authors a, books b, editions e 
WHERE b.author_id = a.author_id 
AND e.book_id = b.book_id 
AND e.publication < '1990-01-01';


CREATE VIEW programming_or_perl(book_title)
AS SELECT b.title FROM  books b 
WHERE b.title LIKE '%Programming%' 
OR b.title LIKE '%Perl%';

CREATE VIEW retail_price_hike(ISBN, retail_price, increased_price)
AS SELECT s.isbn, s.retail, (s.retail * s.retail) FROM stock as s;
 

CREATE VIEW book_summary(author_first_name, author_last_name, book_title, subject)
AS SELECT a.first_name, a.last_name, b.title, s.subject 
FROM authors a, books b, subjects s WHERE b.author_id = a.author_id 
AND b.subject_id = s.subject_id;

CREATE VIEW value_summary(total_stock_cost, total_retail_cost)
AS SELECT (s.cost*s.stock), (s.retail*s.stock) FROM stock as s;


CREATE VIEW profits_by_isbn(book_title, edition_isbn, total_profit)
AS SELECT b.title, s.isbn, (s.retail*s.stock - s.cost*s.stock) 
FROM books b, stock s, editions e 
WHERE e.book_id = b.book_id AND e.isbn = s.isbn 
group by b.title, s.isbn; 


CREATE VIEW sole_python_author(author_first_name, author_last_name)
AS SELECT DISTINCT MAX(a.first_name), MAX(a.last_name) 
FROM authors a, books b WHERE a.author_id = b.author_id 
AND b.title LIKE '%Python%' 
GROUP BY b.title HAVING COUNT(a.author_id)<2;
 

                              
CREATE VIEW no_cat_customers(customer_first_name, customer_last_name)
AS SELECT c.first_name, c.last_name FROM customers c 
WHERE EXISTS (SELECT * FROM shipments s, editions e, books b 
WHERE e.book_id = b.book_id AND e.isbn = s.isbn AND s.c_id = c.c_id 
AND b.title = 'The Cat in the Hat'); 
