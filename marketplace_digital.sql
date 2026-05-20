CREATE DATABASE IF NOT EXISTS marketplace_digital;
USE marketplace_digital;

CREATE TABLE product_categories (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE users (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(150)                              NOT NULL,
    email      VARCHAR(150)                              NOT NULL UNIQUE,
    password   VARCHAR(255)                              NOT NULL,
    role       ENUM('buyer', 'seller', 'admin')          NOT NULL DEFAULT 'buyer',
    created_at TIMESTAMP                                 NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    seller_id   INT             NOT NULL,
    category_id INT             NOT NULL,
    name        VARCHAR(200)    NOT NULL,
    description TEXT,
    price       DECIMAL(12, 2)  NOT NULL DEFAULT 0.00,
    stock       INT             NOT NULL DEFAULT 0,
    file_url    VARCHAR(500),
    created_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_product_seller   FOREIGN KEY (seller_id)   REFERENCES users(id),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES product_categories(id)
);

CREATE TABLE transactions (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    buyer_id         INT            NOT NULL,
    product_id       INT            NOT NULL,
    amount           DECIMAL(12, 2) NOT NULL,
    status           ENUM('pending', 'success', 'failed') NOT NULL DEFAULT 'pending',
    transaction_date TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transaction_buyer   FOREIGN KEY (buyer_id)   REFERENCES users(id),
    CONSTRAINT fk_transaction_product FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO product_categories (name, description) VALUES
('E-book',           'Buku digital dalam format PDF, ePub, atau MOBI'),
('Template Desain',  'Template siap pakai untuk Figma, Canva, Adobe XD'),
('Source Code',      'Kode sumber aplikasi web, mobile, atau desktop'),
('UI Kit',           'Komponen antarmuka pengguna untuk desainer'),
('Preset & Filter',  'Preset Lightroom, LUTS video, dan filter foto'),
('Audio Digital',    'Sound effect, musik latar, dan beat original'),
('Video Digital',    'Stock footage, intro animasi, dan motion graphic'),
('Font & Typeface',  'Koleksi huruf premium untuk desainer'),
('Plugin & Addon',   'Plugin untuk Figma, Photoshop, dan tools desain lain'),
('Spreadsheet',      'Template Excel dan Google Sheets siap pakai'),
('Kursus Digital',   'Materi belajar dalam bentuk PDF atau slide'),
('3D Asset',         'Model 3D untuk Blender, Unity, dan Unreal Engine');

INSERT INTO users (name, email, password, role) VALUES
('Andi Pratama',    'andi@gmail.com',    'hash_andi123',   'seller'),
('Budi Santoso',    'budi@gmail.com',    'hash_budi456',   'seller'),
('Citra Dewi',      'citra@gmail.com',   'hash_citra789',  'seller'),
('Dian Rahayu',     'dian@gmail.com',    'hash_dian321',   'buyer'),
('Eko Wijaya',      'eko@gmail.com',     'hash_eko654',    'buyer'),
('Fitri Handayani', 'fitri@gmail.com',   'hash_fitri987',  'buyer'),
('Galih Nugroho',   'galih@gmail.com',   'hash_galih111',  'buyer'),
('Hani Lestari',    'hani@gmail.com',    'hash_hani222',   'seller'),
('Irfan Maulana',   'irfan@gmail.com',   'hash_irfan333',  'buyer'),
('Joko Susilo',     'joko@gmail.com',    'hash_joko444',   'seller'),
('Karin Putri',     'karin@gmail.com',   'hash_karin555',  'buyer'),
('Luki Firmansyah', 'luki@gmail.com',    'hash_luki666',   'buyer'),
('Maya Sari',       'maya@gmail.com',    'hash_maya777',   'seller'),
('Nanda Kurnia',    'nanda@gmail.com',   'hash_nanda888',  'buyer'),
('Admin Sistem',    'admin@market.com',  'hash_admin999',  'admin');

INSERT INTO products (seller_id, category_id, name, description, price, stock, file_url) VALUES
(1,  3, 'Starter Kit Laravel 11 + React',       'Boilerplate fullstack siap deploy',         150000.00, 50, '/files/laravel-react-kit.zip'),
(1,  3, 'REST API Template dengan JWT Auth',     'Template API dengan autentikasi JWT',         85000.00, 30, '/files/api-jwt-template.zip'),
(2,  2, 'Social Media Template Pack Canva',      '50 template konten medsos siap edit',         75000.00, 100,'/files/canva-sosmed-pack.zip'),
(2,  4, 'UI Kit Dashboard Admin Dark Mode',      'Komponen Figma untuk dashboard modern',       120000.00, 80, '/files/ui-kit-dark.fig'),
(3,  1, 'Panduan Belajar Docker & Kubernetes',   'E-book 200 halaman untuk DevOps pemula',      95000.00, 999,'/files/docker-k8s-ebook.pdf'),
(3,  1, 'Clean Code untuk Developer Indonesia',  'Prinsip penulisan kode yang baik dan bersih', 65000.00, 999,'/files/clean-code-id.pdf'),
(8,  5, 'Lightroom Preset Cinematic Pack',       '30 preset gaya sinematik untuk foto',         55000.00, 200,'/files/lightroom-cinematic.zip'),
(8,  6, 'Sound Effect Pack UI/UX',               '100 sound effect untuk aplikasi digital',     45000.00, 500,'/files/sfx-uiux.zip'),
(10, 7, 'Logo Reveal Animation Template',        'Intro animasi logo format After Effects',     180000.00, 40, '/files/logo-reveal.aep'),
(10, 3, 'Spring Boot Microservice Template',     'Template microservice dengan Docker Compose',  200000.00, 25, '/files/springboot-micro.zip'),
(13, 8, 'Premium Font Bundle — 10 Typeface',     'Koleksi 10 font premium lisensi komersial',   130000.00, 999,'/files/font-bundle-premium.zip'),
(13, 9, 'Figma Plugin — Auto Layout Helper',     'Plugin mempercepat workflow desain Figma',    600000.00, 0,  '/files/figma-autolayout.zip'),
(1,  10,'Laporan Keuangan Template Excel',       'Template laporan bulanan dan tahunan',          35000.00, 999,'/files/laporan-keuangan.xlsx'),
(2,  12,'Low Poly Tree Pack — Blender',           'Aset pohon low poly siap render',             90000.00, 60, '/files/lowpoly-trees.blend'),
(13, 11,'Modul Belajar SQL dari Nol',             'Materi belajar SQL lengkap dengan latihan',    70000.00, 999,'/files/modul-sql.pdf');

INSERT INTO transactions (buyer_id, product_id, amount, status) VALUES
(4,  1,  150000.00, 'success'),
(4,  5,   95000.00, 'success'),
(5,  3,   75000.00, 'success'),
(5,  7,   55000.00, 'success'),
(6,  2,   85000.00, 'success'),
(6,  6,   45000.00, 'pending'),
(7,  4,  120000.00, 'success'),
(7,  10, 200000.00, 'success'),
(9,  11, 130000.00, 'success'),
(9,  8,   45000.00, 'failed'),
(11, 13,  35000.00, 'success'),
(11, 15,  70000.00, 'success'),
(12, 9,  180000.00, 'success'),
(14, 12, 600000.00, 'pending'),
(14, 14,  90000.00, 'success');

-- SQL Fundamentals
SELECT * FROM products;

-- Tampilkan nama dan harga produk saja
SELECT name, price
FROM products;

-- Tampilkan produk dengan harga antara 50.000 sampai 200.000.
SELECT name, price
FROM products
WHERE price BETWEEN 50000 AND 200000;

-- Tampilkan produk yang memiliki stok 0 ATAU harga di atas 500.000.
SELECT name, price, stock
FROM products
WHERE stock = 0 OR price > 500000;

-- Tampilkan 5 produk dengan harga tertinggi.
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 5;


-- Aggregate & Conditional Logic 
-- Hitung total user yang terdaftar.
SELECT COUNT(*) AS total_user
FROM users;

-- Hitung total produk yang tersedia.
SELECT COUNT(*) AS total_produk
FROM products;

-- Hitung jumlah Produk per kategori 
SELECT
    pc.name          AS kategori,
    COUNT(p.id)      AS jumlah_produk
FROM product_categories pc
LEFT JOIN products p ON p.category_id = pc.id
GROUP BY pc.id, pc.name
ORDER BY jumlah_produk DESC;

-- Hitung rata-rata harga produk per kategori.
SELECT
    pc.name              AS kategori,
    ROUND(AVG(p.price), 2) AS rata_rata_harga
FROM product_categories pc
LEFT JOIN products p ON p.category_id = pc.id
GROUP BY pc.id, pc.name
ORDER BY rata_rata_harga DESC;

-- Tampilkan kategori yang memiliki lebih dari 3 produk.
SELECT
    pc.name     AS kategori,
    COUNT(p.id) AS jumlah_produk
FROM product_categories pc
JOIN products p ON p.category_id = pc.id
GROUP BY pc.id, pc.name
HAVING COUNT(p.id) > 3;

-- Join Statements
-- Tampilkan daftar produk beserta nama kategorinya.
SELECT
    p.name     AS nama_produk,
    p.price,
    pc.name    AS kategori
FROM products p
INNER JOIN product_categories pc ON pc.id = p.category_id;

-- Tampilkan semua kategori meskipun belum memiliki produk.
SELECT
    pc.name           AS kategori,
    COUNT(p.id)       AS jumlah_produk
FROM product_categories pc
LEFT JOIN products p ON p.category_id = pc.id
GROUP BY pc.id, pc.name;

-- Tampilkan semua user meskipun belum pernah membeli produk.
SELECT
    u.name                      AS nama_user,
    u.role,
    COUNT(t.id)                 AS total_transaksi
FROM users u
LEFT JOIN transactions t ON t.buyer_id = u.id
GROUP BY u.id, u.name, u.role;

-- Tampilkan daftar transaksi beserta nama buyer.
SELECT
    t.id                 AS id_transaksi,
    u.name               AS nama_buyer,
    t.amount,
    t.status,
    t.transaction_date
FROM transactions t
INNER JOIN users u ON u.id = t.buyer_id;

-- Tampilkan daftar produk beserta nama user yang mengupload produk tersebut.
SELECT
    p.name       AS nama_produk,
    p.price,
    u.name       AS nama_seller
FROM products p
INNER JOIN users u ON u.id = p.seller_id;