CREATE DATABASE project_fl;

USE project_fl;

-- Table 1
CREATE TABLE assets (
aticker varchar(6) PRIMARY KEY,
aname varchar(200),
acurrency varchar(3),
aclass varchar(20)
);

-- Table 2
CREATE TABLE brokers (
broker_id VARCHAR(5) PRIMARY KEY,
bname varchar(50),
bcountry varchar(50),
account_number varchar(15)
);

-- Table 3
CREATE TABLE transactions (
transaction_id INT AUTO_INCREMENT PRIMARY KEY,
tdate DATE,
tticker VARCHAR(6), 
CONSTRAINT fk_tticker FOREIGN KEY (tticker) REFERENCES assets (aticker),
tquantity FLOAT,
tprice DECIMAL(6,2),
tbroker_id VARCHAR(5),
ttype VARCHAR(10)
);

ALTER TABLE transactions
ADD CONSTRAINT fk_tbroker_id
FOREIGN KEY (tbroker_id)
REFERENCES brokers (broker_id);

-- Table 4
CREATE TABLE current_position (
cticker varchar(6) PRIMARY KEY,
cquantity float,
c_avg_price decimal(6,2),
ccurrency varchar(3),
cbroker_id varchar(5)
);

ALTER TABLE current_position
ADD CONSTRAINT fk_cticker
FOREIGN KEY (cticker)
REFERENCES assets (aticker);

ALTER TABLE current_position
ADD CONSTRAINT fk_cbroker_id
FOREIGN KEY (cbroker_id)
REFERENCES brokers (broker_id);

-- Table 5
CREATE TABLE dividends (
div_id VARCHAR(6) PRIMARY KEY,
date DATE,
dticker VARCHAR(6), 
CONSTRAINT fk_dticker FOREIGN KEY (dticker) REFERENCES assets (aticker),
dquantity FLOAT,
gross_amount DECIMAL(6,2),
tax FLOAT,
net_amount DECIMAL(6,2)
);

-- TRIGGER: sets all tickers letters to uppercase in assets table
DELIMITER //

CREATE TRIGGER ticker_upper
BEFORE INSERT ON assets
FOR EACH ROW
BEGIN
SET NEW.aticker = UPPER(NEW.aticker);
END //

DELIMITER ;

-- Populating table assets:
INSERT INTO assets
(aticker, aname, acurrency, aclass)
VALUES 
('vwrl', 'Vanguard FTSE All-World UCITS', 'GBP', 'ETF'),
('INRG', 'iShares Global Clean Energy UCITS', 'USD', 'ETF'),
('ESPO', 'VanEck Video Gaming and eSports UCITS', 'USD', 'ETF'),
('SWAN', 'Amplify BlackSwan Growth & Treasury Core', 'USD', 'ETF'),
('VNQI', 'Vanguard Global ex-US Real Estate Index', 'USD', 'ETF'),
('DH2O', 'iShares Global Water UCITS', 'USD', 'ETF'),
('VOO', 'Vanguard 500 Index Fund', 'USD', 'ETF'),
('NOBL', 'ProShares S&P 500 Dividend Aristocrats', 'USD', 'ETF'),
('SPMV', 'iShares Edge S&P 500 Min Vol', 'USD', 'ETF'),
('MOAT', 'VanEck Morningstar Wide Moat', 'USD', 'ETF'),
('URTH', 'iShares MSCI World', 'USD', 'ETF'),
('IUHC', 'iShares S&P 500 Health Care Sctr UCITS', 'USD', 'ETF'),
('VNQ', 'Vanguard Real Estate Index Fund', 'USD', 'ETF'),
('TIP', 'iShares TIPS Bond ETF', 'USD', 'ETF'),
('HYG', 'iShares iBoxx $ High Yield Corporate Bond ETF', 'USD', 'ETF'),
('WING', 'iShares Fallen Angels HY Corp Bd', 'USD', 'ETF'),
('VEA', 'Vanguard Developed Markets Index Fund', 'USD', 'ETF'),
('SXR8', 'iShares Core S&P 500 UCITS (Acc)', 'EUR','ETF'),
('IDJG', 'iShares Euro Total Mrkt Grwth Lrg UCITS', 'EUR', 'ETF'),
('TRET', 'VanEck Global Real Estate UCITS', 'EUR', 'ETF'),
('IHYG', 'iShares High Yield Corp Bond UCITS', 'EUR', 'ETF'),
('HPQ', 'HPQ INC', 'USD', 'Stock'),
('WPM', 'Wheaton Precious Metals Corp', 'USD', 'Stock'),
('KMB', 'Kimberly Clark Corp', 'USD', 'Stock'),
('aapl', 'Apple Inc', 'USD', 'Stock'),
('DIS','Walt Disney Co', 'USD', 'Stock'),
('JNJ','Johnson & Johnson', 'USD', 'Stock'),
('JPM','JPMorgan Chase & Co', 'USD','Stock'),
('KO','Coca-Cola Co', 'USD', 'Stock'),
('PG','Procter & Gamble Co', 'USD', 'Stock'),
('MMM','3M Co', 'USD', 'Stock'),
('MSFT','Microsoft Corp', 'USD', 'Stock'),
('sbux', 'Starbucks Corporation', 'USD', 'Stock'),
('T', 'AT&T Inc.', 'USD', 'Stock'),
('WBA', 'Walgreens Boots Alliance Inc', 'USD', 'Stock'),
('WBD', 'Warner Bros Discovery Inc', 'USD', 'Stock'),
('O', 'Realty Income Corp', 'USD', 'Reits'),
('PLD', 'Prologis Inc', 'USD', 'Reits'),
('ARE', 'Alexandria Real Estate Equities Inc', 'USD', 'Reits'),
('DLR', 'Digital Realty Trust Inc', 'USD', 'Reits'),
('FRT', 'Federal Realty Investment Trust', 'USD', 'Reits'),
('PSA', 'Public Storage', 'USD', 'Reits'),
('WELL', 'Welltower Inc', 'USD', 'Reits'),
('eqr', 'Equity Residential', 'USD', 'Reits'),
('BXP', 'Boston Properties Inc', 'USD', 'Reits'),
('ESS', 'Essex Property Trust Inc', 'USD', 'Reits');

SELECT * FROM assets;

-- Populating table brokers
INSERT INTO brokers
(broker_id, bname, bcountry, account_number)
VALUES
('IB', 'Interactive Brokers', 'United States', 'u5701841'),
('T212', 'Trading212', 'United Kingdom', '2928416'),
('DG', 'Degiro', 'Netherlands', 'fmcl9094');

SELECT * FROM brokers;

-- Populating table current position
INSERT INTO current_position
(cticker, cquantity, c_avg_price, ccurrency, cbroker_id)
VALUES
('WBA',10,44.8,'USD','IB'),
('MMM',4,166.16,'USD','IB'),
('O',35,63.40,'USD','IB'),
('VEA',18,47.05,'USD','T212'),
('VNQ',12,76.56,'USD','T212'),
('NOBL',34,56.03,'USD','T212'),
('PSA',2,163.20,'USD','DG'),
('DLR',6,145.51,'USD','DG'),
('VOO',6,280.02,'USD','T212'),
('KO',16,49.56,'USD','IB'),
('KMB',6,158.17,'USD','IB'),
('HYG',4,87.25,'USD','T212'),
('FRT',6,73.30,'USD','DG'),
('JPM',2,153.11,'USD','IB'),
('T',8,26.61,'USD','IB'),
('AAPL',2,116.28,'USD','IB'),
('PG',1,137.38,'USD','IB'),
('SBUX',3,78.96,'USD','IB'),
('WELL',5,58.07,'USD','DG'),
('JNJ',2,147.70,'USD','IB'),
('TIP',4,127.24,'USD','T212'),
('MSFT',1,258.45,'USD','IB'),
('URTH',9,94.21,'USD','DG'),
('VNQI',8,47.51,'USD','DG'),
('MOAT',7,64.22,'USD','T212'),
('DIS',2,121.72,'USD','IB');

SELECT * FROM current_position;

-- Populating table dividends
INSERT INTO dividends
(div_id, date, dticker, dquantity, gross_amount, tax, net_amount)
VALUES
('div_01', '2022-09-10', 'WBA',5,2.4,0.72,1.68),
('div_02', '2022-09-13', 'MMM',2,2.98,0.89,2.09),
('div_03', '2022-09-16', 'O',7,1.73,0.52,1.21),
('div_04', '2022-09-23', 'VEA',9,1.2,0.36,0.84),
('div_05', '2022-09-29', 'VNQ',6,5.5,1.65,3.85),
('div_06', '2022-09-29', 'NOBL',17,6.85,2.06,4.79),
('div_07', '2022-09-30', 'PSA',1,2,0.6,1.4),
('div_08', '2022-10-01', 'DLR',3,3.66,1.1,2.56),
('div_09', '2022-10-04', 'VOO',3,4.41,1.32,3.09),
('div_10', '2022-10-04', 'KO',8,3.52,1.06,2.46),
('div_11', '2022-10-05', 'KMB',2,2.32,0.7,1.62),
('div_12', '2022-10-08', 'HYG',1,0.51,0.15,0.36),
('div_13', '2022-10-15', 'O',7,1.74,0.52,1.22),
('div_14', '2022-10-18', 'FRT',3,3.24,0.97,2.27),
('div_15', '2022-11-01', 'JPM',1,1,0.3,0.7),
('div_16', '2022-11-02', 'T',8,1.67,0.5,1.17),
('div_17', '2022-11-08', 'HYG',1,0.41,0.12,0.29),
('div_18', '2022-11-14', 'AAPL',2,0.46,0.14,0.32),
('div_19', '2022-11-16', 'O',7,1.74,0.52,1.22),
('div_20', '2022-11-16', 'PG',1,0.91,0.27,0.64),
('div_21', '2022-11-28', 'SBUX',3,1.59,0.48,1.11),
('div_22', '2022-12-01', 'WELL',5,3.05,0.92,2.13),
('div_23', '2022-12-07', 'JNJ',2,2.26,0.68,1.58),
('div_24', '2022-12-08', 'HYG',1,0.46,0.14,0.32),
('div_25', '2022-12-08', 'TIP',2,0.26,0.08,0.18),
('div_26', '2022-12-09', 'MSFT',1,0.68,0.2,0.48),
('div_27', '2022-12-13', 'MMM',2,2.98,0.89,2.09),
('div_28', '2022-12-13', 'WBA',5,2.4,0.72,1.68),
('div_29', '2022-12-16', 'KO',8,3.52,1.06,2.46),
('div_30', '2022-12-16', 'O',7,1.74,0.52,1.22),
('div_31', '2022-12-20', 'URTH',9,7.46,2.24,5.22),
('div_32', '2022-12-22', 'HYG',1,0.57,0.17,0.4),
('div_33', '2022-12-22', 'TIP',2,0.7,0.21,0.49),
('div_34', '2022-12-23', 'VEA',9,5.38,1.61,3.77),
('div_35', '2022-12-23', 'VNQI',8,1.88,0.56,1.32),
('div_36', '2022-12-27', 'MOAT',7,4.87,1.46,3.41),
('div_37', '2022-12-27', 'VOO',3,5.02,1.51,3.51),
('div_38', '2022-12-29', 'VNQ',6,6.98,2.09,4.89),
('div_39', '2022-12-30', 'PSA',1,2,0.6,1.4),
('div_40', '2023-01-03', 'NOBL',17,10.21,3.06,7.15),
('div_41', '2023-01-05', 'KMB',2,2.32,0.7,1.62),
('div_42', '2023-01-17', 'O',7,1.74,0.52,1.22),
('div_43', '2023-01-17', 'DLR',3,3.66,1.1,2.56),
('div_44', '2023-01-18', 'FRT',3,3.24,0.97,2.27),
('div_45', '2023-02-01', 'JPM',1,1,0.3,0.7),
('div_46', '2023-02-14', 'TIP', 2, 0.46, 0.14, 0.32),
('div_47', '2023-01-08', 'WELL', 5, 3.05, 0.92, 2.13),
('div_48', '2023-01-08', 'JNJ', 2, 2.12, 0.64, 1.48),
('div_49', '2023-01-11', 'MSFT', 1, 0.62, 0.19, 0.43);

SELECT * FROM dividends;

-- Populating table transactions
INSERT INTO transactions (tdate, tticker, tquantity, tprice, tbroker_id, ttype)
VALUES
('2022-03-26','FRT',2,"71.36",'DG','Buy'),
('2022-03-26','NOBL',10,"52.55",'T212','Buy'),
('2022-03-26','PSA',1,"163.2",'DG','Buy'),
('2022-04-16','ESPO',10,"34.2",'T212','Buy'),
('2022-05-19','NOBL',7,"61.02",'T212','Buy'),
('2022-05-19','DH2O',7,"34.4",'T212','Buy'),
('2022-05-19','URTH',2,"84.32",'DG','Buy'),
('2022-05-19','VNQ',3,"67.85",'T212','Buy'),
('2022-05-19','VNQI',4,"42.73",'DG','Buy'),
('2022-05-19','VOO',1,"260.82",'T212','Buy'),
('2022-06-12','DIS',2,"121.72",'IB','Buy'),
('2022-06-12','KO',5,"48.78",'IB','Buy'),
('2022-06-12','MMM',1,"166.15",'IB','Buy'),
('2022-06-12','SBUX',3,"78.96",'IB','Buy'),
('2022-06-12','WBA',5,"44.8",'IB','Buy'),
('2022-07-16','KO',1,"45.54",'IB','Buy'),
('2022-07-16','URTH',4,"94.42",'DG','Buy'),
('2022-07-16','VOO',2,"289.63",'T212','Buy'),
('2022-08-17','JNJ',2,"147.7",'IB','Buy'),
('2022-08-17','KMB',2,"158.17",'IB','Buy'),
('2022-08-17','URTH',3,"100.53",'DG','Buy'),
('2022-08-17','VNQI',2,"49.28",'DG','Buy'),
('2022-09-09','AAPL',2,"116.28",'IB','Buy'),
('2022-09-09','O',4,"64.77",'IB','Buy'),
('2022-10-09','DLR',2,"153.79",'DG','Buy'),
('2022-10-09','FRT',1,"77.18",'DG','Buy'),
('2022-10-09','MMM',1,"166.18",'IB','Buy'),
('2022-10-09','PLD',2,"104.54",'DG', 'Buy'),
('2022-10-09','VNQ',1,"81.8",'T212','Buy'),
('2022-10-09','WELL',4,"55.93",'DG','Buy'),
('2022-11-13','O',2,"62.18",'IB','Buy'),
('2022-11-13','PLD',1,"100.01",'DG','Buy'),
('2022-11-13','WELL',1,"66.64",'DG','Buy'),
('2022-12-15','DLR',1,"128.97",'DG','Buy'),
('2022-12-15','O',1,"60.39",'IB','Buy'),
('2022-12-15','PLD',1,"96.19",'DG','Buy'),
('2022-12-17','DH2O',7,"45.31",'T212','Sell'),
('2022-12-22','MOAT',4,"62.6",'T212','Buy'),
('2022-12-22','T',"1.5","29.33",'IB','Buy'),
('2022-12-28','MOAT',1,"61.56",'T212','Buy'),
('2022-12-28','ESPO',10,"37.71",'T212','Sell'),
('2022-12-28','T',2,"28.63",'IB','Buy'),
('2022-12-30','MOAT',1,"61.56",'T212','Buy'),
('2022-12-30','T',"2.5","28.63",'IB','Buy'),
('2022-12-30','TIP',2,"127.24",'T212','Buy'),
('2022-03-02','SWAN',3,"32.3",'T212','Buy'),
('2022-03-02','VNQI',2,"55.31",'DG','Buy'),
('2022-03-03','VNQ',2,"87.02",'T212','Buy'),
('2022-03-22','PLD',4,"102.92",'DG','Sell'),
('2022-03-22','VEA',8,"49.54",'T212','Buy'),
('2022-04-16','JPM',1,"153.11",'IB','Buy'),
('2022-04-16','KO',2,"53.54",'IB','Buy'),
('2022-04-16','PG',1,"137.38",'IB','Buy'),
('2022-04-19','MSFT',1,"258.45",'IB','Buy'),
('2022-06-04','HYG',"1.45","87.25",'T212','Buy'),
('2022-06-04','SWAN',3,"33.47",'T212','Sell'),
('2022-01-03','MOAT',1,"76.07",'T212','Buy'),
('2022-03-31','VEA',1,"48.51",'T212','Buy'),
('2022-05-09','T',2,"20.03",'IB','Buy'),
('2022-07-22','VEA',1,"41.76",'T212','Buy'),
('2022-09-26','VEA',1,"36.31",'T212','Buy'),
('2022-12-19','VEA',1,"41.8",'T212','Buy');

SELECT * FROM transactions;

-- FUNCTIONS

-- Function 1: calculates totals
DELIMITER //
CREATE FUNCTION totals(quantity FLOAT, amount DECIMAL(6,2))
RETURNS DECIMAL(9,2)
DETERMINISTIC
BEGIN
DECLARE total DECIMAL(9,2);
SET total = ROUND((quantity * amount),2);
RETURN (total);
END //
DELIMITER ;

SELECT cticker AS Asset, totals(cquantity, c_avg_price) AS Total, ccurrency AS Currency
FROM current_position
ORDER BY Asset;

-- Function 2: converts currency
DELIMITER //
CREATE FUNCTION convert_currency(quantity FLOAT, amount DECIMAL(6,2), fx_rate FLOAT)
RETURNS DECIMAL(9,2)
DETERMINISTIC
BEGIN
DECLARE total_other_ccy DECIMAL(9,2);
SET total_other_ccy = ROUND(((quantity * amount) * fx_rate),2);
RETURN (total_other_ccy);
END //
DELIMITER ;

SELECT cticker as Asset, totals(cquantity, c_avg_price) AS 'Total in USD', convert_currency(cquantity, c_avg_price, 0.93) AS 'Total in EUR'
FROM current_position;

-- VIEWS

-- View 1: general view of portfolio joining 4 tables and function totals()
CREATE VIEW portfolio
AS
SELECT a.aclass AS Class, cp.cticker AS Asset, cp.cquantity AS Quantity, totals(cp.cquantity, cp.c_avg_price) AS 'Total Invested', SUM(d.net_amount) AS 'Total Dividends', cp.ccurrency AS Currency, b.bname AS Custodian
FROM current_position AS cp
JOIN brokers AS b 
ON (cp.cbroker_id = b.broker_id)
JOIN dividends AS d
ON (d.dticker = cp.cticker)
JOIN assets AS a
ON (a.aticker = cp.cticker)
GROUP BY cp.cticker
ORDER BY a.aclass DESC, cp.cticker;

SELECT * FROM portfolio;

-- View 2: total invested per class with both functions
CREATE VIEW total_per_class
AS
SELECT a.aclass as Class, SUM(totals(cp.cquantity, cp.c_avg_price)) AS 'Total Invested USD', sum(convert_currency(cp.cquantity, cp.c_avg_price, 0.93)) AS 'Total in EUR'
FROM current_position AS cp
LEFT JOIN assets AS a
ON (cp.cticker = a.aticker)
GROUP BY a.aclass
ORDER BY a.aclass;

SELECT * FROM total_per_class;

-- View 3: total transactions per month
CREATE VIEW transactions_per_month
AS
SELECT DATE_FORMAT(t.tdate, '%m-%Y') as Date, COUNT(t.transaction_id) as 'Number of Transactions', SUM(totals(t.tquantity, t.tprice)) AS 'Total Invested'
FROM transactions AS t
GROUP BY Date
ORDER BY Date;

SELECT * FROM transactions_per_month;

-- View 4: dividends received per period
CREATE VIEW div_received
AS
SELECT DATE_FORMAT(d.date, '%Y-%m') as Date, SUM(d.net_amount) AS Total
FROM dividends AS d
JOIN current_position as cp
ON cp.cticker = d.dticker
GROUP BY DATE_FORMAT(d.date, '%Y-%m')
ORDER BY DATE_FORMAT(d.date, '%Y-%m');

SELECT * FROM div_received;

-- Query dividends received per period per class
SELECT DATE_FORMAT(d.date, '%Y-%m') AS Date, a.aclass, SUM(d.net_amount) AS Total
FROM dividends AS d
JOIN current_position AS cp
ON cp.cticker = d.dticker
JOIN assets AS a
ON a.aticker = d.dticker
GROUP BY DATE_FORMAT(d.date, '%Y-%m'), a.aclass
ORDER BY DATE_FORMAT(d.date, '%Y-%m');

-- SUBQUERY: assets not in current_position
SELECT a.aticker AS Asset, a.aname AS Name
FROM assets AS a
WHERE a.aticker NOT IN (SELECT cticker FROM current_position)
ORDER BY a.aticker; 

-- STORED PROCEDURE: shows assets, quantity, average price of purchase and total invested in asset
DELIMITER //

CREATE PROCEDURE view_portfolio()
BEGIN
SELECT cp.cticker AS Asset, cp.cquantity AS Quantity, cp.c_avg_price AS 'Average Price', totals(cquantity, c_avg_price) AS 'Total'
FROM current_position AS cp
ORDER BY cp.cticker;
END //

DELIMITER ;

CALL view_portfolio();

-- Query using GROUP BY and HAVING
SELECT d.dticker AS Asset, SUM(d.net_amount) AS Total
FROM dividends AS d
GROUP BY d.dticker
HAVING Total > 5;

