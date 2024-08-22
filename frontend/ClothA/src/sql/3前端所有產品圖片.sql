UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic)
WHERE id = 1;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic)
WHERE id = 2;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic)
WHERE id = 3;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic)
WHERE id = 4;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic)
WHERE id = 5;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic)
WHERE id = 6;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic)
WHERE id = 7;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic)
WHERE id = 8;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\1-3.jpg', Single_Blob) AS pic)
WHERE id = 9;


UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic)
WHERE id = 10;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic)
WHERE id = 11;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic)
WHERE id = 12;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic)
WHERE id = 13;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic)
WHERE id = 14;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic)
WHERE id = 15;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic)
WHERE id = 16;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic)
WHERE id = 17;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\2-3.jpg', Single_Blob) AS pic)
WHERE id = 18;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic)
WHERE id = 19;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic)
WHERE id = 20;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic)
WHERE id = 21;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic)
WHERE id = 22;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic)
WHERE id = 23;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic)
WHERE id = 24;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic)
WHERE id = 25;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic)
WHERE id = 26;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\3-3.jpg', Single_Blob) AS pic)
WHERE id = 27;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic)
WHERE id = 28;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic)
WHERE id = 29;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic)
WHERE id = 30;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic)
WHERE id = 31;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic)
WHERE id = 32;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic)
WHERE id = 33;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic)
WHERE id = 34;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic)
WHERE id = 35;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\4-3.jpg', Single_Blob) AS pic)
WHERE id = 36;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic)
WHERE id = 37;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic)
WHERE id = 38;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic)
WHERE id = 39;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic)
WHERE id = 40;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic)
WHERE id = 41;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic)
WHERE id = 42;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic)
WHERE id = 43;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic)
WHERE id = 44;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\5-3.jpg', Single_Blob) AS pic)
WHERE id = 45;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic)
WHERE id = 46;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic)
WHERE id = 47;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic)
WHERE id = 48;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic)
WHERE id = 49;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic)
WHERE id = 50;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic)
WHERE id = 51;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic)
WHERE id = 52;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic)
WHERE id = 53;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\6-3.jpg', Single_Blob) AS pic)
WHERE id = 54;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic)
WHERE id = 55;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic)
WHERE id = 56;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic)
WHERE id = 57;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic)
WHERE id = 58;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic)
WHERE id = 59;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic)
WHERE id = 60;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic)
WHERE id = 61;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic)
WHERE id = 62;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\7-3.jpg', Single_Blob) AS pic)
WHERE id = 63;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic)
WHERE id = 64;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic)
WHERE id = 65;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic)
WHERE id = 66;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic)
WHERE id = 67;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic)
WHERE id = 68;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic)
WHERE id = 69;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic)
WHERE id = 70;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic)
WHERE id = 71;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\8-3.jpg', Single_Blob) AS pic)
WHERE id = 72;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic)
WHERE id = 73;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic)
WHERE id = 74;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic)
WHERE id = 75;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic)
WHERE id = 76;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic)
WHERE id = 77;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic)
WHERE id = 78;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic)
WHERE id = 79;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic)
WHERE id = 80;

UPDATE product
SET 
    img = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic),
    img2 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-1.jpg', Single_Blob) AS pic),
    img3 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-2.jpg', Single_Blob) AS pic),
    img4 = (SELECT BulkColumn FROM Openrowset(Bulk 'C:\images\insertproduct\9-3.jpg', Single_Blob) AS pic)
WHERE id = 81;

