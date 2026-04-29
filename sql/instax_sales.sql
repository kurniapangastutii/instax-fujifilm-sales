---creating table
CREATE TABLE instax_sales_raw (
    tanggal TEXT,
    tahun BIGINT,
    bulan BIGINT,
    hari TEXT,
    kategori TEXT,
    nama_produk TEXT,
    lokasi_toko TEXT,
    metode_bayar TEXT,
    harga_satuan BIGINT,
    qty BIGINT,
    diskon_idr BIGINT,
    total_penjualan BIGINT
);

---read dataset
SELECT *
FROM instax_sales_raw
LIMIT 5;

---data cleaning: changing data types
ALTER TABLE instax_sales_raw
ALTER COLUMN tanggal TYPE DATE USING tanggal::DATE,
ALTER COLUMN hari TYPE VARCHAR USING hari:: VARCHAR,
ALTER COLUMN kategori TYPE VARCHAR USING kategori:: VARCHAR,
ALTER COLUMN nama_produk TYPE VARCHAR USING nama_produk:: VARCHAR,
ALTER COLUMN lokasi_toko TYPE VARCHAR USING lokasi_toko:: VARCHAR;

---checking data types
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'instax_sales_raw';

---changing metode_bayar data type
ALTER TABLE instax_sales_raw
ALTER COLUMN metode_bayar TYPE VARCHAR USING metode_bayar::VARCHAR;

---checking data types
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'instax_sales_raw';

---checking missing_values
SELECT 
COUNT(*)
FROM instax_sales_raw
WHERE tanggal IS NULL;

---preparing data
SELECT tahun,
min(bulan) AS longest_month,
max(bulan) AS latest_month
FROM instax_sales_raw
GROUP BY 1
ORDER BY 1,2,3;

---filtering data only for 2023-2025
CREATE TABLE sales_2023_2025 AS
SELECT *
FROM instax_sales_raw
WHERE tahun > 2022;

---final check
SELECT tahun,
min(bulan) AS longest_month,
max(bulan) AS latest_month
FROM sales_2023_2025
GROUP BY 1
ORDER BY 1,2,3;

---checking data types
SELECT 
MAX(tahun)
FROM sales_2023_2025;