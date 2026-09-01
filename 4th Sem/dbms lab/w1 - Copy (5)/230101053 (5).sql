DROP DATABASE IF EXISTS week05;
CREATE DATABASE week05;
USE week05;

DROP TABLE IF EXISTS ChessTable;
CREATE TABLE ChessTable(
	curr_move_no INT,
	player CHAR(10),
	piece CHAR(10),
	start_sqre CHAR(2),
	end_sqr CHAR(2),
	isCapture TINYINT,
	isCastle TINYINT,
	isCheck TINYINT,
	is_check_mate TINYINT,
   isPromoted TINYINT,
   promoted_to CHAR(10)
);


--  task 3 done in a c file and results stored in insert_moves.sql

SELECT * FROM ChessTable;

--Task 4

--1 to 5
SELECT * FROM ChessTable WHERE player = 'WHITE' AND piece= 'Rook';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND piece= 'Knight';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND piece= 'Bishop';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND piece= 'Queen';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND piece= 'King';


-- 6 to 10
SELECT * FROM ChessTable WHERE player = 'BLACK' AND piece= 'Rook';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND piece= 'Knight';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND piece= 'Bishop';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND piece= 'Queen';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND piece= 'King';

-- 11 to 22
SELECT COUNT(*) FROM ChessTable WHERE player = 'WHITE' AND isCapture=1;
SELECT COUNT(*) FROM ChessTable WHERE player = 'BLACK' AND isCapture=1;

SELECT COUNT(*) FROM ChessTable WHERE player = 'WHITE' AND isCapture=1 AND piece= 'Rook';
SELECT COUNT(*) FROM ChessTable WHERE player = 'WHITE' AND isCapture=1 AND piece= 'Knight';
SELECT COUNT(*) FROM ChessTable WHERE player = 'WHITE' AND isCapture=1 AND piece= 'Bishop';	
SELECT COUNT(*) FROM ChessTable WHERE player = 'WHITE' AND isCapture=1 AND piece= 'Queen';
SELECT COUNT(*) FROM ChessTable WHERE player = 'WHITE' AND isCapture=1 AND piece= 'King';


SELECT COUNT(*) FROM ChessTable WHERE player = 'BLACK' AND isCapture=1 AND piece= 'Rook';
SELECT COUNT(*) FROM ChessTable WHERE player = 'BLACK' AND isCapture=1 AND piece= 'Knight';
SELECT COUNT(*) FROM ChessTable WHERE player = 'BLACK' AND isCapture=1 AND piece= 'Bishop';
SELECT COUNT(*) FROM ChessTable WHERE player = 'BLACK' AND isCapture=1 AND piece= 'Queen';
SELECT COUNT(*) FROM ChessTable WHERE player = 'BLACK' AND isCapture=1 AND piece= 'King';


-- 23 to 30
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isCheck=1 AND piece= 'Rook';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isCheck=1 AND piece= 'Knight';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isCheck=1 AND piece= 'Bishop';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isCheck=1 AND piece= 'Queen';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isCheck=1 AND piece= 'King';


SELECT * FROM ChessTable WHERE player = 'BLACK' AND isCheck=1 AND piece= 'Rook';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND isCheck=1 AND piece= 'Knight';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND isCheck=1 AND piece= 'Bishop';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND isCheck=1 AND piece= 'Queen';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND isCheck=1 AND piece= 'King';

SELECT * FROM ChessTable WHERE player = 'WHITE' AND isCastle=1 AND end_sqr = 'g1';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isCastle=1 AND end_sqr = 'c1';

SELECT * FROM ChessTable WHERE player = 'BLACK' AND isCastle=1 AND end_sqr = 'g8';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND isCastle=1 AND end_sqr = 'c8';

-- 35 to 42
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isPromoted=1 AND promoted_to = 'Queen';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isPromoted=1 AND promoted_to = 'Rook';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isPromoted=1 AND promoted_to = 'Knight';
SELECT * FROM ChessTable WHERE player = 'WHITE' AND isPromoted=1 AND promoted_to = 'Bishop';

SELECT * FROM ChessTable WHERE player = 'BLACK' AND isPromoted=1 AND promoted_to = 'Queen';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND isPromoted=1 AND promoted_to = 'Rook';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND isPromoted=1 AND promoted_to = 'Knight';
SELECT * FROM ChessTable WHERE player = 'BLACK' AND isPromoted=1 AND promoted_to = 'Bishop';

--TASK 5

SELECT * FROM ChessTable WHERE (ASCII(SUBSTRING(start_sqre, 1, 1)) - ASCII('a') + 1 + CAST(SUBSTRING(start_sqre, 2, 1) AS UNSIGNED)) % 2 = 0;

SELECT * FROM ChessTable WHERE end_sqr IN ('d4', 'e4', 'd5', 'e5');

SELECT  DISTINCT start_sqre FROM ChessTable
UNION
SELECT DISTINCT end_sqr FROM ChessTable;


SELECT DISTINCT start_sqre 
FROM ChessTable
WHERE start_sqre NOT IN (SELECT DISTINCT end_sqr FROM ChessTable);
