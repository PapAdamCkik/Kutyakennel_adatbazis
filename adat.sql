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
('Ezüsthegy Tenyészet', 'Szeged, Tisza part 78', 'Szabó Péter', '+36 70 555 1234');

-- Insert Breeds
INSERT INTO Fajta (nev) VALUES
('Labrador Retriever'),
('Golden Retriever'),
('Német Juhász'),
('Beagle'),
('Tacskó');

-- Insert Buyers
INSERT INTO Vevok (nev, email, telefonszam) VALUES
('Tóth Anna', 'toth.anna@email.hu', '+36 20 111 2222'),
('Kiss Gábor', 'kiss.gabor@email.hu', '+36 30 333 4444'),
('Horváth Eszter', 'horvath.eszter@email.hu', '+36 70 555 6666'),
('Molnár István', 'molnar.istvan@email.hu', '+36 20 777 8888'),
('Varga Mónika', 'varga.monika@email.hu', '+36 30 999 0000');

-- Insert Adult Dogs (Parent Dogs)
INSERT INTO SzuloKutyak (nev, fajtaId, szin, nem, kenelId) VALUES
('Bella', 1, 'fekete', 'nőstény', 1),
('Luna', 2, 'arany', 'nőstény', 1),
('Zsófi', 3, 'barna-fekete', 'nőstény', 1),
('Max', 1, 'sárga', 'kan', 2),
('Bruno', 2, 'arany', 'kan', 2),
('Rex', 3, 'fekete-barna', 'kan', 3);

-- Insert Litters
INSERT INTO Almok (AnyaId, ApaId, datum) VALUES
(1, 4, '2025-01-15'),
(2, 5, '2025-02-20'),
(3, 6, '2025-03-10');

-- Insert Puppies
INSERT INTO KisKutyak (nev, szin, AlomId, VevoId) VALUES
('Csoki', 'fekete', 1, 1),
('Mogyoró', 'sárga', 1, 2),
('Pötyi', 'fekete', 1, NULL),
('Bundás', 'sárga', 1, 3),
('Arany', 'arany', 2, NULL),
('Napfény', 'arany', 2, 4),
('Csillag', 'krém', 2, NULL),
('Sas', 'fekete-barna', 3, 5),
('Villám', 'fekete-barna', 3, NULL),
('Herkó', 'barna', 3, NULL);

-- Insert Diseases
INSERT INTO Betegsegek (kisKutyaId, nev) VALUES
(2, 'Csípőficam'),
(5, 'Fülgyulladás'),
(8, 'Köhögés');

-- Insert Vaccinations
INSERT INTO oltasok (kisKutyaId, vakcinaNev, Datum, IdopontDatum) VALUES
(1, 'Veszettség', '2025-03-15', '2026-03-15'),
(1, 'Parvo vírus', '2025-03-15', '2026-03-15'),
(2, 'Veszettség', '2025-03-20', '2026-03-20'),
(4, 'Veszettség', '2025-03-18', '2026-03-18'),
(4, 'Parvo vírus', '2025-03-18', '2026-03-18'),
(6, 'Veszettség', '2025-04-25', '2026-04-25'),
(8, 'Veszettség', '2025-05-10', '2026-05-10');

-- Insert Veterinary Visits
INSERT INTO orvosLatogatas (kisKutyaId, datum, orvosNev, ar) VALUES
(1, '2025-03-15', 'Dr. Szabó Éva', 15000.00),
(2, '2025-03-20', 'Dr. Kiss Tamás', 18000.00),
(2, '2025-04-10', 'Dr. Kiss Tamás', 12000.00),
(4, '2025-03-18', 'Dr. Szabó Éva', 15000.00),
(5, '2025-04-22', 'Dr. Nagy László', 20000.00),
(8, '2025-05-10', 'Dr. Tóth Márta', 16000.00);

-- Insert Contracts
INSERT INTO szerzodesek (kisKutyaId, ar, datum) VALUES
(1, 250000.00, '2025-04-01'),
(2, 280000.00, '2025-04-15'),
(4, 260000.00, '2025-04-10'),
(6, 300000.00, '2025-05-20'),
(8, 320000.00, '2025-06-05');
