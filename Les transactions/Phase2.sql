-- Active: 1664375272525@@127.0.0.1@3306@papyrus


--Phase 2 - Mise en situation.

--Exercice 1:
START TRANSACTION;

SELECT nomfou FROM fournis WHERE numfou=120;

UPDATE fournis  SET nomfou= 'GROSBRIGAND' WHERE numfou=120 


