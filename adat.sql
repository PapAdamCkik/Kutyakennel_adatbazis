-- Create database
CREATE DATABASE IF NOT EXISTS kennel_pa CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE kennel_pa;

-- Create Kenel (Kennels) table
CREATE TABLE Kenel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    cim VARCHAR(200),
    ContactNev VARCHAR(100),
    Telefonszam VARCHAR(20)
);

-- Create Fajta (Breeds) table
CREATE TABLE Fajta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(100) NOT NULL
);

-- Create Vevok (Buyers) table
CREATE TABLE Vevok (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefonszam VARCHAR(20)
);

-- Create SzuloKutyak (Adult/Parent Dogs) table
CREATE TABLE SzuloKutyak (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    fajtaId INT NOT NULL,
    szin VARCHAR(50),
    nem VARCHAR(10) NOT NULL,
    kenelId INT NOT NULL,
    FOREIGN KEY (fajtaId) REFERENCES Fajta(id),
    FOREIGN KEY (kenelId) REFERENCES Kenel(id)
);

-- Create Almok (Litters) table
CREATE TABLE Almok (
    id INT AUTO_INCREMENT PRIMARY KEY,
    AnyaId INT NOT NULL,
    ApaId INT NOT NULL,
    datum DATE NOT NULL,
    FOREIGN KEY (AnyaId) REFERENCES SzuloKutyak(id),
    FOREIGN KEY (ApaId) REFERENCES SzuloKutyak(id)
);

-- Create KisKutyak (Puppies) table
CREATE TABLE KisKutyak (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(100),
    szin VARCHAR(50),
    AlomId INT NOT NULL,
    VevoId INT,
    FOREIGN KEY (AlomId) REFERENCES Almok(id),
    FOREIGN KEY (VevoId) REFERENCES Vevok(id)
);

-- Create Betegsegek (Diseases) table
CREATE TABLE Betegsegek (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kisKutyaId INT NOT NULL,
    nev VARCHAR(100) NOT NULL,
    FOREIGN KEY (kisKutyaId) REFERENCES KisKutyak(id)
);

-- Create oltasok (Vaccinations) table
CREATE TABLE oltasok (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kisKutyaId INT NOT NULL,
    vakcinaNev VARCHAR(100) NOT NULL,
    Datum DATE NOT NULL,
    IdopontDatum DATE,
    FOREIGN KEY (kisKutyaId) REFERENCES KisKutyak(id)
);

-- Create orvosLatogatas (Veterinary Visits) table
CREATE TABLE orvosLatogatas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kisKutyaId INT NOT NULL,
    datum DATE NOT NULL,
    orvosNev VARCHAR(100),
    ar DECIMAL(10,2),
    FOREIGN KEY (kisKutyaId) REFERENCES KisKutyak(id)
);

-- Create szerzodesek (Contracts) table
CREATE TABLE szerzodesek (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kisKutyaId INT NOT NULL,
    ar DECIMAL(10,2),
    datum DATE NOT NULL,
    FOREIGN KEY (kisKutyaId) REFERENCES KisKutyak(id)
);

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

-- Insert Kennels
INSERT INTO Kenel (nev, cim, ContactNev, Telefonszam) VALUES
('Aranymancs Tenyészet', 'Budapest, Fehérvári út 123', 'Nagy Katalin', '+36 20 123 4567'),
('Kékszalag Kennel', 'Debrecen, Piac utca 45', 'Kovács János', '+36 30 987 6543'),
('Ezüsthegy Tenyészet', 'Szeged, Tisza part 78', 'Szabó Péter', '+36 70 555 1234'),
('Bajnok Kutyák', 'Pécs, Rákóczi út 56', 'Farkas Ilona', '+36 20 444 5555'),
('Vadász Kennel', 'Győr, Hunyadi utca 12', 'Balogh Ferenc', '+36 30 666 7777');

-- Insert Breeds
INSERT INTO Fajta (nev) VALUES
('Labrador Retriever'),
('Golden Retriever'),
('Német Juhász'),
('Beagle'),
('Tacskó'),
('Border Collie'),
('Vizsla'),
('Puli');

-- Insert Buyers
INSERT INTO Vevok (nev, email, telefonszam) VALUES
('Tóth Anna', 'toth.anna@email.hu', '+36 20 111 2222'),
('Kiss Gábor', 'kiss.gabor@email.hu', '+36 30 333 4444'),
('Horváth Eszter', 'horvath.eszter@email.hu', '+36 70 555 6666'),
('Molnár István', 'molnar.istvan@email.hu', '+36 20 777 8888'),
('Varga Mónika', 'varga.monika@email.hu', '+36 30 999 0000'),
('Lakatos Márk', 'lakatos.mark@email.hu', '+36 20 222 3333'),
('Németh Júlia', 'nemeth.julia@email.hu', '+36 30 444 5555'),
('Sipos Tamás', 'sipos.tamas@email.hu', '+36 70 666 7777'),
('Fekete Zsófia', 'fekete.zsofia@email.hu', '+36 20 888 9999'),
('Papp Levente', 'papp.levente@email.hu', '+36 30 101 1010');

-- Insert Adult Dogs (Parent Dogs)
INSERT INTO SzuloKutyak (nev, fajtaId, szin, nem, kenelId) VALUES
('Bella', 1, 'fekete', 'nőstény', 1),
('Luna', 2, 'arany', 'nőstény', 1),
('Zsófi', 3, 'barna-fekete', 'nőstény', 1),
('Rózsa', 6, 'fekete-fehér', 'nőstény', 1),
('Csilla', 7, 'vörös-arany', 'nőstény', 1),
('Max', 1, 'sárga', 'kan', 2),
('Bruno', 2, 'arany', 'kan', 2),
('Rex', 3, 'fekete-barna', 'kan', 3),
('Bors', 6, 'fekete-fehér', 'kan', 4),
('Csaba', 7, 'vörös', 'kan', 5),
('Arany', 2, 'krém', 'nőstény', 2),
('Napsugár', 2, 'arany', 'kan', 2),
('Honey', 2, 'arany', 'nőstény', 3),
('Mézeskalács', 2, 'vörös-arany', 'kan', 3),
('Csoda', 2, 'krém', 'nőstény', 4),
('Aranyhaj', 2, 'arany', 'kan', 4),
('Mokka', 1, 'barna', 'kan', 1),
('Csillag', 3, 'fekete', 'kan', 1),
('Vadász', 7, 'vörös', 'kan', 1);

-- Insert Litters
INSERT INTO Almok (AnyaId, ApaId, datum) VALUES
(1, 6, '2025-01-15'),
(2, 7, '2025-02-20'),
(3, 8, '2025-03-10'),
(4, 9, '2024-11-05'),
(5, 10, '2024-12-20'),
(1, 6, '2024-08-12'),
(1, 17, '2025-04-10'),
(2, 17, '2025-03-25'),
(3, 18, '2025-02-15'),
(5, 19, '2025-01-30');

-- Insert Puppies
INSERT INTO KisKutyak (nev, szin, AlomId, VevoId) VALUES
-- Litter 1 (Bella + Max - 2025-01-15)
('Csoki', 'fekete', 1, 1),
('Mogyoró', 'sárga', 1, 2),
('Pötyi', 'fekete', 1, NULL),
('Bundás', 'sárga', 1, 3),
('Csillag', 'fekete', 1, NULL),

-- Litter 2 (Luna + Bruno - 2025-02-20)
('Arany', 'arany', 2, NULL),
('Napfény', 'arany', 2, 4),
('Csillag', 'krém', 2, NULL),
('Bolyhos', 'arany', 2, 6),

-- Litter 3 (Zsófi + Rex - 2025-03-10)
('Sas', 'fekete-barna', 3, 5),
('Villám', 'fekete-barna', 3, NULL),
('Herkó', 'barna', 3, NULL),
('Farkas', 'fekete', 3, 7),

-- Litter 4 (Rózsa + Bors - 2024-11-05)
('Fürge', 'fekete-fehér', 4, 8),
('Villám', 'fekete-fehér', 4, 9),
('Gyors', 'fehér-fekete', 4, NULL),
('Pici', 'fekete-fehér', 4, 10),
('Mackó', 'fekete-fehér', 4, NULL),

-- Litter 5 (Csilla + Csaba - 2024-12-20)
('Réz', 'vörös', 5, 1),
('Napsugár', 'vörös-arany', 5, NULL),
('Rozsdás', 'vörös', 5, 2),
('Tűz', 'vörös-arany', 5, NULL),

-- Litter 6 (Bella + Max - 2024-08-12 - older litter)
('Fekete', 'fekete', 6, 3),
('Sárga', 'sárga', 6, 4),
('Barna', 'barna', 6, 5),
('Cirmos', 'fekete-sárga', 6, NULL),

-- Litter 7 (Bella + Mokka - 2025-04-10 - SAME KENNEL)
('Kormos', 'fekete', 7, 6),
('Éjszaka', 'fekete', 7, 7),
('Szénás', 'barna', 7, 8),

-- Litter 8 (Luna + Mokka - 2025-03-25 - SAME KENNEL)
('Aranybarna', 'arany-barna', 8, 9),
('Mézecske', 'arany', 8, 10),

-- Litter 9 (Zsófi + Csillag - 2025-02-15 - SAME KENNEL)
('Sötét', 'fekete', 9, 1),
('Árnyék', 'barna-fekete', 9, 2),

-- Litter 10 (Csilla + Vadász - 2025-01-30 - SAME KENNEL)
('Rőt', 'vörös', 10, 3),
('Vörös', 'vörös-arany', 10, 4);

-- Insert Diseases
INSERT INTO Betegsegek (kisKutyaId, nev) VALUES
(2, 'Csípőficam'),
(5, 'Fülgyulladás'),
(10, 'Köhögés'),
(14, 'Allergia'),
(15, 'Bőrbetegség'),
(18, 'Fülgyulladás'),
(22, 'Emésztési probléma'),
(25, 'Csípőficam'),
(2, 'Allergia'),
(10, 'Bőrbetegség');

-- Insert Vaccinations
INSERT INTO oltasok (kisKutyaId, vakcinaNev, Datum, IdopontDatum) VALUES
(1, 'Veszettség', '2025-03-15', '2026-03-15'),
(1, 'Parvo vírus', '2025-03-15', '2026-03-15'),
(2, 'Veszettség', '2025-03-20', '2026-03-20'),
(4, 'Veszettség', '2025-03-18', '2026-03-18'),
(4, 'Parvo vírus', '2025-03-18', '2026-03-18'),
(7, 'Veszettség', '2025-04-25', '2026-04-25'),
(10, 'Veszettség', '2025-05-10', '2026-05-10'),
(14, 'Veszettség', '2025-01-20', '2026-01-20'),
(14, 'Parvo vírus', '2025-01-20', '2026-01-20'),
(15, 'Veszettség', '2025-01-25', '2026-01-25'),
(17, 'Veszettség', '2025-02-10', '2026-02-10'),
(17, 'Leptospirózis', '2025-02-10', '2026-02-10'),
(21, 'Veszettség', '2025-03-01', '2026-03-01'),
(21, 'Parvo vírus', '2025-03-01', '2026-03-01'),
(24, 'Veszettség', '2024-10-15', '2025-10-15'),
(24, 'Parvo vírus', '2024-10-15', '2025-10-15'),
(25, 'Veszettség', '2024-10-20', '2025-10-20'),
(26, 'Veszettség', '2024-10-25', '2025-10-25'),
(26, 'Leptospirózis', '2024-10-25', '2025-10-25');

-- Insert Veterinary Visits
INSERT INTO orvosLatogatas (kisKutyaId, datum, orvosNev, ar) VALUES
(1, '2025-03-15', 'Dr. Szabó Éva', 15000.00),
(2, '2025-03-20', 'Dr. Kiss Tamás', 18000.00),
(2, '2025-04-10', 'Dr. Kiss Tamás', 12000.00),
(4, '2025-03-18', 'Dr. Szabó Éva', 15000.00),
(5, '2025-04-22', 'Dr. Nagy László', 20000.00),
(10, '2025-05-10', 'Dr. Tóth Márta', 16000.00),
(14, '2025-01-20', 'Dr. Szabó Éva', 14000.00),
(15, '2025-01-25', 'Dr. Kiss Tamás', 17000.00),
(15, '2025-02-15', 'Dr. Kiss Tamás', 13000.00),
(17, '2025-02-10', 'Dr. Nagy László', 15000.00),
(18, '2025-03-05', 'Dr. Tóth Márta', 19000.00),
(21, '2025-03-01', 'Dr. Szabó Éva', 16000.00),
(22, '2025-03-12', 'Dr. Kiss Tamás', 21000.00),
(24, '2024-10-15', 'Dr. Nagy László', 14000.00),
(25, '2024-10-20', 'Dr. Szabó Éva', 18000.00),
(25, '2024-11-10', 'Dr. Szabó Éva', 12000.00),
(26, '2024-10-25', 'Dr. Tóth Márta', 15000.00);

-- Insert Contracts
INSERT INTO szerzodesek (kisKutyaId, ar, datum) VALUES
(1, 250000.00, '2025-04-01'),
(2, 280000.00, '2025-04-15'),
(4, 260000.00, '2025-04-10'),
(7, 300000.00, '2025-05-20'),
(10, 320000.00, '2025-06-05'),
(14, 290000.00, '2025-02-10'),
(15, 295000.00, '2025-02-15'),
(17, 310000.00, '2025-03-08'),
(21, 275000.00, '2025-04-12'),
(24, 285000.00, '2024-11-20'),
(25, 270000.00, '2024-11-25'),
(26, 280000.00, '2024-11-28'),
(9, 305000.00, '2025-05-15');